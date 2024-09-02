import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:your_app/controllers/reset_password_controller.dart';

import '../../controllers/reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  final ResetPasswordController controller = Get.put(ResetPasswordController());

  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => TextField(
              onChanged: (value) => controller.email.value = value,
              decoration: const InputDecoration(labelText: 'Email'),
            )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.sendPasswordResetEmail,
              child: const Text('Send Reset Email'),
            ),
            ElevatedButton(
              onPressed: controller.verifyEmail,
              child: const Text('Verify Email'),
            ),
          ],
        ),
      ),
    );
  }
}
