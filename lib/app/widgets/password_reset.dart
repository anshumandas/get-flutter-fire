import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordResetController extends GetxController {
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final isLoading = false.obs;
  final isEmailSent = false.obs;
  final isResetComplete = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> sendResetEmail() async {
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }

    isLoading.value = true;
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text.trim());
      isEmailSent.value = true;
      Get.snackbar(
          'Success', 'Password reset email sent. Please check your inbox.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to send reset email: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    isLoading.value = true;
    try {
      // Verify the password reset code
      await _auth.verifyPasswordResetCode(Get.parameters['oobCode']!);

      // Confirm the password reset
      await _auth.confirmPasswordReset(
        code: Get.parameters['oobCode']!,
        newPassword: newPasswordController.text,
      );

      isResetComplete.value = true;
      Get.snackbar('Success', 'Password has been reset successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to reset password: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}

class PasswordResetView extends GetView<PasswordResetController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (!controller.isEmailSent.value) {
            return _buildSendEmailForm();
          } else if (!controller.isResetComplete.value) {
            return _buildResetPasswordForm();
          } else {
            return _buildResetCompleteMessage();
          }
        }),
      ),
    );
  }

  Widget _buildSendEmailForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controller.emailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed:
              controller.isLoading.value ? null : controller.sendResetEmail,
          child: controller.isLoading.value
              ? CircularProgressIndicator()
              : Text('Send Reset Email'),
        ),
      ],
    );
  }

  Widget _buildResetPasswordForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: controller.newPasswordController,
          decoration: InputDecoration(labelText: 'New Password'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        TextField(
          controller: controller.confirmPasswordController,
          decoration: InputDecoration(labelText: 'Confirm New Password'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed:
              controller.isLoading.value ? null : controller.resetPassword,
          child: controller.isLoading.value
              ? CircularProgressIndicator()
              : Text('Reset Password'),
        ),
      ],
    );
  }

  Widget _buildResetCompleteMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Password reset successfully!'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Get.offAllNamed('/login'),
            child: Text('Go to Login'),
          ),
        ],
      ),
    );
  }
}
