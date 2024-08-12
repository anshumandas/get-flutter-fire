import 'package:flutter/material.dart';
import 'package:get/get.dart';

// PhoneAuthController is a firebase controller name, hence that name cannot be used.
class MobileAuthController extends GetxController {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  RxString verificationId = ''.obs;
  RxBool codeSent = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onClose() {
    phoneNumberController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
