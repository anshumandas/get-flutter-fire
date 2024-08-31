import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  var currentPassword = ''.obs;
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;

  void changePassword() {
    // Logic for changing the password goes here.
    if (newPassword.value == confirmPassword.value) {
      // Perform password change
      Get.snackbar('Success', 'Password changed successfully!');
    } else {
      Get.snackbar('Error', 'Passwords do not match');
    }
  }
}

class ChangePasswordScreen extends StatelessWidget {
  final ChangePasswordController controller = Get.put(ChangePasswordController());

  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => TextField(
              onChanged: (value) => controller.currentPassword.value = value,
              decoration: const InputDecoration(labelText: 'Current Password'),
              obscureText: true,
            )),
            Obx(() => TextField(
              onChanged: (value) => controller.newPassword.value = value,
              decoration: const InputDecoration(labelText: 'New Password'),
              obscureText: true,
            )),
            Obx(() => TextField(
              onChanged: (value) => controller.confirmPassword.value = value,
              decoration: const InputDecoration(labelText: 'Confirm New Password'),
              obscureText: true,
            )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.changePassword,
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
