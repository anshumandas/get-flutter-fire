import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../services/auth_services.dart';
import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  Rxn<User?> firebaseUser = Rxn<User?>();

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_authService.authStateChanges());
  }

  Future<void> signUp(String email, String password) async {
    try {
      User? user = await _authService.signUpWithEmailPassword(email, password);
      if (user != null) {
        Get.offAllNamed(AppRoutes.home); // Navigate to home on success
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
        Get.offAllNamed(AppRoutes.home); // Navigate to home on success
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

  Future<void> signOut() async {
    await _authService.signOut();
    Get.offAllNamed(AppRoutes.login); // Navigate to login on sign out
  }
}
