import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TwoFactorVerifyController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final codeController = TextEditingController();
  final isLoading = false.obs;
  final String verificationId = Get.parameters['verificationId'] ?? '';

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }

  Future<void> verifyCode() async {
    if (codeController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the verification code');
      return;
    }

    isLoading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: codeController.text,
      );

      await _auth.signInWithCredential(credential);
      Get.offAllNamed('/home'); // Navigate to home screen after successful verification
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify code: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}