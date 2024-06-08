/* eslint-disable max-len */
/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy functions
// See: https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const functions = require("firebase-functions");
const admin = require("firebase-admin");
// const {HttpsError} = require("firebase-functions/v2/identity");

// const app =
admin.initializeApp();

exports.addUser = functions.auth.user().onCreate((user) => {
  // This is used to provide admin role to the first user that gets created
  logger.info("added user: ", user);
});

exports.beforeUserCreated = functions.auth.user().beforeCreate(async (user, context) => {
  // Only users of a specific domain can sign up.
  // if (user && user.email && !user.email.includes("@acme.com")) {
  //   throw new HttpsError("invalid-argument", "Unauthorized email");
  // }
  const listUsersResult = await admin.auth().listUsers(2);
  if (listUsersResult.users.length == 0) {
    return {
      displayName: "Admin",
      customClaims: {"role": "admin"},
    };
  }
});
