import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/2FA/controllers/2FA_verification_controller.dart';

class TwoFactorVerifyView extends GetView<TwoFactorVerifyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Two-Factor Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.codeController,
              decoration: InputDecoration(labelText: 'Enter 6-digit code'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.verifyCode,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator()
                      : Text('Verify'),
                )),
          ],
        ),
      ),
    );
  }
}
