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

import admin from "firebase-admin";

import fs from "fs";
// Generate your own firebase_options.json you can find the details required in the google-services.json file found from firebase console
export const config = JSON.parse(fs.readFileSync("firebase_options.json", "utf8"));
console.log(config);
// Initializes firebaseApp as specified in the firebase_options.json in server side environment
const firebaseApp = admin.initializeApp({
  credential: admin.credential.cert({
    projectId: config.projectId,
    clientEmail: config.clientEmail,
    privateKey: config.privateKey.replace(/\\n/g, "\n"),
  }),
  databaseURL: config.databaseURL,
  storageBucket: config.storageBucket,
});
// const firebaseApp = admin.initializeApp(config);

exports.firebaseApp = firebaseApp;

import {getAuth} from "firebase/auth";
import { initializeApp } from "firebase/app";
// Initializes firebaseApp as specified in the firebase_options.json in client side environment
const tempApp = initializeApp(config, "client");
export const auth = getAuth(tempApp);



