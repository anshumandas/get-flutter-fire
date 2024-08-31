// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/role.dart';
import '../../../../services/auth_service.dart';

import '../../../../models/screens.dart';
import '../controllers/my_drawer_controller.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
    List<Widget> list = [
      Container(
        height: 100,
        color: Colors.blueAccent,
        //adding content in the highlighted part of the drawer
        child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: const EdgeInsets.only(left: 15),
              child: Text(
                '${AuthService.to.userName}',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
        )
        )
      ];

    if (AuthService.to.maxRole.index > 1) {
      for (var i = 0; i <= AuthService.to.maxRole.index; i++) {
        Role role = Role.values[i];
        list.add(ListTile(
          title: Text(
            role.name,
            style: const TextStyle(
              color: Colors.orangeAccent,
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

    for (Screen screen in values.value) {
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
