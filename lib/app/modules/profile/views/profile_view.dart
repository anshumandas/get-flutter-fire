// ignore_for_file: inference_failure_on_function_invocation

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/auth_service.dart';
import '../../../routes/app_pages.dart';
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
        ? ProfileScreen(
            // We are using the Flutter Fire Profile Screen now but will change in subsequent steps.
            // The issues are highlighted in commnets here

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
                          'assets/images/dash.png',
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
                Get.rootDelegate.toNamed(Routes.PROFILE);
                // Navigator.of(context).pop();
              }),
              AccountDeletedAction((context, user) {
                //If we don't include this the button is still shown but no action gets done. Ideally the button should also not be shown. Its a bug in FlutterFire
                Get.defaultDialog(
                  //this is only called after the delete is done and not useful for confirmation of the delete action
                  title: 'Deleted Account of ${user.displayName}',
                  barrierDismissible: true,
                  navigatorKey: Get.nestedKey(Routes.HOME),
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
              ImagePickerButton((String? path) async {
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
        : const Scaffold();
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
