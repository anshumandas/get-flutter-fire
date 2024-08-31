import 'dart:io';
import 'dart:typed_data'; // Import this for Uint8List
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../services/auth_service.dart';

class ProfileController extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;
  User? currentUser = AuthService.to.user;
  final Rxn<String> _photoURL = Rxn<String>();

  File? _photo;

  String? get photoURL => _photoURL.value;

  @override
  void onInit() {
    super.onInit();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    try {
      if (currentUser != null) {
        final destination = 'profilePics/${currentUser!.uid}';
        final storageRef = storage.ref(destination).child('profile_image.jpg');

        print("Fetching image from: $destination"); // Debugging line

        // Fetch the download URL of the profile image
        String imageUrl = await storageRef.getDownloadURL();
        print("Fetched image URL: $imageUrl"); // Debugging line

        // Update the photoURL observable with the fetched image URL
        _photoURL.value = imageUrl;
        print("Photo URL updated: ${_photoURL.value}"); // Debugging line
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile image: ${e.toString()}');
    }
  }

  Future<String?> uploadFile(dynamic fileData, String fileName) async {
    try {
      final destination = 'profilePics/${currentUser!.uid}';

      if (fileData is Uint8List) {
        // For web, handle Uint8List (byte data)
        final ref = storage.ref(destination).child(fileName);
        await ref.putData(fileData);
      } else if (fileData is String) {
        // For mobile/desktop, handle file path
        _photo = File(fileData);
        if (_photo == null) return null;
        final ref = storage.ref(destination).child(fileName);
        await ref.putFile(_photo!);
      } else {
        throw ArgumentError('Unsupported file data type');
      }

      return "$destination/$fileName";
    } catch (e) {
      Get.snackbar('Error', 'Image Not Uploaded: ${e.toString()}');
      return null;
    }
  }

  Future<void> updatePhotoURL(String dest) async {
    try {
      _photoURL.value = await storage.ref(dest).getDownloadURL();
      await currentUser?.updatePhotoURL(_photoURL.value);
      Get.snackbar('Success', 'Picture stored and linked');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update photo URL: ${e.toString()}');
    }
  }

  void logout() {
    AuthService.to.logout();
  }
}
