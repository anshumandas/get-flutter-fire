import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/phone_auth/controllers/phone_auth_controller.dart';
import 'package:get_flutter_fire/services/auth_service.dart';

class MobileAuth extends GetView<MobileAuthController> {
  const MobileAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Authentication')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => controller.codeSent.value
                ? OtpScreen(verificationId: controller.verificationId.value)
                : const VerifyPhoneScreen(),
          ),
        ),
      ),
    );
  }
}

class VerifyPhoneScreen extends GetView<MobileAuthController> {
  const VerifyPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controller.phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(hintText: 'Enter Phone Number'),
        ),
        const SizedBox(height: 20),
        Obx(() => controller.isLoading.value
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () => AuthService()
                    .verifyMobileNumber(controller.phoneNumberController.text),
                child: const Text('Send OTP'),
              )),
      ],
    );
  }
}

class OtpScreen extends GetView<MobileAuthController> {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controller.otpController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Enter OTP'),
        ),
        const SizedBox(height: 20),
        Obx(() => controller.isLoading.value
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () => AuthService()
                    .verifyOTP(controller.otpController.text, verificationId),
                child: const Text('Verify OTP'),
              )),
      ],
    );
  }
}
