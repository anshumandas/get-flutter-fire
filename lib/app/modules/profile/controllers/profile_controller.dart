import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import '../../../../services/auth_service.dart';

class ProfileController extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;
  User? currentUser = AuthService.to.user;
  final Rxn<String> _photoURL = Rxn<String>();

  String? get photoURL => _photoURL.value;

  @override
  void onInit() {
    super.onInit();
    _photoURL.value = currentUser?.photoURL;
    _photoURL.bindStream(currentUser!.photoURL.obs.stream);
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await uploadFile(pickedFile.path);
    }
  }

  Future<String?> uploadFile(String path) async {
    try {
      if (path.isEmpty) {
        Get.snackbar('Error', 'Invalid file path');
        return null;
      }

      File fileToUpload = File(path);
      bool fileExists = await fileToUpload.exists();
      print('Path: $path, File Exists: $fileExists');

      if (fileExists) {
        final fileName = basename(fileToUpload.path);
        final destination = 'profilePics/${currentUser!.uid}/$fileName';
        final ref = storage.ref(destination);

        await ref.putFile(fileToUpload);
        final downloadURL = await ref.getDownloadURL();
        await updatePhotoURL(downloadURL);
        return downloadURL;
      } else {
        Get.snackbar('Error', 'File does not exist at $path');
        return null;
      }
    } catch (e, stacktrace) {
      print('Error uploading file: $e');
      print('Stacktrace: $stacktrace');
      Get.snackbar('Error', 'Image Not Uploaded: ${e.toString()}');
      return null;
    }
  }

  Future<void> updatePhotoURL(String url) async {
    try {
      _photoURL.value = url;
      await currentUser?.updatePhotoURL(url);
      Get.snackbar('Success', 'Profile picture updated successfully');
    } catch (e) {
      print('Error updating photo URL: $e');
      Get.snackbar('Error', 'Failed to update photo URL: ${e.toString()}');
    }
  }

  void logout() {
    AuthService.to.logout();
  }
}
