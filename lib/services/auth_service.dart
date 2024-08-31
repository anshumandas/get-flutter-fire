// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fbui;
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
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
  final RxBool robot = RxBool(useRecaptcha);
  final RxBool registered = false.obs;

  User? get user => _firebaseUser.value;
  Role get maxRole => _userRole.value;

  @override
  void onInit() {
    super.onInit();
    if (useEmulator) _auth.useAuthEmulator(emulatorHost, 9099);
    _firebaseUser.bindStream(_auth.authStateChanges());
    _auth.userChanges().listen((User? user) {
      _firebaseUser.value = user;
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
  String? get userPhotoUrl => user?.photoURL;
  String? get userEmail => user?.email;

  Future<void> updatePhotoURL(String photoURL) async {
    try {
      await user?.updatePhotoURL(photoURL);
      // Refresh the user to ensure the latest data is available.
      await user?.reload();
      _firebaseUser.value =
          _auth.currentUser; // Update the Rxn<User> to trigger listeners
      Get.snackbar("Success", "Profile picture updated successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile picture: $e");
    }
  }

  void updateProfileImage(String imagePath) async {
    try {
      await AuthService.to.updatePhotoURL(imagePath);
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile picture: $e");
    }
  }

  void login() {
    // Not needed as we use Firebase UI for login
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
    Get.rootDelegate
        .offAndToNamed(thenTo ?? Screen.PROFILE.route); // Profile has the forms
  }

  void logout() {
    _auth.signOut();
    if (isAnon) _auth.currentUser?.delete();
    _firebaseUser.value = null;
  }




  Future<bool?> guest() async {
    return await Get.defaultDialog(
        middleText: 'Sign in Required',
        barrierDismissible: true,
        onConfirm: () {
          Get.rootDelegate.toNamed(Screen.LOGIN.route);
          Get.back(result: false);
        },
        onCancel: () {
          Get.back(result: true); // Keeps the user as a guest
        },
        textConfirm: 'Yes, will SignIn Now',
        textCancel: 'No, will SignUp Later');
  }

  void guestlogin({String? name}) async {
    try {
      final UserCredential userCredential = await _auth.signInAnonymously();

      print("Signed in with temporary account.");

      if (name != null && name.isNotEmpty) {
        await userCredential.user?.updateDisplayName(name);
        await userCredential.user?.reload();
        _firebaseUser.value =
            _auth.currentUser; // Ensure the current user is updated
      }

      Get.snackbar(
        'Alert!',
        'Signed in anonymously${name != null ? ' as $name' : ''}.',
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          Get.snackbar('Error', 'Anonymous authentication is not enabled.');
          break;
        default:
          print("Unknown error: ${e.message}");
          Get.snackbar('Error', 'An unknown error occurred: ${e.message}');
      }
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

  // Phone Authentication Methods
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