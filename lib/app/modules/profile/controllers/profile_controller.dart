import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import '../../../../services/auth_service.dart';
import '../../../../models/screens.dart';
import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class ProfileController extends GetxController {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  final Rxn<String> _photoURL = Rxn<String>();

  String? get photoURL => _photoURL.value;

  @override
  void onInit() {
    super.onInit();
    _photoURL.value = currentUser?.photoURL;
    _listenToUserChanges();
  }

  void _listenToUserChanges() {
    _auth.userChanges().listen((User? user) {
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
        // Mobile/Desktop upload logic with file path
        var byt = GetStorage().read(fileData);
        if (byt != null) {
          await ref.putData(byt);
        } else {
          File photo = File(fileData);
          await ref.putFile(photo);
        }
      } else if (fileData is Uint8List) {
        // Web upload logic with byte data
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

  Future<Uint8List?> _getWebImageBytes(String path) async {
    final completer = Completer<Uint8List?>();
    final reader = html.FileReader();
    reader.readAsArrayBuffer(html.File([path], path));
    reader.onLoadEnd.listen((event) {
      completer.complete(reader.result as Uint8List?);
    });
    return completer.future;
  }

  void logout() {
    AuthService.to.logout();
  }

  Future<void> updatePhotoURL(String dest) async {
    try {
      String downloadURL = await storage.ref(dest).getDownloadURL();
      await _auth.currentUser?.updatePhotoURL(downloadURL);
      _photoURL.value = downloadURL;
      Get.snackbar('Success', 'Picture stored and linked');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile picture: ${e.toString()}');
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
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