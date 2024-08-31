import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/services/auth_service.dart';

// ui contollers
class LoginController extends GetxController {
  final TextEditingController phoneController = TextEditingController();

  final isDisabled = true.obs;
  final isInitialPosition = true.obs;
  final phoneNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    phoneController.addListener(_checkRequiredFields);

    Future.delayed(const Duration(milliseconds: 400), () {
      isInitialPosition.value = false;
    });
  }

  void _checkRequiredFields() {
    final phone = phoneController.text;

    isDisabled.value = phone.length != 10;
    phoneNumber.value = phone;
  }

  void verifyPhoneNumber(AuthService authService) {
    authService.verifyPhoneNumber("+91${phoneController.text}");
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
