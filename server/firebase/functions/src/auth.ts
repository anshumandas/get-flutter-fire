/* eslint-disable @typescript-eslint/no-explicit-any */
import {auth, config, emulator} from "./config";
import {debug} from "firebase-functions/logger";
import {EventContext, auth as functionAuth} from "firebase-functions";
import {AuthUserRecord, AuthEventContext, BeforeCreateResponse} from "firebase-functions/lib/common/providers/identity";
import {sendEmailVerification, signInWithCustomToken} from "firebase/auth";
import {adminAuth, UserRecord} from "./admin";
import {firestoredb} from "./firestore";
import {User as IUser} from "myserver/dist/common/models/user";
import {NewData, ref} from "myserver/dist/common/models/base";

class MyUser extends NewData<any> implements IUser {
  constructor(user:any, id: string, by: ref) {
    super("User", {uid: user.uid, primaryKey: user.primaryKey}, id, by);
  }
}

export const addUser = functionAuth.user().onCreate(async (user: AuthUserRecord, context: EventContext) => {
  // This is used to provide admin role to the first user that gets created
  debug("added user: ", user);
  if (user.customClaims?.status == "creating") { // this is using client side to send the verification mail
    adminAuth.setCustomUserClaims(user.uid, {status: "created"});
  } else if (!config.useCustomVerificationEmail && user && user.email && !user.emailVerified) {
    // this is client side module and can create issues with server side quota limits
    await sendVerificationEmail(user, context);
  }
});

async function checkUserExistsSendVerification(user: AuthUserRecord, context: AuthEventContext): Promise<UserRecord | null> {
  if (user.email) {
    const email:string = user.email;
    if (!email.endsWith(".verify")) return null;
    try {
      const userRecord = await adminAuth.getUserByEmail(email.substring(0, email.length - 7));
      debug("existing user: ", user);
      // we could save the last email sent time in another DB to stop multiple sends
      await sendVerificationEmail(userRecord, context);
      return userRecord;
    } catch (e) {
      return null;
    }
  }
  return null;
}

export const beforeUserCreated = functionAuth.user().beforeCreate(async (user: AuthUserRecord, context: AuthEventContext): Promise<BeforeCreateResponse> => {
  if (!(user && user.email)) {
    throw new functionAuth.HttpsError(
      "invalid-argument", "Email is required");
  }
  // if same email exists then it does not reach here
  const rec = await checkUserExistsSendVerification(user, context);
  if (rec != null) {
    throw new functionAuth.HttpsError("already-exists", "Verification Email Sent");
  } else {
    // Only users of a specific domain can sign up.
    // if(!user.email.includes("@acme.com")) {
    //   throw new functionAuth.HttpsError("invalid-argument", "Unauthorized email");
    // }
    try {
      await firestoredb.create(MyUser, "users", user, undefined, [["uid"]]);
    } catch (e) {
      throw new functionAuth.HttpsError(
        "already-exists", `"${user.email}" seems to be already existing with another profile.`);
    }
    if (config.adminEmail && config.adminEmail == user.email) {
      return {
        displayName: "Admin",
        customClaims: {"role": "admin"},
        emailVerified: true, // admin is auto verified
      };
    } else if (!config.adminEmail) {
      // make the first user admin if admin email is not specified in config
      const listUsersResult = await adminAuth.listUsers(2);
      if (listUsersResult.users.length == 0) {
        return {
          displayName: "Admin",
          customClaims: {"role": "admin"},
          emailVerified: true, // admin is auto verified
        };
      }
    }
    if (!user.emailVerified && config.useCustomVerificationEmail) {
      await sendVerificationEmail(user, context);
    } else if (!user.emailVerified) {
      // This could be useful if SignUp flow has other pages to take post email registeration details
      return {
        customClaims: {status: "creating"}, // set "creating" if you want to use client side for sending the verification mail instead of server side on SignUp.
        // sessionClaims: {status: "creating"}, // this does not propogate and thus using customClaims
      };
    }
    return {};
  }
});

export const beforeSignIn = functionAuth.user().beforeSignIn((user, _context) => {
  debug(_context);
  // custom token by passes this method
  if (user.disabled) {
    throw new functionAuth.HttpsError(
      "permission-denied", `"${user.email}" has been disabled by admin.`);
  }
  if (user.email && !user.emailVerified) {
    if (user.customClaims?.status == "error") {
      throw new functionAuth.HttpsError(
        "unauthenticated", `"${user.email}" seems to be already existing with another profile.`);
    } else if (!(user.customClaims?.status == "creating")) {
      throw new functionAuth.HttpsError(
        "unauthenticated", `"${user.email}" needs to be verified before access is granted.`);
    } else {
      return {
        customClaims: {status: "registering"},
      };
    }
  }
  return {};
});

// TODO: use the below to verify auth token before any CRUD requests in a middleware
export const verifyIdToken = function(idToken: string) {
  adminAuth.verifyIdToken(idToken).then((decodedToken) => {
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

async function sendVerificationEmail(user: AuthUserRecord, context: EventContext) {
  debug("Sending Verification Mail");
  if (!config.useCustomVerificationEmail) {
    const customToken = await adminAuth.createCustomToken(user.uid, user.customClaims);
    debug(customToken);
    if (config.useClientSDK) {
      // This is a hack to use client side email sending function at server side, suggested in stackOverflow

      signInWithCustomToken(auth, customToken).then(
        async (credential) => {
          const firebaseUser = credential.user;
          await sendEmailVerification(firebaseUser);
          auth.signOut().then(() => {
            // Sign-out successful.
            console.log("signed out success");
          }, () => {
            console.log("signed out failure");
          });
        });
    } else {
      // better and cleaner approach, however it cannot be tested in Emulator
      // TODO test the below in live Firebase
      try {
        debug("Using Axios");
        // eslint-disable-next-line @typescript-eslint/no-var-requires
        const axios = require("axios");
        const url = emulator ? "http://localhost:9099/emulator" : "https://identitytoolkit.googleapis.com";
        await axios.post(`${url}/v1/accounts:sendOobCode?key=[${config.appId}]`,
          {requestType: "VERIFY_EMAIL", idToken: customToken}
        ); // Not working. TODO fix the issue
      } catch (error) {
        debug(error);
      }
    }
  } else if (user.email) {
    // Send custom email verification on sign-up.
    const link = await adminAuth.generateEmailVerificationLink(user.email); // you can provide actionCodeSettings also
    await sendCustomVerificationEmail(user.email, link, context?.params.locale);
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

// eslint-disable-next-line @typescript-eslint/no-unused-vars
async function sendCustomVerificationEmail(_email?: string, _link?: string, _locale?: string) {
  // TODO use nodemailer etc. This will not use Firebase templates
  // We could also see https://canopas.com/how-to-send-emails-using-cloud-functions-firestore-firebase-send-email-ff4702a16fef
}
