// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fbui;
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/phone_auth/controllers/phone_auth_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/screens.dart';
import '../constants.dart';
import '../models/role.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
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
    if (useEmulator) {
      _auth.useAuthEmulator(emulatorHost, 9099);
    }
    _firebaseUser.bindStream(_auth.authStateChanges());
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        user.getIdTokenResult().then((token) {
          _userRole.value = Role.fromString(token.claims?["role"]);
        });
        Get.rootDelegate.offNamed(Screen.HOME.route);
      } else if (user == null) {
        Get.rootDelegate.offNamed(Screen.LOGIN.route);
      }
    });
  }

  bool get isEmailVerified =>
      user != null && (user!.email == null || user!.emailVerified);

  bool get isLoggedInValue => user != null;

  bool get isAdmin => user != null && _userRole.value == Role.admin;

  bool hasRole(Role role) => user != null && _userRole.value == role;

  bool get isAnon => user != null && user!.isAnonymous;

  String? get userName => (user != null && !user!.isAnonymous)
      ? (user!.displayName ?? user!.email)
      : 'Guest';

// Function to handle google sign in.
//* Can use silent sign in to make the flow smoother on the web.
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(clientId: const String.fromEnvironment('CLIENT_ID'));
  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    }
    return null;
  }

  // Functions to handle phone authentication.
  // Function to verify the phone number. On android this tries to read the code directly without the user having to manually enter the code.
  Future<void> verifyMobileNumber(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        String errorMessage = 'Verification failed';
        switch (e.code) {
          case 'invalid-verification-code':
            errorMessage = 'Invalid SMS code.';
            break;
          case 'expired-verification-code':
            errorMessage = 'SMS code has expired.';
            break;
          default:
            errorMessage = 'An unknown error occurred. Please try again later.';
        }
        Get.snackbar(errorMessage, '');
      },
      codeSent: (String verificationId, int? resendToken) {
        print("Code sent");
        Get.find<MobileAuthController>().codeSent.value = true;
        Get.find<MobileAuthController>().verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }

  // Verify the OTP.
  Future<void> verifyOTP(String smsCode, String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await _auth.signInWithCredential(credential);
      print("Done");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    // isLoading.value = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
      String errorMessage;

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        default:
          errorMessage =
              'An unknown error occurred. Please try again later. ${e.toString()}';
      }
      Get.snackbar('Login Error', errorMessage);
    } catch (error) {
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
      print("Error during login: ${error.toString()}");
    } finally {
      // isLoading.value = false;
    }
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

  Future<void> signup(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User created");
      HttpsCallableResult result =
          await FirebaseFunctions.instance.httpsCallable('addUserRole').call({
        'email': email,
      });

      print("Result: $result");

      // Optionally send verification email
      if (true) {
        await userCredential.user!.sendEmailVerification();
      }

      registered.value = true;
      // Navigate to profile or other destination
      final thenTo = Get
          .rootDelegate.currentConfiguration!.currentPage!.parameters?['then'];
      Get.rootDelegate.offAndToNamed(thenTo ?? Screen.PROFILE.route);
    } catch (e) {
      Get.snackbar('Registration Error', 'Failed to register: $e');
    }
  }

  void logout() {
    _auth.signOut();
    if (isAnon) _auth.currentUser?.delete();
    _firebaseUser.value = null;
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

  resetPassword({required String email}) {
    try {
      _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log("Error sending reset link: $e");
      rethrow;
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
