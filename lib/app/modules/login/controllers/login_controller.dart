import 'package:flutter/material.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/models/screens.dart';
import 'package:get_flutter_fire/services/auth_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    // Initialize reCAPTCHA
    GRecaptchaV3.ready("6Ld2yDMqAAAAAEBDI749ZKIpUi_9P5sEnDqP0piw");
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (GetPlatform.isWeb) {
      await _webLogin();
    } else {
      await _mobileLogin();
    }
  }

  Future<void> _webLogin() async {
    isLoading.value = true;
    try {
      // Verify reCAPTCHA
      final result = await GRecaptchaV3.execute('login');
      if (result == null) {
        Get.snackbar('Error', 'reCAPTCHA verification failed');
        return;
      }

      // Proceed with Firebase login
      await _performLogin();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _mobileLogin() async {
    isLoading.value = true;
    try {
      await _performLogin();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _performLogin() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCredential.user?.phoneNumber != null) {
        // User has 2FA enabled, send verification code
        await _send2FAVerificationCode(userCredential.user!);
      } else {
        // User doesn't have 2FA, proceed with normal login
        _navigateAfterLogin();
      }
    } catch (e) {
      Get.snackbar('Error', 'Login failed: ${e.toString()}');
    }
  }

  Future<void> _send2FAVerificationCode(User user) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: user.phoneNumber!,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Android only: when the SMS code is retrieved automatically
          await _auth.signInWithCredential(credential);
          _navigateAfterLogin();
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', 'Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigate to 2FA verification screen
          Get.toNamed(Screen.TWO_FACTOR_VERIFY.route,
              parameters: {'verificationId': verificationId});
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
    } catch (e) {
      Get.snackbar(
          'Error', 'Failed to send verification code: ${e.toString()}');
    }
  }

  void _navigateAfterLogin() {
    final cartController = Get.find<CartController>();
    if (cartController.hasItems) {
      Get.rootDelegate.toNamed(Screen.CART.route);
    } else {
      Get.rootDelegate.toNamed(Screen.HOME.route);
    }
  }

  void googleSignIn() async {
    try {
      await AuthService.to.signInWithGoogle();
      _navigateAfterLogin();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
