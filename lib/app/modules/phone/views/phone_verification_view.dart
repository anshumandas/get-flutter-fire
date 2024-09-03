import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/phone/controllers/phone_verification_controller.dart';

class PhoneVerificationView extends GetView<PhoneVerificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Verification')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return controller.codeSent.value
              ? _buildVerifyCodeForm()
              : _buildPhoneInputForm();
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
          onPressed: controller.isLoading.value ? null : controller.verifyPhone,
          child: controller.isLoading.value
              ? CircularProgressIndicator()
              : Text('Send Verification Code'),
        ),
      ],
    );
  }

  Widget _buildVerifyCodeForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controller.codeController,
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
}
