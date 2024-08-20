import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../../services/auth_service.dart';
import '../../../../models/screens.dart';

class ProfileController extends GetxController {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;
  final Rxn<String> _photoURL = Rxn<String>();
  String? get photoURLValue => _photoURL.value;

  @override
  void onInit() {
    super.onInit();
    _photoURL.value = currentUser?.photoURL;
    listenToUserChanges();
  }

  void listenToUserChanges() {
    auth.userChanges().listen((User? user) {
      if (user != null) {
        _photoURL.value = user.photoURL;
      } else {
        _photoURL.value = null;
      }
    });
  }

  Future<String?> uploadFile(dynamic fileData, String fileName) async {
  try {
    final destination = 'profilePics/${currentUser!.uid}/$fileName';
    final ref = storage.ref(destination);

    if (fileData is String && !kIsWeb) {
      // For non-web platforms, fileData is a file path
      File file = File(fileData);
      if (await file.exists()) {
        await ref.putFile(file);
      } else {
        throw FileSystemException('File not found', fileData);
      }
    } else if (fileData is Uint8List) {
      // For web platforms, fileData is byte data
      await ref.putData(fileData);
    } else {
      throw ArgumentError('Invalid file data type');
    }

    return destination;
  } catch (e) {
    Get.snackbar('Error', 'Image Not Uploaded: ${e.toString()}');
    return null;
  }
}


  Future<Uint8List?> getImageBytes(String path) async {
    if (kIsWeb) {
      return null; // Implement if needed for web
    } else {
      final file = File(path);
      return await file.readAsBytes();
    }
  }

  void logout() {
    AuthService.to.logout();
  }

  Future<void> updatePhotoURL(String dest) async {
    try {
      String downloadURL = await storage.ref(dest).getDownloadURL();
      await auth.currentUser?.updatePhotoURL(downloadURL);
      _photoURL.value = downloadURL;
      Get.snackbar('Success', 'Picture stored and linked');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile picture: ${e.toString()}');
    }
  }

  Future<void> deleteAccount() async {
    try {
      await auth.currentUser?.delete();
      Get.defaultDialog(
        title: 'Account Deleted',
        middleText: 'Your account has been successfully deleted.',
        onConfirm: () {
          logout();
          Get.offAllNamed(Screen.HOME.route);
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete account: ${e.toString()}');
    }
  }
}
