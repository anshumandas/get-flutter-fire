<<<<<<< HEAD
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
=======
import 'dart:io';

>>>>>>> origin/main
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
<<<<<<< HEAD
import 'package:path/path.dart';
import '../../../../services/auth_service.dart';
import '../../../../models/screens.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
        var byt = GetStorage().read(fileData);
        if (byt != null) {
          await ref.putData(byt);
        } else {
          File photo = File(fileData);
          await ref.putFile(photo);
        }
      } else if (fileData is Uint8List) {
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
      // For web, we'll implement this differently or remove if not needed
      return null;
    } else {
      // For non-web platforms, read the file as bytes
      final file = File(path);
      return await file.readAsBytes();
    }
=======

import 'package:path/path.dart';
import '../../../../services/auth_service.dart';

class ProfileController extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;
  User? currentUser = AuthService.to.user;
  final Rxn<String> _photoURL = Rxn<String>();

  File? _photo;

  String? get photoURL => _photoURL.value;

  @override
  onInit() {
    super.onInit();
    _photoURL.value = currentUser!.photoURL;
    _photoURL.bindStream(currentUser!.photoURL.obs.stream);
  }

  Future<String?> uploadFile(String path) async {
    try {
      var byt = GetStorage().read(path);
      if (byt != null) {
        final fileName = path;
        final destination = 'profilePics/${currentUser!.uid}';

        final ref = storage.ref(destination).child(fileName);
        await ref.putData(byt);
        return "$destination/$fileName";
      } else {
        _photo = File(path);
        if (_photo == null) return null;
        final fileName = basename(_photo!.path);
        final destination = 'profilePics/${currentUser!.uid}';

        final ref = storage.ref(destination).child(fileName);
        await ref.putFile(_photo!);
        return "$destination/$fileName";
      }
    } catch (e) {
      Get.snackbar('Error', 'Image Not Uploaded as ${e.toString()}');
    }
    return null;
>>>>>>> origin/main
  }

  void logout() {
    AuthService.to.logout();
  }

  Future<void> updatePhotoURL(String dest) async {
<<<<<<< HEAD
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
      throw Exception('Failed to delete account: ${e.toString()}');
    }
  }
}
=======
    _photoURL.value = await storage.ref().child(dest).getDownloadURL();
    await currentUser?.updatePhotoURL(_photoURL.value);
    Get.snackbar('Success', 'Picture stored and linked');
  }
}
>>>>>>> origin/main
