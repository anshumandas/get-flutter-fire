import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../services/auth_service.dart';

class ResetPasswordController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final emailController = TextEditingController();

  void resetPassword() {
    if (emailController.text.isEmpty) {
      Get.snackbar("Error", "Please enter your email");
      return;
    }
    _authService.resetPassword(emailController.text);
  }
}
