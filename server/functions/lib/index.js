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
/* eslint-disable spaced-comment */
/* eslint-disable eol-last */
/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
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
Object.defineProperty(exports, "__esModule", { value: true });
// const {onRequest} = require("firebase-functions/v2/https");
// Create and deploy functions
// See: https://firebase.google.com/docs/functions/get-started
const _ = __importStar(require("./auth"));
exports.default = _;
//# sourceMappingURL=index.js.map


const functions = require('firebase-functions');
const admin = require('firebase-admin');
const {onRequest} = functions.https;
const {logger} = functions;

admin.initializeApp();

// Your existing functions here
// For example:
// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.removeUnverifiedUsers = functions.pubsub.schedule('every 24 hours').onRun(async (context) => {
  const userCreationThreshold = Date.now() - (7 * 24 * 60 * 60 * 1000); // 7 days ago

  try {
    const unverifiedUsers = await admin.auth().listUsers()
      .then((listUsersResult) => {
        return listUsersResult.users.filter(userRecord => 
          !userRecord.emailVerified && 
          userRecord.metadata.creationTime < userCreationThreshold
        );
      });

    const deletePromises = unverifiedUsers.map(userRecord => 
      admin.auth().deleteUser(userRecord.uid)
    );

    await Promise.all(deletePromises);

    logger.info(`Successfully removed ${unverifiedUsers.length} unverified users.`);
    return null;
  } catch (error) {
    logger.error('Error removing unverified users:', error);
    return null;
  }
});