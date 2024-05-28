// ignore_for_file: inference_failure_on_function_invocation

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/image_picker_button.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => profileScreen());
  }

  Widget profileScreen() {
    return ProfileScreen(
      // We are using the Flutter Fire Profile Screen now but will change in subsequent steps.
      // The issues are highlighted in commnets here

      // appBar: AppBar(
      //   title: const Text('User Profile'),
      // ),
      avatar: controller.photoURL == null
          ? Align(
              //we can add a check for the image availabity, default placeholder is shown by the FlutterFire plugin
              child: Image.asset('dash.png', width: 300, fit: BoxFit.fitWidth),
            )
          : Image.network(controller.photoURL!,
              width: 300,
              fit: BoxFit
                  .fitWidth), //null will give the profile image component but it does not refresh the pic when changed
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
        const Hero(
          tag: 'heroLogo',
          child: FlutterLogo(),
        ),
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
    );
  }
}
