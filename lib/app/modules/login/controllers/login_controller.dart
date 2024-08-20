import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import '../../../../services/auth_service.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  final Rx<bool> showReverificationButton = Rx(false);
  final Rxn<fba.EmailAuthCredential> credential = Rxn<fba.EmailAuthCredential>();

  bool get isRobot => AuthService.to.robot.value == true;
  set robot(bool v) => AuthService.to.robot.value = v;

  bool get isLoggedIn => AuthService.to.isLoggedInValue;
  bool get isAnon => AuthService.to.isAnon;
  bool get isRegistered =>
      AuthService.to.registered.value || AuthService.to.isEmailVerified;

  void loginAsGuest() {
    AuthService.to.loginAsGuest();
  }

  void handleAuthError(BuildContext context, AuthFailed state) {
    Get.snackbar('Login Error', state.exception.toString());
  }

  void sendVerificationMail({fba.EmailAuthCredential? emailAuth}) {
    AuthService.to.sendVerificationMail(emailAuth: emailAuth);
  }
}
