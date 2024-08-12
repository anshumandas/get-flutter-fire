import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/phone_auth/controllers/phone_auth_controller.dart';
import 'package:get_flutter_fire/services/auth_service.dart';

class MobileAuth extends GetView<MobileAuthController> {
  const MobileAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Authentication'),
        centerTitle: true,
      ),
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
    return Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: controller.phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () => AuthService().verifyMobileNumber(
                              controller.phoneNumberController.text),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Send OTP',
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                ],
              ),
            )));

    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     TextField(
    //       controller: controller.phoneNumberController,
    //       keyboardType: TextInputType.phone,
    //       decoration: const InputDecoration(hintText: 'Enter Phone Number'),
    //     ),
    //     const SizedBox(height: 20),
    //     Obx(() => controller.isLoading.value
    //         ? const CircularProgressIndicator()
    //         : ElevatedButton(
    //             onPressed: () => AuthService()
    //                 .verifyMobileNumber(controller.phoneNumberController.text),
    //             child: const Text('Send OTP'),
    //           )),
    //   ],
    // );
  }
}

class OtpScreen extends GetView<MobileAuthController> {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Verify OTP'),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter the OTP sent to your mobile number',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter OTP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => AuthService().verifyOTP(
                            controller.otpController.text, verificationId),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text('Verify OTP'),
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
