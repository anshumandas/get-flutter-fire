import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import '../../../../services/auth_service.dart';

class ProfileController extends GetxController {
  FirebaseStorage storage = FirebaseStorage.instance;
  final Rxn<User> currentUser = Rxn<User>();
  final Rxn<String> _photoURL = Rxn<String>();

  File? _photo;

  String? get photoURL => _photoURL.value;

  @override
  void onInit() {
    super.onInit();
    currentUser.value = AuthService.to.user;
    _photoURL.value = currentUser.value?.photoURL;
    ever(currentUser, (_) => _photoURL.value = currentUser.value?.photoURL);
  }

  Future<String?> uploadFile(String path) async {
    try {
      var byt = GetStorage().read(path);
      if (byt != null) {
        final fileName = path;
        final destination = 'profilePics/${currentUser.value?.uid}';

        final ref = storage.ref(destination).child(fileName);
        await ref.putData(byt);
        return "$destination/$fileName";
      } else {
        _photo = File(path);
        if (_photo == null) return null;
        final fileName = basename(_photo!.path);
        final destination = 'profilePics/${currentUser.value?.uid}';

        final ref = storage.ref(destination).child(fileName);
        await ref.putFile(_photo!);
        return "$destination/$fileName";
      }
    } catch (e) {
      Get.snackbar('Error', 'Image Not Uploaded as ${e.toString()}');
    }
    return null;
  }

  void logout() {
    AuthService.to.signOut();
  }

  Future<void> updatePhotoURL(String dest) async {
    _photoURL.value = await storage.ref().child(dest).getDownloadURL();
    await currentUser.value?.updatePhotoURL(_photoURL.value);
    Get.snackbar('Success', 'Picture stored and linked');
  }

  void refreshUser() {
    currentUser.value = AuthService.to.user;
  }
}
