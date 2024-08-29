import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../services/firstore_service.dart';
import '../../../routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  var userData = {}.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading(true);
      DocumentSnapshot snapshot = await _firestoreService.getUserData();
      userData.value = snapshot.data() as Map<String, dynamic>;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch user data: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Sign out failed: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateUserData({
    required String name,
    required String email,
    required String phoneNumber,
    String imageUrl = 'https://via.placeholder.com/150',
  }) async {
    try {
      await _firestoreService.updateUserData(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        imageUrl: imageUrl,
      );
      fetchUserData(); // Refresh the data after updating
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update user data: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
