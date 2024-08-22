import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../../services/auth_service.dart';
import '../../../../models/screens.dart';
import '../../../widgets/change_password_dialog.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  ShapeBorder get shape => const CircleBorder();
  double get size => 120;
  Color get placeholderColor => Colors.grey;

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    return Obx(() => profileScreen(context, passwordController));
  }

  Widget profileScreen(BuildContext context, TextEditingController passwordController) {
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
                  child: Obx(() => controller.photoURLValue != null
                      ? Image.network(
                          controller.photoURLValue!,
                          width: size,
                          height: size,
                          cacheWidth: size.toInt(),
                          cacheHeight: size.toInt(),
                          fit: BoxFit.cover,
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
              /*AccountDeletedAction((context, user) {
                Get.defaultDialog(
                  title: 'Delete Account',
                  content: Column(
                    children: [
                      const Text("Please enter your password to confirm:"),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                    ],
                  ),
                  textConfirm: 'Delete',
                  textCancel: 'Cancel',
                  onConfirm: () async {
                    String password = passwordController.text.trim();
                    if (password.isNotEmpty) {
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
                    } else {
                      Get.snackbar('Error', 'Password cannot be empty');
                    }
                    Get.back();
                  },
                );
              }),*/
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
              ElevatedButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: "Delete Account",
                    content: Column(
                      children: [
                        const Text("Please enter your password to confirm:"),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                        ),
                      ],
                    ),
                    textConfirm: "Delete",
                    textCancel: "Cancel",
                    onConfirm: () {
                      String password = passwordController.text.trim();
                      if (password.isNotEmpty) {
                        controller.deleteAccount(password);
                      } else {
                        Get.snackbar('Error', 'Password cannot be empty');
                      }
                      Get.back();
                    },
                  );
                },
                child: const Text('Delete Account'),
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
        dest = await controller.uploadFile(bytes, image.name);
      } else {
        dest = await controller.uploadFile(image.path, image.name);
      }
      if (dest != null) {
        await controller.updatePhotoURL(dest);
      }
    }
  }
}
