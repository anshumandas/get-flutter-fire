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
        await user.sendEmailVerification();
        await _storeUserData(user, name, email, phoneNumber);

        Get.snackbar(
          'Verification Email Sent',
          'Please verify your email before logging in.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      _handleError('Sign up failed', e);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      User? user = await _authService.loginWithEmailPassword(email, password);
      if (user != null) {
        if (user.emailVerified) {
          Get.offAllNamed(AppRoutes.main);
        } else {
          Get.snackbar(
            'Email Not Verified',
            'Please verify your email before logging in.',
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
          await signOut();
        }
      }
    } catch (e) {
      _handleError('Login failed', e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      User? user = await _authService.signInWithGoogle();
      if (user != null) {
        await _checkAndStoreGoogleUserData(user);
        Get.offAllNamed(AppRoutes.main);
      }
    } catch (e) {
      _handleError('Google Sign-In failed', e);
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      _handleError('Sign out failed', e);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email);
      Get.snackbar(
        'Reset Link Sent',
        'A password reset link has been sent to $email.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      _handleError('Failed to send reset link', e);
    }
  }

  Future<void> _storeUserData(
      User user, String name, String email, String phoneNumber) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'imageUrl': 'https://via.placeholder.com/150',
        'createdAt': FieldValue.serverTimestamp(),
        'isEmailVerified': false,
      });
    } catch (e) {
      _handleError('Failed to store user data', e);
    }
  }

  Future<void> _checkAndStoreGoogleUserData(User user) async {
    try {
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (!userDoc.exists) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': user.displayName ?? 'Anonymous',
          'email': user.email ?? '',
          'phoneNumber': user.phoneNumber ?? '',
          'imageUrl': user.photoURL ?? 'https://via.placeholder.com/150',
          'createdAt': FieldValue.serverTimestamp(),
          'isEmailVerified': true,
        });
      }
    } catch (e) {
      _handleError('Failed to check/store Google user data', e);
    }
  }

  void _handleError(String message, dynamic e) {
    Get.snackbar(
      'Error',
      '$message: ${e.toString()}',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    print('Error: $message: $e');
  }
}
