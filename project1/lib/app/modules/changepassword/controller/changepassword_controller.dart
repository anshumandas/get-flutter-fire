import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  Future<void> changePassword() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // Re-authenticate the user
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!,
            password: currentPasswordController.text,
          );
          await user.reauthenticateWithCredential(credential);

          // Change the password
          await user.updatePassword(newPasswordController.text);

          Get.back();
          Get.snackbar('Success', 'Password changed successfully');
        }
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.message ?? 'An error occurred');
      } catch (e) {
        Get.snackbar('Error', 'An unexpected error occurred');
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}