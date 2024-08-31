import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_flutter_fire/models/banner_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class BannerController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();

  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController productIDController = TextEditingController();
  final RxBool isActive = true.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final Rxn<File> selectedImage =
      Rxn<File>(); // Properly initialize as reactive

  @override
  void onInit() {
    super.onInit();
    fetchBanners(); // Fetch all banners on initialization
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      selectedImage.value =
          File(pickedFile.path); // Correctly update with .value
    }
  }

  Future<void> uploadBanner() async {
    if (selectedImage.value == null && imageUrlController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please provide an image or URL.',
          backgroundColor: AppTheme.colorRed, colorText: AppTheme.colorWhite);
      return;
    }

    String imageUrl = imageUrlController.text.trim();
    if (selectedImage.value != null) {
      imageUrl = await _uploadImageToFirebase(selectedImage.value!);
    }

    if (imageUrl.isEmpty || productIDController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please fill all fields to continue.',
          backgroundColor: AppTheme.colorRed, colorText: AppTheme.colorWhite);
      return;
    }

    try {
      final banner = BannerModel(
        id: _firestore.collection('banners').doc().id,
        imageUrl: imageUrl,
        productID: productIDController.text.trim(),
        isActive: isActive.value,
      );

      await _firestore.collection('banners').doc(banner.id).set(banner.toMap());

      Get.snackbar('Success', 'Banner uploaded successfully!',
          backgroundColor: AppTheme.colorBlue, colorText: AppTheme.colorWhite);
      clearFields();
      fetchBanners(); // Refresh banners list after upload
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload banner: $e',
          backgroundColor: AppTheme.colorRed, colorText: AppTheme.colorWhite);
    }
  }

  Future<String> _uploadImageToFirebase(File image) async {
    try {
      final String fileName =
          'banners/${DateTime.now().millisecondsSinceEpoch}';
      final UploadTask uploadTask =
          _firebaseStorage.ref().child(fileName).putFile(image);
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e',
          backgroundColor: AppTheme.colorRed, colorText: AppTheme.colorWhite);
      return '';
    }
  }

  Future<void> fetchBanners() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('banners').get();
      banners.value = snapshot.docs
          .map((doc) => BannerModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch banners: $e',
          backgroundColor: AppTheme.colorRed, colorText: AppTheme.colorWhite);
    }
  }

  Future<void> toggleBannerStatus(BannerModel banner) async {
    try {
      await _firestore.collection('banners').doc(banner.id).update({
        'isActive': !banner.isActive,
      });
      banner = banner.copyWith(isActive: !banner.isActive);
      banners[banners.indexWhere((b) => b.id == banner.id)] = banner;
      update(); // Update the UI
      Get.snackbar('Success', 'Banner status updated successfully!',
          backgroundColor: AppTheme.colorBlue, colorText: AppTheme.colorWhite);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update banner status: $e',
          backgroundColor: AppTheme.colorRed, colorText: AppTheme.colorWhite);
    }
  }

  void clearFields() {
    imageUrlController.clear();
    productIDController.clear();
    selectedImage.value = null;
    isActive.value = true;
    update();
  }
}
