<<<<<<< HEAD
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

=======
// ignore_for_file: inference_failure_on_function_invocation

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/auth_service.dart';
import '../../../../models/screens.dart';
import '../../../utils/img_constants.dart';
import '../../../widgets/change_password_dialog.dart';
import '../../../widgets/image_picker_button.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
>>>>>>> origin/main
  ShapeBorder get shape => const CircleBorder();
  double get size => 120;
  Color get placeholderColor => Colors.grey;

  Widget _imageFrameBuilder(
<<<<<<< HEAD
      BuildContext context,
      Widget? child,
      int? frame,
      bool? _,
      ) {
    if (frame == null) {
      return Container(color: placeholderColor);
    }
=======
    BuildContext context,
    Widget? child,
    int? frame,
    bool? _,
  ) {
    if (frame == null) {
      return Container(color: placeholderColor);
    }

>>>>>>> origin/main
    return child!;
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
            child: Obx(() => controller.photoURLValue != null
                ? Image.network(
              controller.photoURLValue!,
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
=======
    return Obx(() => profileScreen());
  }

  Widget profileScreen() {
    return AuthService.to.isLoggedInValue
        ? ProfileScreen(
            // We are using the Flutter Fire Profile Screen now but will change in subsequent steps.
            // The issues are highlighted in comments here

            // appBar: AppBar(
            //   title: const Text('User Profile'),
            // ),
            avatar: SizedBox(
              //null will give the profile image component but it does not refresh the pic when changed
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
                        cacheWidth: size.toInt(),
                        cacheHeight: size.toInt(),
                        fit: BoxFit.contain,
                        frameBuilder: _imageFrameBuilder,
                      )
                    : Center(
                        child: Image.asset(
                          ImgConstants.dash,
                          width: size,
                          fit: BoxFit.contain,
                        ),
                      ),
              ),
            ),
            // showDeleteConfirmationDialog: true, //this does not work properly. Possibly a bug in FlutterFire
            actions: [
              SignedOutAction((context) {
                Get.back();
                controller.logout();
                Get.rootDelegate.toNamed(Screen.PROFILE.route);
                // Navigator.of(context).pop();
              }),
              AccountDeletedAction((context, user) {
                //If we don't include this the button is still shown but no action gets done. Ideally the button should also not be shown. Its a bug in FlutterFire
                Get.defaultDialog(
                  //this is only called after the delete is done and not useful for confirmation of the delete action
                  title: 'Deleted Account of ${user.displayName}',
                  barrierDismissible: true,
                  navigatorKey: Get.nestedKey(Screen.HOME.route),
                );
              })
            ],
            children: [
              //This is to show that we can add custom content here
              const Divider(),
              controller.currentUser?.email != null
                  ? TextButton.icon(
                      onPressed: callChangePwdDialog,
                      label: const Text('Change Password'),
                      icon: const Icon(Icons.password_rounded),
                    )
                  : const SizedBox.shrink(),
              ImagePickerButton(callback: (String? path) async {
                if (path != null) {
                  //Upload to Store
                  String? dest = await controller.uploadFile(path);
                  //attach it to User imageUrl
                  if (dest != null) {
                    await controller.updatePhotoURL(dest);
                  }
                }
              })
            ],
          )
>>>>>>> origin/main
        : const Scaffold();
  }

  void callChangePwdDialog() {
    var dlg = ChangePasswordDialog(controller.currentUser!);
    Get.defaultDialog(
<<<<<<< HEAD
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
        // For mobile/desktop, pass the file path and filename
        dest = await controller.uploadFile(image.path, image.name);
      }
      if (dest != null) {
        await controller.updatePhotoURL(dest);
      }
    }
  }
}
=======
        title: "Change Password",
        content: dlg,
        textConfirm: "Submit",
        textCancel: "Cancel",
        onConfirm: dlg.onSubmit);
  }
}
>>>>>>> origin/main
