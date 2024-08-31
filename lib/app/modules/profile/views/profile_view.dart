import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/auth_service.dart';
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
    return Obx(() => profileScreen());
  }

  Widget profileScreen() {
    return AuthService.to.isLoggedInValue
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              actions: [
                if (Theme.of(Get.context!).platform == TargetPlatform.android ||
                    Theme.of(Get.context!).platform == TargetPlatform.iOS)
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {
                      _showBottomSheet(Get.context!, controller);
                    },
                  )
                else
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'Select Image') {
                        controller.pickImage();
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return ['Select Image'].map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
              ],
            ),
            body: Center(
              child: Obx(() {
                return controller.photoURL != null &&
                        controller.photoURL!.isNotEmpty
                    ? Image.network(
                        controller.photoURL!,
                        width: size,
                        height: size,
                        fit: BoxFit.contain,
                        frameBuilder: _imageFrameBuilder,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Image.asset(
                              'assets/images/dash.png',
                              width: size,
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        'assets/images/dash.png',
                        width: size,
                        fit: BoxFit.contain,
                      );
              }),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (controller.currentUser?.email != null)
                    TextButton.icon(
                      onPressed: () => _resetPasswordEmailVerification(),
                      label: const Text('Reset Password'),
                      icon: const Icon(Icons.email_rounded),
                    ),
                  ImagePickerButton(callback: (String? path) async {
                    if (path != null) {
                      String? dest = await controller.uploadFile(path);
                      if (dest != null) {
                        await controller.updatePhotoURL(dest);
                      }
                    }
                  }),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                callChangePwdDialog();
              },
              child: const Icon(Icons.lock),
            ),
          )
        : Scaffold();
  }

  void _showBottomSheet(BuildContext context, ProfileController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Select from gallery'),
              onTap: () {
                controller.pickImage();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a photo'),
              onTap: () {
                controller
                    .pickImage(); // Adjust if you want to add camera option
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _resetPasswordEmailVerification() async {
    final email = controller.currentUser?.email;
    if (email != null) {
      await AuthService.to.sendPasswordResetEmail(email);
    } else {
      Get.snackbar(
        'Error',
        'No email address found for the current user.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }

  void callChangePwdDialog() {
    var dlg = ChangePasswordDialog(controller.currentUser!);
    Get.defaultDialog(
        title: "Change Password",
        content: dlg,
        textConfirm: "Submit",
        textCancel: "Cancel",
        onConfirm: dlg.onSubmit);
  }
}
