// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../constants.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  final Rxn<String> _userRole = Rxn<String>();
  final Rx<bool> robot = RxBool(true);

  User? get user => _firebaseUser.value;

  @override
  onInit() {
    super.onInit();
    if (useEmulator) _auth.useAuthEmulator(emulatorHost, 9099);
    _firebaseUser.bindStream(_auth.authStateChanges());
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        _userRole.value = null;
      } else {
        user.getIdTokenResult().then((token) {
          _userRole.value = token.claims?["role"];
        });
      }
    });
  }

  bool get isEmailVerified =>
      user != null && (user!.email == null || user!.emailVerified);

  bool get isLoggedInValue => user != null;

  bool get isAdmin => user != null && _userRole.value == "admin";

  bool get isAnon => user != null && user!.isAnonymous;

  String? get userName => (user != null && !user!.isAnonymous)
      ? (user!.displayName ?? user!.email)
      : 'Guest';

  void login() {
    // this is not needed as we are using Firebase UI for the login part
  }

  void sendVerificationMail(bool signOut) async {
    await _auth.currentUser?.sendEmailVerification();

    Get.snackbar(
      'Alert!',
      'Please verify your email and login again.',
    );

    if (signOut) _auth.signOut();
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
}
