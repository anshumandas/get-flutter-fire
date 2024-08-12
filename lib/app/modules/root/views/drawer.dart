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
