# get-flutter-fire

Boilerplate for Flutter with GetX and Firebase

Use the git version history to learn step by step

Step 1: Use Get CLI https://pub.dev/packages/get_cli

`get create project`

Step 2: Copy code from https://github.com/jonataslaw/getx/tree/4.6.1/example_nav2/lib

Step 3: Integrate FlutterFire Authentication

- Tutorials [https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps#0] for inspiration
- Firebase Documentation [https://firebase.google.com/docs/auth/flutter/start]
- Blog [www.medium.com/TBD]
- To compile the code ensure that you generate your own firebase_options.dart by running

  `flutterfire configure`

Step 4: Add Google OAuth [https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps#6]. Note ensure you do the steps for Android and iOS as the code for it is not in Github

Step 5: Add Guest User/Anonymous login with a Cart and Checkout use case [https://firebase.google.com/docs/auth/flutter/anonymous-auth]

* delete unlinked anonymous user post logout

Step 6: Add ImagePicker and Firebase Storage for profile image

* Create PopupMenu button for web [https://api.flutter.dev/flutter/material/PopupMenuButton-class.html]
* BottomSheet for phones and single file button for desktops
* GetX and Image Picker [https://stackoverflow.com/questions/66559553/flutter-imagepicker-with-getx]
* Add FilePicker [https://medium.com/@onuaugustine07/pick-any-file-file-picker-flutter-f82c0144e27c]
* Firebase Storage [https://mercyjemosop.medium.com/select-and-upload-images-to-firebase-storage-flutter-6fac855970a9] and [https://firebase.google.com/docs/storage/flutter/start]

  Modify the Firebase Rules
  `service firebase.storage { match /b/{bucket}/o { match /{allPaths=**} { allow write: if request.auth.uid != null; allow read: if true; } } }`

  Fix CORS [https://stackoverflow.com/questions/37760695/firebase-storage-and-access-control-allow-origin]
* PList additions [https://medium.com/unitechie/flutter-tutorial-image-picker-from-camera-gallery-c27af5490b74]

Step 7: Additional Auth flow items

1. Add a Change Password Screen. The Flutter Fire package does not have this screen.
2. TODO: Add ReCaptcha to login flow for password authentication for Web only
   * Phone Auth on Web has a ReCaptcha already [https://firebase.flutter.dev/docs/auth/phone/]. Tried to use that library but it is very cryptic.
   * Use the following instead [https://stackoverflow.com/questions/60675575/how-to-implement-recaptcha-into-a-flutter-app] or [https://medium.com/cloudcraftz/securing-your-flutter-web-app-with-google-recaptcha-b556c567f409] or [https://pub.dev/packages/g_recaptcha_v3]
3. TODO: Ensure Reset Password has Email verification
4. TODO: Add Phone verification [https://firebase.google.com/docs/auth/flutter/phone-auth]
   * See [https://github.com/firebase/flutterfire/issues/4189].
5. TODO: Add 2FA with SMS Pin. This screen is available in the Flutter Fire package

Step 8: Add Firebase Emulator to test on laptop instead of server so that we can use Functions without upgrading the plan to Blaze. See [https://firebase.google.com/docs/emulator-suite/install_and_configure]

Step 9: Add User Roles using Custom Claims. This requires upgrade of plan as we need to use Firebase Functions. Instead using Emulator.

1. In Emulator we can add user via http://127.0.0.1:4000/auth and add custom claim via UI as  {"role":"admin"}. The effect is shown via Product page in Nav instead of Cart page for admin user.
2. Add Function to add the custom claim to make the first user the admin using the Admin SDK
3. Registeration form to collect some data post signUp and enforce email verification from Client side.

   * Note! for Emulator check the console to verify using the link provided as email is not sent.
4. Enforcing verify email using a button which appears when SignIn fails due to non verification.

   * Fixed the error handling message during login.
   * Coverted server side to Typescript
   * Enabled Resend verification mail button
     * Approach 1 - Use Email Link Authentication and signIn, assuming it marks email as verified also. We cannot send the verification mail as is, since that can be sent only if signed in (which was allowed only for first login post signup)
       * Refer https://firebase.google.com/docs/auth/flutter/email-link-auth
       * TODO Enable Deep Linking: According to https://firebase.google.com/docs/dynamic-links/flutter/receive, the Flutter feature is being deprecated and we should use the AppLinks (Android), UniversalLinks(iOS) instead. Leaving this for future as adding complexity.
       * We could use the server side handling instead of deep linking. See [https://firebase.google.com/docs/auth/custom-email-handler?hl=en&authuser=0#web]. However, this requires changing the email template for the URL which is not possible in Emulator. Using the continueURL instead does not work as oobCode is already expired. This handling also uses the web client sdk. Thus it is better to go with the below method instead.
     * Approach 2 - (Hack) send a create request with suffix ".verify" added in email when button clicked. Use the server side beforeCreate to catch this and send verification mail
       * Note that the Server side beforeCreate function can also bypass user creation till verification but the user record (esp password) needs to be stored anyways, so bypassing user creation is not a good idea. Instead, we should use the verified tag in subsequent processing
       * Sending emails from server side is possible but by using the web client SDK.
5. TODO: Other Items

   * TODO: Using autocomplete for emails is throwing error log in terminal. No impact but need to fix when all is done.
   * TODO: Add a job that removes all unverified users after a while automatically. This could be useful if you were victim of bot attacks, but adding the Recaptcha is better precaution. See [https://stackoverflow.com/questions/67148672/how-to-delete-unverified-e-mail-addresses-in-firebase-authentication-flutter/67150606#67150606]
6. TODO: Add Roles of Buyer and Seller.

   * Access level in increasing order of role order => Buyer then Seller then Admin
   * Create Navigation for each of Admin, Buyer, Seller screens
   * Allow switch from lower role Navigation to Navigation view till the given role of the user
   * Also allow a Premium user flag for Buyer and Seller, to add features which are not Navigation linked. Add a button Upgrade to Premium in Drawer that leads to Payment screen

Step 10: TODO: CRUD

* to call Admin SDK by admin user from app
* to add data to Firebase Datastore
* Create ListView with slidable tiles

Step 11: TODO: Theming

* Add Minimal (Three Color Gradient Pallette) Material Theme.
* Dark theme toggle

Step 12: TODO: Firebase Remote Config for A/B testing

1. Config for Navigation element change
   * A: Drawer for Account, Settings, Sign Out
   * B: Hamburger that opens BottomSheet (Context Menu in larger screen) for the same options
2. Config for adding Search Bar at the Top vs a Bottom Navigation button

Step 13: TODO: Large vs Small screen responsiveness

Step 14: TODO: Make own login flow screens. Remove firebase library reference from all but auth_service
