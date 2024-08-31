import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
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
    if (currentUser != null) {
      _photoURL.value = currentUser!.photoURL;
      _photoURL.bindStream(currentUser!.photoURL.obs.stream);
    } else {
      Get.snackbar('Error', 'No user is currently logged in.');
    }
  }

  Future<String?> uploadFile(String path) async {
    if (currentUser == null) {
      Get.snackbar('Error', 'User is not logged in.');
      return null;
    }

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
      Get.snackbar('Error', 'Image Not Uploaded: ${e.toString()}');
    }
    return null;
  }

  void logout() {
    AuthService.to.logout();
  }

  Future<void> updatePhotoURL(String dest) async {
    if (currentUser == null) {
      Get.snackbar('Error', 'User is not logged in.');
      return;
    }

    _photoURL.value = await storage.ref().child(dest).getDownloadURL();
    await currentUser?.updatePhotoURL(_photoURL.value);
    Get.snackbar('Success', 'Picture stored and linked');
  }
}
