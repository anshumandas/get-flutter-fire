/* eslint-disable curly */
/* eslint-disable object-curly-spacing */
/* eslint-disable prefer-arrow-callback */
/* eslint-disable space-before-function-paren */
/* eslint-disable indent */
/* eslint-disable block-spacing */
/* eslint-disable brace-style */
/* eslint-disable no-var */
/* eslint-disable no-invalid-this */
/* eslint-disable valid-jsdoc */
/* eslint-disable camelcase */
/* eslint-disable require-jsdoc */
/* eslint-disable max-len */

import { debug } from "firebase-functions/logger";
import { auth as functionAuth } from "firebase-functions";
import admin from "firebase-admin";
import { config, auth } from "./init";
import { UserRecord } from "firebase-admin/auth";
import { AuthUserRecord, AuthEventContext } from "firebase-functions/lib/common/providers/identity";
import { connectAuthEmulator, sendEmailVerification, signInWithCustomToken } from "firebase/auth";

const addUser = functionAuth.user().onCreate(async (user, context) => {
  // This is used to provide admin role to the first user that gets created
  debug("added user: ", user);
  if (user.customClaims?.status == "creating") { // this is using client side to send the verification mail
    admin.auth().setCustomUserClaims(user.uid, { status: "created" });
  } else if (!config.useCustomeVerificationEmail && user && user.email && !user.emailVerified) {
    // this is client side module and can create issues with server side quota limits
    await sendVerificationEmail(user, context);
  }
});
async function checkUserExistsSendVerification(user: AuthUserRecord, context: AuthEventContext): Promise<UserRecord | null> {
  var email: String = user.email!;
  if (!email.endsWith(".verify")) return null;
  try {
    const userRecord = await admin.auth().getUserByEmail(email.substring(0, email.length - 7));
    debug("existing user: ", user);
    // we could save the last email sent time in another DB to stop multiple sends
    await sendVerificationEmail(userRecord, context);
    return userRecord;
  } catch (e) {
    return null;
  }
}
const beforeUserCreated = functionAuth.user().beforeCreate(async (user, context): Promise<any> => {
  if (!(user && user.email)) {
    throw new functionAuth.HttpsError(
      "invalid-argument", `Email is required`);
  }
  // if same email exists then it does not reach here
  const rec = await checkUserExistsSendVerification(user, context);
  if (rec != null) {
    throw new functionAuth.HttpsError("already-exists", `Verification Email Sent`);
  } else {
    // Only users of a specific domain can sign up.
    // if(!user.email.includes("@acme.com")) {
    //   throw new functionAuth.HttpsError("invalid-argument", "Unauthorized email");
    // }
    if (config.adminEmail && config.adminEmail == user.email) {
      return {
        displayName: "Admin",
        customClaims: { "role": "admin" },
        emailVerified: true, // admin is auto verified
      };
    } else if (!config.adminEmail) {
      // ake the first user admin if admin email is not specified in config
      const listUsersResult = await admin.auth().listUsers(2);
      if (listUsersResult.users.length == 0) {
        return {
          displayName: "Admin",
          customClaims: { "role": "admin" },
          emailVerified: true, // admin is auto verified
        };
      }
    }
    if (!user.emailVerified && config.useCustomeVerificationEmail) {
      await sendVerificationEmail(user, context);
    } else if (!user.emailVerified) {
      // This could be useful if SignUp flow has other pages to take post email registeration details
      return {
        customClaims: { status: "creating" }, // set "creating" if you want to use client side for sending the verification mail instead of server side on SignUp.
        // sessionClaims: {status: "creating"}, // this does not propogate and thus using customClaims
      };
    }
  }
});
const beforeSignIn = functionAuth.user().beforeSignIn((user, _context) => {
  debug(_context);
  // custom token by passes this method
  if (user.disabled) {
    throw new functionAuth.HttpsError(
      "permission-denied", `"${user.email}" has been disabled by admin.`);
  }
  if (user.email && !user.emailVerified) {
    if (!(user.customClaims?.status == "creating")) {
      throw new functionAuth.HttpsError(
        "unauthenticated", `"${user.email}" needs to be verified before access is granted.`);
    } else {
      return {
        customClaims: { status: "registering" },
      };
    }
  }
  return {};
});

// TODO: use the below to verify auth token before any CRUD requests in a middleware
const verifyIdToken = function (idToken: string) {
  admin.auth().verifyIdToken(idToken).then((decodedToken) => {
    if (decodedToken.email_verified) {
      // Email verified. Grant access.
    } else {
      // Email not verified. Ask user to verify email in error response
    }
  });
};
/**
 * Used to send email from server side
 * @param {*} user
 * @param {*} context
 */

async function sendVerificationEmail(user: any, context: any) {
  if (!config.useCustomeVerificationEmail) {
    // If using Emulator don't forget to add this
    const emulator = process.env.FUNCTIONS_EMULATOR === "true";
    const customToken = await admin.auth().createCustomToken(user.uid, user.customClaims);
    // debug(customToken);
    if (config.useClientSDK) {
      // This is a hack to use client side email sending function at server side, suggested in stackOverflow
      try {
        if (emulator) {
          connectAuthEmulator(auth, "http://localhost:9099");
        }
      } catch (error) {
        /* this might happen if already connected */
      }
      signInWithCustomToken(auth, customToken).then(
        async (credential) => {
          const firebaseUser = credential.user;
          await sendEmailVerification(firebaseUser);
          auth.signOut().then(() => {
            // Sign-out successful.
            console.log("signed out success");
          }, () => {
          });
        });
    } else {
      // better and cleaner approach, however it cannot be tested in Emulator
      // TODO test the below in live Firebase
      try {
        const axios = require("axios");
        const url = emulator ? "http://localhost:9099/emulator" : "https://identitytoolkit.googleapis.com";
        await axios.post(`${url}/v1/accounts:sendOobCode?key=[${config.appId}]`,
          { requestType: "VERIFY_EMAIL", idToken: customToken }
        ); // Not working. TODO fix the issue
      } catch (error) {
        debug(error);
      }
    }
  } else {
    // Send custom email verification on sign-up.
    const link = await admin.auth().generateEmailVerificationLink(user.email!); // you can provide actionCodeSettings also
    await sendCustomVerificationEmail(user.email, link, context?.locale);
    // we can throw error such that user does not get created till verification.
    // However, we need the user details like pwd and thus the user has to be created
  }
}
/**
 * This function is used to send mails
 * This will require a Firebase extension or a node module like nodemailer
 * @param {*} _email
 * @param {*} _link
 * @param {*} _locale
 */
// eslint-disable-next-line no-unused-vars

async function sendCustomVerificationEmail(_email?: string, _link?: string, _locale?: string) {
  // TODO use nodemailer etc. This will not use Firebase templates
  // We could also see https://canopas.com/how-to-send-emails-using-cloud-functions-firestore-firebase-send-email-ff4702a16fef
}

export {
  addUser,
  beforeSignIn,
  beforeUserCreated,
  verifyIdToken
}
