import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reset_password_controller.dart';
import '../../../widgets/my_button.dart';
import '../../../widgets/my_text_field.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextField(
                  controller: controller.emailController,
                  hintText: 'Email',
                ),
                MyButton(
                  text: 'Reset Password',
                  onTap: () => controller.resetPassword(),
                ),
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text('Go back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
