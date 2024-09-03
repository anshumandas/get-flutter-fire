import 'package:flutter/material.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import 'package:get_flutter_fire/services/auth_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    GRecaptchaV3.ready("6Ld2yDMqAAAAAEBDI749ZKIpUi_9P5sEnDqP0piw");
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> performLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter both email and password');
      return;
    }

    isLoading.value = true;
    try {
      if (GetPlatform.isWeb) {
        final result = await GRecaptchaV3.execute('login');
        if (result == null) {
          Get.snackbar('Error', 'reCAPTCHA verification failed');
          return;
        }
      }

      await _authService.signIn(
          emailController.text.trim(), passwordController.text.trim());
      _navigateAfterLogin();
    } catch (e) {
      Get.snackbar('Error', 'Login failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void _navigateAfterLogin() {
    final cartController = Get.find<CartController>();
    if (cartController.hasItems) {
      Get.offAllNamed(Routes.CART);
    } else {
      Get.offAllNamed(Routes.HOME);
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

  void navigateToRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  void navigateToEmailLinkAuth() {
    Get.toNamed('/email-link-auth');
  }

  void navigateToResetPassword() {
    Get.toNamed('/reset-password');
  }
}
