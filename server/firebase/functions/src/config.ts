import * as fs from "fs";
export const config = JSON.parse(fs.readFileSync("firebase_options.json", "utf8"));

import {initializeApp} from "firebase/app";
export const clientApp = initializeApp(config, "client");
import {connectAuthEmulator, getAuth} from "firebase/auth";

export const auth = getAuth(clientApp);
// If using Emulator don't forget to add this
export const emulator = process.env.FUNCTIONS_EMULATOR === "true";
try {
  if (emulator) {
    connectAuthEmulator(auth, "http://localhost:9099");
  }
} catch (error) {
  /* this might happen if already connected */
}

