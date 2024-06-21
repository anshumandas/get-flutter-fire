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
/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// const {onRequest} = require("firebase-functions/v2/https");
const logger_1 = require("firebase-functions/logger");
const firebase_functions_1 = require("firebase-functions");
const firebase_admin_1 = __importDefault(require("firebase-admin"));
const fs_1 = __importDefault(require("fs"));
const config = JSON.parse(fs_1.default.readFileSync("firebase_options.json", "utf8"));
const firebaseApp = firebase_admin_1.default.initializeApp(config);
exports.firebaseApp = firebaseApp;
// Create and deploy functions
// See: https://firebase.google.com/docs/functions/get-started
const auth_1 = require("firebase/auth");
const app_1 = require("firebase/app");
const tempApp = (0, app_1.initializeApp)(config, "client");
const auth = (0, auth_1.getAuth)(tempApp);
exports.addUser = firebase_functions_1.auth.user().onCreate((user, context) => __awaiter(void 0, void 0, void 0, function* () {
    var _a;
    // This is used to provide admin role to the first user that gets created
    (0, logger_1.debug)("added user: ", user);
    if (((_a = user.customClaims) === null || _a === void 0 ? void 0 : _a.status) == "creating") { // this is using client side to send the verification mail
        firebase_admin_1.default.auth().setCustomUserClaims(user.uid, { status: "created" });
    }
    else if (!config.useCustomeVerificationEmail && user && user.email && !user.emailVerified) {
        // this is client side module and can create issues with server side quota limits
        yield sendVerificationEmail(user, context);
    }
}));
function checkUserExistsSendVerification(user, context) {
    return __awaiter(this, void 0, void 0, function* () {
        var email = user.email;
        if (!email.endsWith(".verify"))
            return null;
        try {
            const userRecord = yield firebase_admin_1.default.auth().getUserByEmail(email.substring(0, email.length - 7));
            (0, logger_1.debug)("existing user: ", user);
            // we could save the last email sent time in another DB to stop multiple sends
            yield sendVerificationEmail(userRecord, context);
            return userRecord;
        }
        catch (e) {
            return null;
        }
    });
}
exports.beforeUserCreated = firebase_functions_1.auth.user().beforeCreate((user, context) => __awaiter(void 0, void 0, void 0, function* () {
    if (!(user && user.email)) {
        throw new firebase_functions_1.auth.HttpsError("invalid-argument", `Email is required`);
    }
    // if same email exists then it does not reach here
    const rec = yield checkUserExistsSendVerification(user, context);
    if (rec != null) {
        throw new firebase_functions_1.auth.HttpsError("already-exists", `Verification Email Sent`);
    }
    else {
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
        }
        else if (!config.adminEmail) {
            // ake the first user admin if admin email is not specified in config
            const listUsersResult = yield firebase_admin_1.default.auth().listUsers(2);
            if (listUsersResult.users.length == 0) {
                return {
                    displayName: "Admin",
                    customClaims: { "role": "admin" },
                    emailVerified: true, // admin is auto verified
                };
            }
        }
        if (!user.emailVerified && config.useCustomeVerificationEmail) {
            yield sendVerificationEmail(user, context);
        }
        else if (!user.emailVerified) {
            // This could be useful if SignUp flow has other pages to take post email registeration details
            return {
                customClaims: { status: "creating" }, // set "creating" if you want to use client side for sending the verification mail instead of server side on SignUp.
                // sessionClaims: {status: "creating"}, // this does not propogate and thus using customClaims
            };
        }
    }
}));
exports.beforeSignIn = firebase_functions_1.auth.user().beforeSignIn((user, _context) => {
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
});
// TODO: use the below to verify auth token before any CRUD requests in a middleware
exports.verifyIdToken = function (idToken) {
    firebase_admin_1.default.auth().verifyIdToken(idToken).then((decodedToken) => {
        if (decodedToken.email_verified) {
            // Email verified. Grant access.
        }
        else {
            // Email not verified. Ask user to verify email in error response
        }
    });
};
/**
 * Used to send email from server side
 * @param {*} user
 * @param {*} context
 */
function sendVerificationEmail(user, context) {
    return __awaiter(this, void 0, void 0, function* () {
        if (!config.useCustomeVerificationEmail) {
            // If using Emulator don't forget to add this
            const emulator = process.env.FUNCTIONS_EMULATOR === "true";
            const customToken = yield firebase_admin_1.default.auth().createCustomToken(user.uid, user.customClaims);
            // debug(customToken);
            if (config.useClientSDK) {
                // This is a hack to use client side email sending function at server side, suggested in stackOverflow
                try {
                    if (emulator) {
                        (0, auth_1.connectAuthEmulator)(auth, "http://localhost:9099");
                    }
                }
                catch (error) {
                    /* this might happen if already connected */
                }
                (0, auth_1.signInWithCustomToken)(auth, customToken).then((credential) => __awaiter(this, void 0, void 0, function* () {
                    const firebaseUser = credential.user;
                    yield (0, auth_1.sendEmailVerification)(firebaseUser);
                    auth.signOut().then(() => {
                        // Sign-out successful.
                        console.log("signed out success");
                    }, () => {
                    });
                }));
            }
            else {
                // better and cleaner approach, however it is harder to test in Emulator
                // TODO test the below
                try {
                    const axios = require("axios");
                    const url = emulator ? "http://localhost:9099/emulator" : "https://identitytoolkit.googleapis.com";
                    yield axios.post(`${url}/v1/accounts:sendOobCode?key=[${config.appId}]`, { requestType: "VERIFY_EMAIL", idToken: customToken }); // Not working. TODO fix the issue
                }
                catch (error) {
                    (0, logger_1.debug)(error);
                }
            }
        }
        else {
            // Send custom email verification on sign-up.
            const link = yield firebase_admin_1.default.auth().generateEmailVerificationLink(user.email); // you can provide actionCodeSettings also
            yield sendCustomVerificationEmail(user.email, link, context === null || context === void 0 ? void 0 : context.locale);
            // we can throw error such that user does not get created till verification.
            // However, we need the user details like pwd and thus the user has to be created
        }
    });
}
/**
 * This function is used to send mails
 * This will require a Firebase extension or a node module like nodemailer
 * @param {*} _email
 * @param {*} _link
 * @param {*} _locale
 */
// eslint-disable-next-line no-unused-vars
function sendCustomVerificationEmail(_email, _link, _locale) {
    return __awaiter(this, void 0, void 0, function* () {
        // TODO use nodemailer etc. This will not use Firebase templates
        // We could also see https://canopas.com/how-to-send-emails-using-cloud-functions-firestore-firebase-send-email-ff4702a16fef
    });
}
