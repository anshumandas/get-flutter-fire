import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TwoFactorAuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final phoneController = TextEditingController();
  final smsCodeController = TextEditingController();
  final isLoading = false.obs;
  final verificationId = ''.obs;
  final isVerified = false.obs;

  @override
  void onClose() {
    phoneController.dispose();
    smsCodeController.dispose();
    super.onClose();
  }

  Future<void> sendVerificationCode() async {
    if (phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your phone number');
      return;
    }

    isLoading.value = true;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.currentUser?.updatePhoneNumber(credential);
          isVerified.value = true;
          Get.snackbar('Success', '2FA has been set up successfully');
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Error', 'Verification failed: ${e.message}');
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;
          Get.snackbar('Success', 'Verification code sent');
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to send verification code: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyCode() async {
    if (smsCodeController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter the verification code');
      return;
    }

    isLoading.value = true;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: smsCodeController.text,
      );

      await _auth.currentUser?.updatePhoneNumber(credential);
      isVerified.value = true;
      Get.snackbar('Success', '2FA has been set up successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify code: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> disable2FA() async {
    try {
      await _auth.currentUser?.unlink(PhoneAuthProvider.PROVIDER_ID);
      isVerified.value = false;
      Get.snackbar('Success', '2FA has been disabled');
    } catch (e) {
      Get.snackbar('Error', 'Failed to disable 2FA: ${e.toString()}');
    }
  }
}

class TwoFactorAuthView extends GetView<TwoFactorAuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Two-Factor Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isVerified.value) {
            return _build2FAEnabledView();
          } else if (controller.verificationId.value.isNotEmpty) {
            return _buildVerificationCodeForm();
          } else {
            return _buildPhoneInputForm();
          }
        }),
      ),
    );
  }

  Widget _buildPhoneInputForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controller.phoneController,
          decoration: InputDecoration(labelText: 'Phone Number'),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: controller.isLoading.value ? null : controller.sendVerificationCode,
          child: controller.isLoading.value
              ? CircularProgressIndicator()
              : Text('Send Verification Code'),
        ),
      ],
    );
  }

  Widget _buildVerificationCodeForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controller.smsCodeController,
          decoration: InputDecoration(labelText: 'Verification Code'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: controller.isLoading.value ? null : controller.verifyCode,
          child: controller.isLoading.value
              ? CircularProgressIndicator()
              : Text('Verify Code'),
        ),
      ],
    );
  }

  Widget _build2FAEnabledView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Two-Factor Authentication is enabled.'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: controller.disable2FA,
            child: Text('Disable 2FA'),
          ),
        ],
      ),
    );
  }
}