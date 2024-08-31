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
export const config = JSON.parse(fs.readFileSync("firebase_options.json", "utf8"));
const firebaseApp = admin.initializeApp(config);

exports.firebaseApp = firebaseApp;
import {getAuth} from "firebase/auth";
import { initializeApp } from "firebase/app";
const tempApp = initializeApp(config, "client");
export const auth = getAuth(tempApp);



