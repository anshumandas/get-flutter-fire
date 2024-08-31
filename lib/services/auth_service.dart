// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fbui;
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../app/routes/app_pages.dart';
import '../models/screens.dart';
import '../constants.dart';
import '../models/role.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late Rxn<EmailAuthCredential> credential = Rxn<EmailAuthCredential>();
  final Rxn<User> _firebaseUser = Rxn<User>();
  final Rx<Role> _userRole = Rx<Role>(Role.buyer);
  final Rx<bool> robot = RxBool(useRecaptcha);
  final RxBool registered = false.obs;

  User? get user => _firebaseUser.value;
  Role get maxRole => _userRole.value;

  @override
  onInit() {
    super.onInit();
    if (useEmulator) _auth.useAuthEmulator(emulatorHost, 9099);
    _firebaseUser.bindStream(_auth.authStateChanges());
    _auth.userChanges().listen((User? user) {
      if (user != null) {
        user.getIdTokenResult().then((token) {
          _userRole.value = Role.fromString(token.claims?["role"]);
        });
      }
    });
  }

  bool get isEmailVerified =>
      user != null && (user!.email == null || user!.emailVerified);

  bool get isLoggedInValue => user != null;

  bool get isAdmin => user != null && _userRole.value == Role.admin;

  bool hasRole(Role role) => user != null && _userRole.value == role;

  bool get isAnon => user != null && user!.isAnonymous;

  String? get userName => (user != null)
      ? (user!.displayName ?? (user!.isAnonymous ? 'Guest' : user!.email))
      : 'Guest';

  void login() {
    // this is not needed as we are using Firebase UI for the login part
  }

  void sendVerificationMail({EmailAuthCredential? emailAuth}) async {
    if (sendMailFromClient) {
      if (_auth.currentUser != null) {
        await _auth.currentUser?.sendEmailVerification();
      } else if (emailAuth != null) {
        // Approach 1: sending email auth link requires deep linking which is
        // a TODO as the current Flutter methods are deprecated
        // sendSingInLink(emailAuth);

        // Approach 2: This is a hack.
        // We are using createUser to send the verification link from the server side by adding suffix .verify in the email
        // if the user already exists and the password is also same and sign in occurs via custom token on server side
        try {
          await _auth.createUserWithEmailAndPassword(
              email: "${credential.value!.email}.verify",
              password: credential.value!.password!);
        } on FirebaseAuthException catch (e) {
          int i = e.message!.indexOf("message") + 10;
          int j = e.message!.indexOf('"', i);
          Get.snackbar(
            e.message!.substring(i, j),
            'Please verify your email by clicking the link on the Email sent',
          );
        }
      }
    }
  }

  void sendSingInLink(EmailAuthCredential emailAuth) {
    var acs = ActionCodeSettings(
      // URL you want to redirect back to. The domain (www.example.com) for this
      // URL must be whitelisted in the Firebase Console.
      url:
          '$baseUrl:5001/flutterfast-92c25/us-central1/handleEmailLinkVerification',
      //     // This must be true if deep linking.
      //     // If deeplinking. See [https://firebase.google.com/docs/dynamic-links/flutter/receive]
      handleCodeInApp: true,
      //     iOSBundleId: '$bundleID.ios',
      //     androidPackageName: '$bundleID.android',
      //     // installIfNotAvailable
      //     androidInstallApp: true,
      //     // minimumVersion
      //     androidMinimumVersion: '12'
    );
    _auth
        .sendSignInLinkToEmail(email: emailAuth.email, actionCodeSettings: acs)
        .catchError(
            (onError) => print('Error sending email verification $onError'))
        .then((value) => print('Successfully sent email verification'));
  }

  void register() {
    registered.value = true;
    // logout(); // Uncomment if we need to enforce relogin
    final thenTo =
        Get.rootDelegate.currentConfiguration!.currentPage!.parameters?['then'];
    Get.rootDelegate
        .offAndToNamed(thenTo ?? Screen.PROFILE.route); //Profile has the forms
  }

  // Updated logout function
  Future<void> logout() async {
    User? user = _auth.currentUser; // Get the current user

    if (user != null && user.isAnonymous) {
      // If the user is anonymous, delete the user itself
      try {
        await user.delete(); // Delete the anonymous user
        print("Anonymous user deleted successfully.");
      } catch (error) {
        print("Error deleting anonymous user: $error");
        // Handle the error, such as notifying the user or logging the issue
      }
    } else {
      // If the user is not anonymous, just sign them out
      await _auth.signOut();
      print("Non-anonymous user signed out successfully.");
    }


    // post on login page after logout
    Get.rootDelegate.toNamed(Screen.HOME.route);

    // Reset user value if needed (if using a reactive approach)
    //_firebaseUser.value = null; // Uncomment if you're using a reactive approach

  }


  Future<bool?> guest() async {
    return await Get.defaultDialog(
        middleText: 'Sign in as Guest',
        barrierDismissible: true,
        onConfirm: loginAsGuest,
        onCancel: () => Get.back(result: false),
        textConfirm: 'Yes, will SignUp later',
        textCancel: 'No, will SignIn now');
  }

  void loginAsGuest() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      Get.back(result: true);
      Get.snackbar(
        'Alert!',
        'Signed in with temporary account.',
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
      Get.back(result: false);
    }
  }

  void errorMessage(BuildContext context, fbui.AuthFailed state,
      Function(bool, EmailAuthCredential?) callback) {
    fbui.ErrorText.localizeError =
        (BuildContext context, FirebaseAuthException e) {
      final defaultLabels = FirebaseUILocalizations.labelsOf(context);

      // for verification error, also set a boolean flag to trigger button visibility to resend verification mail
      String? verification;
      if (e.code == "internal-error" &&
          e.message!.contains('"status":"UNAUTHENTICATED"')) {
        // Note that (possibly in Emulator only) the e.email is always coming as null
        // String? email = e.email ?? parseEmail(e.message!);
        callback(true, credential.value);
        verification =
            "Please verify email id by clicking the link on the email sent";
      } else {
        callback(false, credential.value);
      }

      return switch (e.code) {
        'invalid-credential' => 'User ID or Password incorrect',
        'user-not-found' => 'Please create an account first.',
        'credential-already-in-use' => 'This email is already in use.',
        _ => fbui.localizedErrorText(e.code, defaultLabels) ??
            verification ??
            'Oh no! Something went wrong.',
      };
    };
  }

  Future<void> pnVerify(
      String phoneNumber,
      Function(String) onCodeSent,
      Function(String) onVerificationCompleted) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign in the user automatically once verification is completed
        await _auth.signInWithCredential(credential);
        _firebaseUser.value = _auth.currentUser;
        // Notify the caller that verification is completed
        onVerificationCompleted(_auth.currentUser?.uid ?? '');
      },
      verificationFailed: (FirebaseAuthException e) {
        // Display an error message if verification fails
        Get.snackbar('Error', 'Failed to verify phone number: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Return the verification ID to the caller
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle the timeout of auto-retrieval
      },
    );
  }

  Future<void> pnsignin(
      String verificationId, String smsCode) async {
    try {
      // Create a credential for sign-in using the provided verification ID and SMS code
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      // Attempt to sign in with the generated credential
      await _auth.signInWithCredential(credential);
      _firebaseUser.value = _auth.currentUser;
    } catch (e) {
      // Show an error message if sign-in fails
      Get.snackbar('Error', 'Sign-in process failed: $e');
    }
  }
}

class MyCredential extends AuthCredential {
  final EmailAuthCredential cred;
  MyCredential(this.cred)
      : super(providerId: "custom", signInMethod: cred.signInMethod);

  @override
  Map<String, String?> asMap() {
    return cred.asMap();
  }
}

parseEmail(String message) {
  int i = message.indexOf('"message":') + 13;
  int j = message.indexOf('"', i);
  return message.substring(i, j - 1);
}
