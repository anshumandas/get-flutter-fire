import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/auth_service.dart';
import '../../../../models/screens.dart';
import '../controllers/my_drawer_controller.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyDrawerController controller =
        Get.put(MyDrawerController([]), permanent: true);
    Screen.drawer().then((v) => {controller.values.value = v});
    return Obx(() => Drawer(
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
      // ... (other items remain the same)
    ];

    if (AuthService.to.isLoggedIn) {
      list.add(ListTile(
        title: const Text(
          'Logout',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        onTap: () {
          AuthService.to.signOut();
          Get.rootDelegate.toNamed(Screen.LOGIN.route);
          Navigator.of(context).pop();
        },
      ));
    }
    if (!AuthService.to.isLoggedIn) {
      list.add(ListTile(
        title: const Text(
          'Login',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        onTap: () {
          Get.rootDelegate.toNamed(Screen.LOGIN.route);
          Navigator.of(context).pop();
        },
      ));
    }

    return list;
  }
}
