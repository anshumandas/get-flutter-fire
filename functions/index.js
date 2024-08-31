// Import necessary Firebase and Firebase Functions modules
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const firebase = require('firebase/app');
require('firebase/auth');

// Initialize the Firebase Admin SDK
admin.initializeApp();

// Function to make the first registered user an admin
exports.makeFirstUserAdmin = functions.auth.user().onCreate(async (user) => {
    try {
        // List all users
        const userList = await admin.auth().listUsers();

        // Check if this is the first user
        if (userList.users.length === 1) {
            // Set the custom claim 'role: admin' for the first user
            await admin.auth().setCustomUserClaims(user.uid, { role: 'admin' });
            console.log(`User ${user.uid} has been made an admin.`);
        }
    } catch (error) {
        console.error('Error making the first user an admin:', error);
    }
});

// Your Firebase configuration object for the frontend app
const firebaseConfig = {
  apiKey: ' ',
  appId: ' ',
  messagingSenderId: ' ',
  projectId: 'gaurav-sharekhan',
  storageBucket: 'gaurav-sharekhan.appspot.com',
  iosClientId: ' ',
  iosBundleId: 'com.sharekhan.getFlutterFireMain',
  authDomain: "gaurav-sharekhan.firebaseapp.com"
};

// Initialize Firebase in the frontend app
firebase.initializeApp(firebaseConfig);

// Use Auth Emulator if running locally
if (window.location.hostname === 'localhost') {
  firebase.auth().useEmulator('http://127.0.0.1:4000');
}

// Example function (commented out) for future use
// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
