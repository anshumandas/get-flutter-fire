import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fbui;
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  void onInit() {
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

  bool get isEmailVerified =>
      user != null && (user!.email == null || user!.emailVerified);

  bool get isLoggedInValue => user != null;

  bool get isAdmin => user != null && _userRole.value == Role.admin;

  bool hasRole(Role role) => user != null && _userRole.value == role;

  bool get isAnon => user != null && user!.isAnonymous;

  String? get userName => (user != null && !user!.isAnonymous)
      ? (user!.displayName ?? user!.email)
      : 'Guest';

  void sendVerificationMail({EmailAuthCredential? emailAuth}) async {
    if (sendMailFromClient) {
      if (_auth.currentUser != null) {
        await _auth.currentUser?.sendEmailVerification();
      } else if (emailAuth != null) {
        try {
          await _auth.createUserWithEmailAndPassword(
              email: "${credential.value!.email}.verify",
              password: credential.value!.password!);
        } on FirebaseAuthException catch (e) {
          Get.snackbar(
            'Error',
            'Please verify your email by clicking the link sent to ${e.message}',
          );
        }
      }
    }
  }

  void sendSignInLink(EmailAuthCredential emailAuth) {
    var acs = ActionCodeSettings(
      url:
          '$baseUrl:5001/flutterfast-92c25/us-central1/handleEmailLinkVerification',
      handleCodeInApp: true,
    );
    _auth
        .sendSignInLinkToEmail(email: emailAuth.email, actionCodeSettings: acs)
        .catchError(
            (onError) => print('Error sending email verification $onError'))
        .then((value) => print('Successfully sent email verification'));
  }

  void register() {
    registered.value = true;
    final thenTo =
        Get.rootDelegate.currentConfiguration!.currentPage!.parameters?['then'];
    Get.rootDelegate.offAndToNamed(thenTo ?? Screen.PROFILE.route);
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
      if (e.code == "operation-not-allowed") {
        print("Anonymous auth hasn't been enabled for this project.");
      } else {
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

      String? verification;
      if (e.code == "internal-error" &&
          e.message!.contains('"status":"UNAUTHENTICATED"')) {
        callback(true, credential.value);
        verification = "Please verify your email by clicking the link sent.";
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

String parseEmail(String message) {
  int i = message.indexOf('"message":') + 13;
  int j = message.indexOf('"', i);
  return message.substring(i, j - 1);
}
