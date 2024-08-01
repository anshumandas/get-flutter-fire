// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fbui;
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/models/access_level.dart';

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

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required PhoneVerificationCompleted verificationCompleted,
    required PhoneVerificationFailed verificationFailed,
    required PhoneCodeSent codeSent,
    required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<UserCredential> signInWithCredential(AuthCredential credential) async {
    return await _auth.signInWithCredential(credential);
  }

  @override
  onInit() {
    super.onInit();
    if (useEmulator) _auth.useAuthEmulator(emulatorHost, 9099);
    _firebaseUser.bindStream(_auth.authStateChanges());
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        user.getIdTokenResult().then((token) {
          _userRole.value = Role.fromString(token.claims?["role"]);
        });
      }
    });
  }

  AccessLevel get accessLevel => user != null
      ? user!.isAnonymous
          ? _userRole.value.index > Role.buyer.index
              ? AccessLevel.roleBased
              : AccessLevel.authenticated
          : AccessLevel.guest
      : AccessLevel.public;

  bool get isEmailVerified =>
      user != null && (user!.email == null || user!.emailVerified);

  bool get isLoggedInValue => user != null;

  bool get isAdmin => user != null && _userRole.value == Role.admin;

  bool hasRole(Role role) => user != null && _userRole.value == role;

  bool get isAnon => user != null && user!.isAnonymous;

  String? get userName => (user != null && !user!.isAnonymous)
      ? (user!.displayName ?? user!.email)
      : 'Guest';

  void login() {
    // this is not needed as we are using Firebase UI for the login part
  }

  void sendVerificationMail({EmailAuthCredential? emailAuth}) async {
    if (sendMailFromClient) {
      if (_auth.currentUser != null) {
        try {
          await _auth.currentUser?.sendEmailVerification();
          Get.snackbar(
            'Verification Email Sent',
            'Please check your email (including spam folder) for the verification link.',
            duration: Duration(seconds: 5),
          );
        } catch (e) {
          print('Error sending verification email: $e');
          Get.snackbar(
            'Error',
            'Failed to send verification email. Please try again later.',
            duration: Duration(seconds: 5),
          );
        }
      } else if (emailAuth != null) {
        // Use the existing approach for sending verification email
        try {
          await _auth.createUserWithEmailAndPassword(
              email: "${emailAuth.email}.verify",
              password: emailAuth.password!);
          Get.snackbar(
            'Verification Email Sent',
            'Please verify your email by clicking the link in the email sent.',
            duration: Duration(seconds: 5),
          );
        } on FirebaseAuthException catch (e) {
          int i = e.message!.indexOf("message") + 10;
          int j = e.message!.indexOf('"', i);
          Get.snackbar(
            e.message!.substring(i, j),
            'Please verify your email by clicking the link on the Email sent',
          );
        }
      } else {
        print('No user is currently signed in and no email auth provided');
        Get.snackbar(
          'Error',
          'Unable to send verification email. Please try registering again.',
          duration: Duration(seconds: 5),
        );
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

  void logout() {
    _auth.signOut();
    if (isAnon) _auth.currentUser?.delete();
    _firebaseUser.value = null;
  }

  Future<bool?> guest() async {
  return await Get.defaultDialog(
    title: 'Sign in as Guest',
    barrierDismissible: true,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Limited access. Would you like to proceed?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            ElevatedButton(
              onPressed: loginAsGuest,
              child: Text('Sign Up Later'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 15, 43, 16), // Text color
              ),
            ),
            SizedBox(width: 15),
        ElevatedButton(
          onPressed: () => Get.back(result: false),
          child: Text('Sign In Now'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Color.fromARGB(255, 15, 43, 16), backgroundColor: Color.fromARGB(255, 232, 252, 243), // Text color
          ),
        ),
          ],
        ),
      ],
    ),
    titlePadding: EdgeInsets.all(16),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    confirmTextColor: Colors.white,
    cancelTextColor: Colors.white,
    backgroundColor: Colors.white, // Dialog background color
    radius: 10, // Rounded corners
  );
}


  void loginAsGuest() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      Get.back(result: true);
      Get.snackbar(
        'Alert!',
        'Signed in with temporary account.',
        backgroundColor: Color.fromARGB(255, 232, 252, 243), 
    colorText: Color.fromARGB(255, 15, 43, 16), 
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


