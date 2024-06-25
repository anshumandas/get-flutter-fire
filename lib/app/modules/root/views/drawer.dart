// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/auth_service.dart';

import '../../../routes/screens.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //changing the shape of the drawer
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(0), bottomRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            height: 100,
            color: Colors.red,
            //adding content in the highlighted part of the drawer
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: const Text('Application Name',
                        style: TextStyle(fontWeight: FontWeight.bold)))),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Get.rootDelegate.toNamed(Screen.HOME.route);
              //to close the drawer

              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Get.rootDelegate.toNamed(Screen.SETTINGS.route);
              //to close the drawer

              Navigator.of(context).pop();
            },
          ),
          if (AuthService.to.isLoggedInValue)
            ListTile(
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
            ),
          if (!AuthService.to.isLoggedInValue)
            ListTile(
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
            ),
        ],
      ),
    );
  }
}
