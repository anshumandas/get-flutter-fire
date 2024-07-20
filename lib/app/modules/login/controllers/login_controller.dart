import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import '../../../../services/auth_service.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  final AuthService _authService = Get.find();

  final Rx<bool> showReverificationButton = Rx(false);
  final Rx<bool> isRecaptchaVerified = Rx(false);
  final Rxn<fba.AuthCredential> credential = Rxn<fba.AuthCredential>();

  bool get isLoggedIn => _authService.isLoggedInValue;
  bool get isAnon => _authService.isAnon;
  bool get isRegistered => _authService.registered.value || _authService.isEmailVerified;

  Future<bool> verifyRecaptcha() async {
    if (GetPlatform.isWeb) {
      try {
        print('Attempting reCAPTCHA verification...');
        final result = await GRecaptchaV3.execute('login_action');
        print('reCAPTCHA result: $result');
        if (result != null && result.isNotEmpty) {
          print('reCAPTCHA verification successful');
          isRecaptchaVerified.value = true;
          return true;
        } else {
          print('reCAPTCHA verification failed: Empty or null result');
        }
      } catch (e) {
        print('reCAPTCHA error: $e');
        isRecaptchaVerified.value = false;
      }
      return false;
    } else {
      print('Non-web platform, assuming verified');
      isRecaptchaVerified.value = true;
      return true;
    }
  }

  void errorMessage(BuildContext context, AuthFailed state, Function(bool, fba.AuthCredential?) showReverificationButton) {
  }

  void sendVerificationMail({fba.AuthCredential? emailAuth}) {
  }
}