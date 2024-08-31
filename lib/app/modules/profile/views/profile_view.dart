// ProfileView.dart

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/auth_service.dart';
import '../../../../models/screens.dart';
import '../../../widgets/change_password_dialog.dart';
import '../../../widgets/image_picker_button.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  ShapeBorder get shape => const CircleBorder();
  double get size => 120;
  Color get placeholderColor => Colors.grey;

  Widget _imageFrameBuilder(
      BuildContext context,
      Widget? child,
      int? frame,
      bool? _,
      ) {
    if (frame == null) {
      return Container(color: placeholderColor);
    }
    return child!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Obx(() => profileScreen()),
    );
  }

  Widget profileScreen() {
    final user = AuthService.to.user;
    final userName = user?.displayName ?? 'Guest';
    final photoURL = user?.photoURL;

    if (AuthService.to.isLoggedInValue) {
      return ProfileScreen(
        avatar: SizedBox(
          height: size,
          width: size,
          child: ClipPath(
            clipper: ShapeBorderClipper(shape: shape),
            clipBehavior: Clip.hardEdge,
            child: photoURL != null
                ? Image.network(
              photoURL,
              width: size,
              height: size,
              cacheWidth: size.toInt(),
              cacheHeight: size.toInt(),
              fit: BoxFit.contain,
              frameBuilder: _imageFrameBuilder,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            )
                : Center(
              child: Icon(
                Icons.person,
                size: size,
                color: placeholderColor,
              ),
            ),
          ),
        ),
        actions: [
          SignedOutAction((context) {
            Get.back();
            controller.logout();
            Get.rootDelegate.toNamed(Screen.PROFILE.route);
          }),
          AccountDeletedAction((context, user) {
            Get.defaultDialog(
              title: 'Deleted Account of ${user.displayName ?? 'User'}',
              barrierDismissible: true,
              navigatorKey: Get.nestedKey(Screen.HOME.route),
            );
          })
        ],
        children: [
          const Divider(),
          if (controller.currentUser?.email != null)
            TextButton.icon(
              onPressed: callChangePwdDialog,
              label: const Text('Change Password'),
              icon: const Icon(Icons.password_rounded),
            ),
          ImagePickerButton(callback: (String? path) async {
            if (path != null) {
              try {
                String? dest = await controller.uploadFile(path);
                if (dest != null) {
                  await controller.updatePhotoURL(dest);
                }
              } catch (e) {
                Get.snackbar('Error', 'Failed to upload image: $e');
              }
            }
          }),
        ],
      );
    } else {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please log in to view your profile.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Screen.LOGIN.route);
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.pinkAccent[100]),
                child: Text('Log in'),
              ),
            ],
          ),
        ),
      );
    }
  }

  void callChangePwdDialog() {
    if (controller.currentUser == null) return;
    var dlg = ChangePasswordDialog(controller.currentUser!);
    Get.defaultDialog(
      title: "Change Password",
      content: dlg,
      textConfirm: "Submit",
      textCancel: "Cancel",
      onConfirm: dlg.onSubmit,
    );
  }
}
