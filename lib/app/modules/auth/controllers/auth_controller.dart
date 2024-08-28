import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/auth_services.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  Rxn<User?> firebaseUser = Rxn<User?>();

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_authService.authStateChanges());
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      User? user = await _authService.signUpWithEmailPassword(email, password);
      if (user != null) {
        try {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'name': name,
            'email': email,
            'phoneNumber': phoneNumber,
            'imageUrl': 'https://via.placeholder.com/150',
          });
          Get.offAllNamed(AppRoutes.login); // Navigate to login after sign-up
        } catch (e) {
          Get.snackbar(
            'Firestore Error',
            'Failed to store user data: ${e.toString()}',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          print('Error writing document: $e'); // Print to console for debugging
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Sign up failed: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> login(String email, String password) async {
    try {
      User? user = await _authService.loginWithEmailPassword(email, password);
      if (user != null) {
        Get.offAllNamed(AppRoutes.main); // Navigate to MainView on success
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      User? user = await _authService.signInWithGoogle();
      if (user != null) {
        Get.offAllNamed(AppRoutes.main); // Navigate to MainView on success
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Google Sign-In failed: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      Get.offAllNamed(AppRoutes.login); // Navigate to login on sign out
    } catch (e) {
      Get.snackbar(
        'Error',
        'Sign out failed: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
