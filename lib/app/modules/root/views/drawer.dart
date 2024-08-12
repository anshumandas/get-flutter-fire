// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../models/role.dart';
import '../../../../services/auth_service.dart';
import '../../../../models/screens.dart';
import '../../settings/controllers/settings_controller.dart';
import '../controllers/my_drawer_controller.dart';
=======

import '../../../../models/role.dart';
import '../../../../services/auth_service.dart';

import '../../../../models/screens.dart';
import '../../../../services/remote_config.dart';
import '../../../widgets/remotely_config_obx.dart';
>>>>>>> origin/main

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    MyDrawerController controller = Get.put(MyDrawerController([]),
        permanent: true); //must make true else gives error
    Screen.drawer().then((v) => {controller.values.value = v});
    return Obx(() => Drawer(
          //changing the shape of the drawer
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(0), bottomRight: Radius.circular(20)),
          ),
          width: 200,
          child: Column(
            children: drawerItems(context, controller.values),
          ),
        ));
  }

  List<Widget> drawerItems(BuildContext context, Rx<Iterable<Screen>> values) {
    SettingsController settingsController = Get.find<SettingsController>();
    final GetStorage storage = GetStorage();
    final bool isPhoneSignedIn = storage.read('isPhoneSignedIn') ?? false;
    final String phoneNumber = storage.read('phoneNumber') ?? '';

    List<Widget> list = [
      Obx(() => Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: settingsController.selectedPersona.value?.gradientColors ?? 
                    [Colors.red, Colors.red.shade700, Colors.red.shade900],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              CircleAvatar(
                radius: 40,
                backgroundImage: AuthService.to.user?.photoURL != null
                    ? NetworkImage(AuthService.to.user!.photoURL!)
                    : const AssetImage('assets/images/dash.png') as ImageProvider,
              ),
              const SizedBox(height: 10),
              Text(
                AuthService.to.user?.displayName ?? 'User Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  color: settingsController.selectedPersona.value?.textColor ?? Colors.white
                ),
              ),
              const SizedBox(height: 5),
              Text(
                isPhoneSignedIn ? phoneNumber : (AuthService.to.user?.email ?? 'Email'),
                style: TextStyle(
                    color: (settingsController.selectedPersona.value?.textColor ?? Colors.white).withOpacity(0.7)
                ),
              ),
              const SizedBox(height: 5),
              if (settingsController.selectedPersona.value != null)
                Text(
                  'Persona: ${settingsController.selectedPersona.value!.name}',
                  style: TextStyle(
                    color: (settingsController.selectedPersona.value?.textColor ?? Colors.white).withOpacity(0.7)
                  ),
                ),
            ],
          ),
        ),
      )),
=======
    return RemotelyConfigObxVal.noparam(
      (data) => Drawer(
        //changing the shape of the drawer
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(20)),
        ),
        width: 200,
        child: Column(
          children: drawerItems(context, data),
        ),
      ),
      List<Screen>.empty().obs,
      "useBottomSheetForProfileOptions",
      Typer.boolean,
      func: Screen.drawer,
    );
  }

  List<Widget> drawerItems(BuildContext context, Iterable<Screen> values) {
    List<Widget> list = [
      Container(
        height: 100,
        color: Colors.red,
        //adding content in the highlighted part of the drawer
        child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: const EdgeInsets.only(left: 15),
                child: const Text('User Name', //Profile Icon also
                    style: TextStyle(fontWeight: FontWeight.bold)))),
      )
>>>>>>> origin/main
    ];

    if (AuthService.to.maxRole.index > 1) {
      for (var i = 0; i <= AuthService.to.maxRole.index; i++) {
        Role role = Role.values[i];
        list.add(ListTile(
          title: Text(
            role.name,
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
          onTap: () {
            Get.rootDelegate
                .toNamed(Screen.HOME.route, arguments: {'role': role});
<<<<<<< HEAD
=======
            //to close the drawer
>>>>>>> origin/main
            Navigator.of(context).pop();
          },
        ));
      }
    }

<<<<<<< HEAD
    for (Screen screen in values.value) {
      list.add(ListTile(
        leading: Icon(screen.icon),
        title: Text(screen.label ?? ''),
        onTap: () {
          Get.rootDelegate.toNamed(screen.route);
=======
    for (Screen screen in values) {
      list.add(ListTile(
        title: Text(screen.label ?? ''),
        onTap: () {
          Get.rootDelegate.toNamed(screen.route);
          //to close the drawer

>>>>>>> origin/main
          Navigator.of(context).pop();
        },
      ));
    }

<<<<<<< HEAD
    // // Add Persona Selection option for Buyer role
    // if (AuthService.to.maxRole == Role.buyer) {
    //   list.add(ListTile(
    //     leading: Icon(Icons.person),
    //     title: Text('Select Persona'),
    //     onTap: () {
    //       Get.rootDelegate.toNamed(Routes.PERSONA_SELECTION);
    //       Navigator.of(context).pop();
    //     },
    //   ));
    // }

    if (AuthService.to.isLoggedInValue) {
      list.add(Spacer());
      list.add(ListTile(
        leading: Icon(Icons.logout, color: Colors.red),
=======
    if (AuthService.to.isLoggedInValue) {
      list.add(ListTile(
>>>>>>> origin/main
        title: const Text(
          'Logout',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        onTap: () {
          AuthService.to.logout();
          Get.rootDelegate.toNamed(Screen.LOGIN.route);
<<<<<<< HEAD
=======
          //to close the drawer

>>>>>>> origin/main
          Navigator.of(context).pop();
        },
      ));
    }
    if (!AuthService.to.isLoggedInValue) {
      list.add(ListTile(
<<<<<<< HEAD
        leading: Icon(Icons.login, color: Colors.blue),
=======
>>>>>>> origin/main
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        onTap: () {
          Get.rootDelegate.toNamed(Screen.LOGIN.route);
<<<<<<< HEAD
=======
          //to close the drawer

>>>>>>> origin/main
          Navigator.of(context).pop();
        },
      ));
    }

    return list;
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/main
