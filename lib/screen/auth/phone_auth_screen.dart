import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:your_app/controllers/auth_controller.dart';

import '../../controllers/auth_controller.dart';

class PhoneAuthScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => TextField(
              onChanged: (value) => authController.phoneNumber.value = value,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: authController.sendSmsCode,
              child: const Text('Send SMS Code'),
            ),
            Obx(() => TextField(
              onChanged: (value) => authController.smsCode.value = value,
              decoration: const InputDecoration(labelText: 'Enter SMS Code'),
            )),
            ElevatedButton(
              onPressed: authController.verifySmsCode,
              child: const Text('Verify SMS Code'),
            ),
          ],
        ),
      ),
    );
  }
}
