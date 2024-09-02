import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/auth_service.dart';
import '../../../widgets/change_password_dialog.dart';
import '../controllers/profile_controller.dart';
import '../../../../models/screens.dart';
import 'package:image_picker/image_picker.dart';
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
      avatar: SizedBox(
        height: size,
        width: size,
        child: ClipPath(
          clipper: ShapeBorderClipper(shape: shape),
          clipBehavior: Clip.hardEdge,
          child: controller.photoURL != null
              ? Image.network(
            controller.photoURL!,
            width: size,
            height: size,
            fit: BoxFit.contain,
            frameBuilder: _imageFrameBuilder,
            errorBuilder: (context, error, stackTrace) {
              print("Error loading image: ${error.toString()}"); // Debugging line
              return Center(child: Text('Failed to load image'));
            },
          )
              : Center(
            child: Image.asset(
              'assets/images/dash.png',
              width: size,
              fit: BoxFit.contain,
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
            title: 'Deleted Account of ${user.displayName}',
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
            style: TextButton.styleFrom(
            ),
          ),
        TextButton.icon(
          onPressed: () => _pickImage(),
          label: const Text('Change Profile Picture'),
          icon: const Icon(Icons.image),
          style: TextButton.styleFrom(
          ),
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
        final bytes = await image.readAsBytes();
        // Update uploadFile method to accept Uint8List for web
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
