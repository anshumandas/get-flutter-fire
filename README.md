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
3. TODO: Add Phone verification [https://firebase.google.com/docs/auth/flutter/phone-auth]
   * See [https://github.com/firebase/flutterfire/issues/4189].
4. TODO: Add 2FA with SMS Pin. This screen is available in the Flutter Fire package

Step 8: Add Firebase Emulator to test on laptop instead of server so that we can use Functions without upgrading the plan to Blaze. See [https://firebase.google.com/docs/emulator-suite/install_and_configure]

Step 9: Add User Roles using Custom Claims. This requires upgrade of plan as we need to use Firebase Functions

1. In Emulator we can add user via http://127.0.0.1:4000/auth and add custom claim via UI as  {"role":"admin"}. The effect is shown via Product page in Nav instead of Cart page for admin user.
2. TODO - add Function to add the custom claim based on app request by another admin
