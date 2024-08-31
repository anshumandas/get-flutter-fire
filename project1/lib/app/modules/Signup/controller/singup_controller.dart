import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../profileimage/profileimage_controller.dart';
import '../../../routes/app_pages.dart';
import '../../cart/controller/cart_controller.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ProfileImageController profileImageController = Get.find<ProfileImageController>();
  late final CartController cartController;

  final RxBool wasGuest = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize CartController lazily
    cartController = Get.put(CartController());
    // Check if the user was a guest
    wasGuest.value = Get.arguments?['wasGuest'] ?? false;
  }

  Future<void> signup() async {
    if (formKey.currentState!.validate()) {
      try {
        User? currentUser = FirebaseAuth.instance.currentUser;

        UserCredential userCredential;
        if (currentUser != null && currentUser.isAnonymous) {
          // Link anonymous account
          AuthCredential credential = EmailAuthProvider.credential(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
          userCredential = await currentUser.linkWithCredential(credential);
        } else {
          // Create new account
          userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
        }

        // Upload profile image if selected
        if (profileImageController.pickedFile != null) {
          await profileImageController.uploadImage();
          if (profileImageController.imageUrl.isNotEmpty) {
            await userCredential.user!.updatePhotoURL(profileImageController.imageUrl);
          }
        }

        Get.snackbar('Success', 'Account created successfully');
        
        // Ensure cart is loaded from SharedPreferences
        await cartController.loadCartFromPrefs();
        
        // Navigate based on whether the user was previously a guest
        if (wasGuest.value) {
          Get.offAllNamed(Routes.CART);
        } else {
          Get.offAllNamed(Routes.HOME);
        }

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar('Error', 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar('Error', 'The account already exists for that email.');
        } else {
          Get.snackbar('Error', 'An error occurred. Please try again.');
        }
      } catch (e) {
        Get.snackbar('Error', e.toString());
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
