// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/role.dart';
import '../../../../services/auth_service.dart';

import '../../../../models/screens.dart';
import '../../../../services/remote_config.dart';
import '../../../widgets/remotely_config_obx.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        height: 200,
        width: double.infinity,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              CircleAvatar(
                radius: 40,
                backgroundImage: AuthService.to.user?.photoURL != null
                    ? NetworkImage(AuthService.to.user!.photoURL!)
                    : const AssetImage('assets/images/dash.png') as ImageProvider,
              ),
              const SizedBox(height: 10),
              Text(
                AuthService.to.user?.displayName ?? 'User Name',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                AuthService.to.user?.email ?? 'Email',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
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
            //to close the drawer
            Navigator.of(context).pop();
          },
        ));
      }
    }

    for (Screen screen in values) {
      list.add(ListTile(
        title: Text(screen.label ?? ''),
        onTap: () {
          Get.rootDelegate.toNamed(screen.route);
          //to close the drawer

          Navigator.of(context).pop();
        },
      ));
    }

    if (AuthService.to.isLoggedInValue) {
      list.add(ListTile(
        title: const Text(
          'Logout',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        onTap: () {
          AuthService.to.logout();
          Get.rootDelegate.toNamed(Screen.LOGIN.route);
          //to close the drawer

          Navigator.of(context).pop();
        },
      ));
    }
    if (!AuthService.to.isLoggedInValue) {
      list.add(ListTile(
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        onTap: () {
          Get.rootDelegate.toNamed(Screen.LOGIN.route);
          //to close the drawer

          Navigator.of(context).pop();
        },
      ));
    }

    return list;
  }
}
