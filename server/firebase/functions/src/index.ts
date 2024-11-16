/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
// Create and deploy functions
// See: https://firebase.google.com/docs/functions/get-started

import {config} from "./config";
import * as admin from "firebase-admin";
admin.initializeApp(config);

import {addUser, beforeSignIn, beforeUserCreated} from "./auth";
import {https} from "firebase-functions";
import {express} from "myserver/dist/index";
import {listeners} from "./firestore";

const app = https.onRequest(express);

// eslint-disable-next-line @typescript-eslint/no-explicit-any
const exps:{[key:string]:any} = {
  app,
  addUser,
  beforeSignIn,
  beforeUserCreated,
};

// eslint-disable-next-line guard-for-in
for (const key in listeners) {
  if (Object.prototype.hasOwnProperty.call(listeners, key)) {
    const element = listeners[key];
    exps[key] = element;
  }
}

export const e = exps;
