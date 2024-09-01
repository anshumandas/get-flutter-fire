import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_flutter_fire/app/modules/profile/controllers/profile_controller.dart';

class PhoneVerificationController extends GetxController {
  final phoneController = TextEditingController();
  final codeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final isLoading = false.obs;
  final codeSent = false.obs;
  final verificationId = ''.obs;

  @override
  void onClose() {
    phoneController.dispose();
    codeController.dispose();
    super.onClose();
  }

  Future<void> verifyPhone() async {
    if (phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your phone number');
      return;
    }

    isLoading.value = true;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieve the SMS code on Android devices
          await _auth.signInWithCredential(credential);
          Get.offAllNamed(
              '/home'); // Navigate to home page after successful verification
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', 'Verification failed: ${e.message}');
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;
          codeSent.value = true;
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify phone: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyCode() async {
    if (codeController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the verification code');
      return;
    }

    isLoading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: codeController.text,
      );

      await _auth.signInWithCredential(credential);
      Get.offAllNamed(
          '/home'); // Navigate to home page after successful verification
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify code: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void onVerificationComplete() {
    Get.find<ProfileController>().refreshUser();
    Get.back();
  }
}
