import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final email = ''.obs;

  void sendPasswordResetEmail() {
    // Logic for sending reset email
    Get.snackbar('Success', 'Password reset email sent!');
  }

  void verifyEmail() {
    // Logic for email verification
    Get.snackbar('Success', 'Email verified successfully!');
  }
}
