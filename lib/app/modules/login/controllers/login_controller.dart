import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../services/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    _authService.signIn(emailController.text, passwordController.text);
  }

  void goToRegister() {
    Get.toNamed('/register');
  }
}
