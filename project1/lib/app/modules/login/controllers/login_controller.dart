import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
    checkAuth();
  }

  void checkAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.offAllNamed(Routes.HOME);
      }
    });
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        Get.offAllNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar('Error', 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Get.snackbar('Error', 'Wrong password provided for that user.');
        } else {
          Get.snackbar('Error', 'An error occurred. Please try again.');
        }
      }
    }
  }

  void goToSignup() {
    Get.toNamed(Routes.SIGNUP, arguments: {'wasGuest': false});
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in with Google: ${e.toString()}');
    }
  }

  Future<void> signInAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in anonymously: ${e.toString()}');
    }
  }

  // New method to go to signup from guest
  void goToSignupFromGuest() {
    Get.toNamed(Routes.SIGNUP, arguments: {'wasGuest': true});
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}