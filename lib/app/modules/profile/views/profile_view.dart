import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../services/auth_service.dart';
import '../../../../models/screens.dart';
import '../../../widgets/change_password_dialog.dart';
import '../controllers/profile_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
    return Obx(() => profileScreen(context));
  }

  Widget profileScreen(BuildContext context) {
    return AuthService.to.isLoggedInValue
        ? ProfileScreen(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      avatar: GestureDetector(
        onTap: () => _pickImage(),
        child: SizedBox(
          height: size,
          width: size,
          child: ClipPath(
            clipper: ShapeBorderClipper(shape: shape),
            clipBehavior: Clip.hardEdge,
            child: Obx(() => controller.photoURL != null
                ? Image.network(
              controller.photoURL!,
              width: size,
              height: size,
              cacheWidth: size.toInt(),
              cacheHeight: size.toInt(),
              fit: BoxFit.cover,
              frameBuilder: _imageFrameBuilder,
            )
                : Center(
              child: Image.asset(
                'assets/images/dash.png',
                width: size,
                fit: BoxFit.contain,
              ),
            )),
          ),
        ),
      ),
      actions: [
        SignedOutAction((context) {
          controller.logout();
          Get.rootDelegate.toNamed(Screen.PROFILE.route);
        }),
        AccountDeletedAction((context, user) {
          Get.defaultDialog(
            title: 'Delete Account',
            middleText: 'Are you sure you want to delete your account? This action cannot be undone.',
            textConfirm: 'Delete',
            textCancel: 'Cancel',
            confirmTextColor: Colors.white,
            onConfirm: () async {
              Get.back();
              try {
                await user.delete();
                Get.defaultDialog(
                  title: 'Account Deleted',
                  middleText: 'Your account has been successfully deleted.',
                  onConfirm: () {
                    controller.logout();
                    Get.offAllNamed(Screen.HOME.route);
                  },
                );
              } catch (e) {
                Get.defaultDialog(
                  title: 'Error',
                  middleText: 'Failed to delete account: ${e.toString()}',
                  onConfirm: () => Get.back(),
                );
              }
            },
          );
        }),
      ],
      children: [
        const Divider(),
        if (controller.currentUser?.email != null)
          TextButton.icon(
            onPressed: () => callChangePwdDialog(),
            label: const Text('Change Password'),
            icon: const Icon(Icons.password_rounded),
          ),
        TextButton.icon(
          onPressed: () => _pickImage(),
          label: const Text('Change Profile Picture'),
          icon: const Icon(Icons.image),
        ),
      ],
    )
        : const Scaffold();
  }

  void callChangePwdDialog() {
    var dlg = ChangePasswordDialog(controller.currentUser!);
    Get.defaultDialog(
      title: "Change Password",
      content: dlg,
      textConfirm: "Submit",
      textCancel: "Cancel",
      onConfirm: dlg.onSubmit,
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      String? dest;
      if (kIsWeb) {
        // For web, pass the bytes and filename
        final bytes = await image.readAsBytes();
        dest = await controller.uploadFile(bytes, image.name);
      } else {
        // For mobile/desktop, pass the file path and filename
        dest = await controller.uploadFile(image.path, image.name);
      }
      if (dest != null) {
        await controller.updatePhotoURL(dest);
      }
    }
  }
}