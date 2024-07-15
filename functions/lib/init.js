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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.auth = exports.config = void 0;
const firebase_admin_1 = __importDefault(require("firebase-admin"));
const fs_1 = __importDefault(require("fs"));
exports.config = JSON.parse(fs_1.default.readFileSync("firebase_options.json", "utf8"));
const firebaseApp = firebase_admin_1.default.initializeApp(exports.config);
exports.firebaseApp = firebaseApp;
const auth_1 = require("firebase/auth");
const app_1 = require("firebase/app");
const tempApp = (0, app_1.initializeApp)(exports.config, "client");
exports.auth = (0, auth_1.getAuth)(tempApp);
//# sourceMappingURL=init.js.map