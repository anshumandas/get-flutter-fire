import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../profileimage/profileimage_controller.dart';
import '../../home/controllers/home_controller.dart';

class ProfileController extends GetxController {
  final nameController = TextEditingController();
  late final ProfileImageController profileImageController;
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString profileImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize ProfileImageController if it's not already registered
    if (!Get.isRegistered<ProfileImageController>()) {
      Get.put(ProfileImageController());
    }
    profileImageController = Get.find<ProfileImageController>();
    loadUserData();
  }

  void loadUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      name.value = user.displayName ?? '';
      email.value = user.email ?? '';
      profileImageUrl.value = user.photoURL ?? '';
      nameController.text = name.value;
    }
  }

  Future<void> updateProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateDisplayName(nameController.text);
        name.value = nameController.text;

        if (profileImageController.imageUrl.isNotEmpty) {
          await user.updatePhotoURL(profileImageController.imageUrl);
          profileImageUrl.value = profileImageController.imageUrl;
        }

        Get.find<HomeController>().updateProfileInfo(name.value, profileImageUrl.value);

        Get.snackbar('Success', 'Profile updated successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}