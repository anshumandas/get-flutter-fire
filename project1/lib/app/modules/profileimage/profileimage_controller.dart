import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../home/controllers/home_controller.dart';

class ProfileImageController extends GetxController {
  final Rx<File?> _pickedFile = Rx<File?>(null);
  final RxString _imageUrl = RxString('');

  File? get pickedFile => _pickedFile.value;
  String get imageUrl => _imageUrl.value;

  @override
  void onInit() {
    super.onInit();
    _loadCurrentProfileImage();
  }

  void _loadCurrentProfileImage() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.photoURL != null) {
      _imageUrl.value = user.photoURL!;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      _pickedFile.value = File(pickedImage.path);
      await uploadImage();
    }
  }

  Future<void> uploadImage() async {
    if (_pickedFile.value == null) return;

    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final String fileName = '${user.uid}_profile_image.jpg';
    final Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/$fileName');

    try {
      await storageRef.putFile(_pickedFile.value!);
      final String downloadUrl = await storageRef.getDownloadURL();
      _imageUrl.value = downloadUrl;
      
      // Update user's photoURL
      await user.updatePhotoURL(downloadUrl);
      
      Get.find<HomeController>().updateProfileImage(downloadUrl);
      
      Get.snackbar('Success', 'Profile image uploaded successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload profile image: $e');
    }
  }
}