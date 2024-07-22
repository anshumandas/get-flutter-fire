"use strict";
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
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.verifyIdToken = exports.beforeUserCreated = exports.beforeSignIn = exports.addUser = void 0;
const init_1 = require("./init");
const admin_1 = require("./admin");
const logger_1 = require("firebase-functions/logger");
const firebase_functions_1 = require("firebase-functions");
const auth_1 = require("firebase/auth");
const nodemailer_1 = __importDefault(require("nodemailer"));
const dotenv = __importStar(require("dotenv"));
dotenv.config();
const addUser = firebase_functions_1.auth.user().onCreate(async (user, context) => {
    var _a;
    // This is used to provide admin role to the first user that gets created
    (0, logger_1.debug)("added user: ", user);
    if (((_a = user.customClaims) === null || _a === void 0 ? void 0 : _a.status) == "creating") { // this is using client side to send the verification mail
        admin_1.adminAuth.setCustomUserClaims(user.uid, { status: "created" });
    }
    else if (!init_1.config.useCustomVerificationEmail && user && user.email && !user.emailVerified) {
        // this is client side module and can create issues with server side quota limits
        await sendVerificationEmail(user, context);
    }
});
exports.addUser = addUser;
async function checkUserExistsSendVerification(user, context) {
    var email = user.email;
    if (!email.endsWith(".verify"))
        return null;
    try {
        const userRecord = await admin_1.adminAuth.getUserByEmail(email.substring(0, email.length - 7));
        (0, logger_1.debug)("existing user: ", user);
        // we could save the last email sent time in another DB to stop multiple sends
        await sendVerificationEmail(userRecord, context);
        return userRecord;
    }
    catch (e) {
        return null;
    }
}
const beforeUserCreated = firebase_functions_1.auth.user().beforeCreate(async (user, context) => {
    if (!(user && user.email)) {
        throw new firebase_functions_1.auth.HttpsError("invalid-argument", `Email is required`);
    }
    // if same email exists then it does not reach here
    const rec = await checkUserExistsSendVerification(user, context);
    if (rec != null) {
        throw new firebase_functions_1.auth.HttpsError("already-exists", `Verification Email Sent`);
    }
    else {
        // Only users of a specific domain can sign up.
        // if(!user.email.includes("@acme.com")) {
        //   throw new functionAuth.HttpsError("invalid-argument", "Unauthorized email");
        // }
        if (init_1.config.adminEmail && init_1.config.adminEmail == user.email) {
            return {
                displayName: "Admin",
                customClaims: { "role": "admin" },
                emailVerified: true, // admin is auto verified
            };
        }
        else if (!init_1.config.adminEmail) {
            // ake the first user admin if admin email is not specified in config
            const listUsersResult = await admin_1.adminAuth.listUsers(2);
            if (listUsersResult.users.length == 0) {
                return {
                    displayName: "Admin",
                    customClaims: { "role": "admin" },
                    emailVerified: true, // admin is auto verified
                };
            }
        }
        if (!user.emailVerified && init_1.config.useCustomVerificationEmail) {
            await sendVerificationEmail(user, context);
        }
        else if (!user.emailVerified) {
            // This could be useful if SignUp flow has other pages to take post email registeration details
            return {
                customClaims: { status: "creating" }, // set "creating" if you want to use client side for sending the verification mail instead of server side on SignUp.
                // sessionClaims: {status: "creating"}, // this does not propogate and thus using customClaims
            };
        }
    }
});
exports.beforeUserCreated = beforeUserCreated;
const beforeSignIn = firebase_functions_1.auth.user().beforeSignIn((user, _context) => {
    var _a;
    (0, logger_1.debug)(_context);
    // custom token by passes this method
    if (user.disabled) {
        throw new firebase_functions_1.auth.HttpsError("permission-denied", `"${user.email}" has been disabled by admin.`);
    }
    if (user.email && !user.emailVerified) {
        if (!(((_a = user.customClaims) === null || _a === void 0 ? void 0 : _a.status) == "creating")) {
            throw new firebase_functions_1.auth.HttpsError("unauthenticated", `"${user.email}" needs to be verified before access is granted.`);
        }
        else {
            return {
                customClaims: { status: "registering" },
            };
        }
    }
    return {};
});
exports.beforeSignIn = beforeSignIn;
// TODO: use the below to verify auth token before any CRUD requests in a middleware
const verifyIdToken = function (idToken) {
    admin_1.adminAuth.verifyIdToken(idToken).then((decodedToken) => {
        if (decodedToken.email_verified) {
            // Email verified. Grant access.
        }
        else {
            // Email not verified. Ask user to verify email in error response
        }
    });
};
exports.verifyIdToken = verifyIdToken;
/**
 * Used to send email from server side
 * @param {*} user
 * @param {*} context
 */
async function sendVerificationEmail(user, context) {
    if (!init_1.config.useCustomVerificationEmail) {
        // If using Emulator don't forget to add this
        const emulator = process.env.FUNCTIONS_EMULATOR === "true";
        const customToken = await admin_1.adminAuth.createCustomToken(user.uid, user.customClaims);
        (0, logger_1.debug)(customToken);
        if (init_1.config.useClientSDK) {
            // This is a hack to use client side email sending function at server side, suggested in stackOverflow
            try {
                if (emulator) {
                    (0, auth_1.connectAuthEmulator)(init_1.auth, "http://localhost:9099");
                }
            }
            catch (error) {
                /* this might happen if already connected */
            }
            (0, auth_1.signInWithCustomToken)(init_1.auth, customToken).then(async (credential) => {
                const firebaseUser = credential.user;
                await (0, auth_1.sendEmailVerification)(firebaseUser);
                init_1.auth.signOut().then(() => {
                    // Sign-out successful.
                    console.log("signed out success");
                }, () => {
                });
            });
        }
        else {
            // better and cleaner approach, however it cannot be tested in Emulator
            // TODO test the below in live Firebase
            try {
                const axios = require("axios");
                const url = emulator ? "http://127.0.0.1:9099/identitytoolkit.googleapis.com" : "https://identitytoolkit.googleapis.com";
                await axios.post(`${url}/v1/accounts:sendOobCode?key=[${init_1.config.apiKey}]`, { requestType: "VERIFY_EMAIL", idToken: customToken }); // Not working. TODO fix the issue
            }
            catch (error) {
                (0, logger_1.debug)(error);
            }
        }
    }
    else {
        // Send custom email verification on sign-up.
        const link = await admin_1.adminAuth.generateEmailVerificationLink(user.email); // you can provide actionCodeSettings also
        await sendCustomVerificationEmail(user.email, link, context === null || context === void 0 ? void 0 : context.locale);
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
async function sendCustomVerificationEmail(_email, _link, _locale) {
    // TODO use nodemailer etc. This will not use Firebase templates
    // We could also see https://canopas.com/how-to-send-emails-using-cloud-functions-firestore-firebase-send-email-ff4702a16fef
    const transporter = nodemailer_1.default.createTransport({
        host: "smtp.gmail.com", // e.g., smtp.gmail.com for Gmail
        port: 587,
        secure: false, // true for 465, false for other ports
        auth: {
            user: "shreya.parkar.197@gmail.com", // your email
            pass: "3645@Adsh", // your email password or app-specific password
        }
    });
    const mailOptions = {
        from: "'Shreya Parkar' shreya.parkar.197@gmail.com", // sender address
        to: _email,
        subject: "Email Verification", // Subject line
        text: `Please verify your email by clicking the following link: ${_link}`, // plain text body
        html: `<b>Please verify your email by clicking the following link: <a href="${_link}">Verify Email</a></b>`, // html body
    };
    try {
        await transporter.sendMail(mailOptions);
        console.log("Verification email sent to:", _email);
    }
    catch (error) {
        console.error("Error sending verification email:", error);
        throw new Error("Error sending verification email");
    }
}
//# sourceMappingURL=auth.js.map