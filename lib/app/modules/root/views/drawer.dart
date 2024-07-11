// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/size_config.dart';
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
    SizeConfig.init(context);
    double drawerWidth = GetPlatform.isDesktop ? SizeConfig.w * 0.27 : SizeConfig.w * 0.7;
    
    return Obx(() => Drawer(
          //changing the shape of the drawer
          backgroundColor: const Color.fromARGB(255, 241, 241, 232),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          width: drawerWidth,
          child: Column(
            children: drawerItems(context, controller.values),
          ),
        ));
  }

  List<Widget> drawerItems(BuildContext context, Rx<Iterable<Screen>> values) {
    double sWidth = GetPlatform.isDesktop ? SizeConfig.w * 0.25: SizeConfig.w *0.6;
    List<Widget> list = [
      Container(
        height: SizeConfig.h * 0.37,
        color: const Color.fromARGB(255, 241, 241, 232),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(left: SizeConfig.h * 0.02,top: SizeConfig.h*0.02),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Color.fromARGB(255, 210, 214, 214)),
            child: SizedBox(
                height: sWidth,
                width: sWidth,
                child: ListView(
                  children: [
                    const SizedBox(height: 10),
                    CircleAvatar(
                      radius: 50.5,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(AuthService.to.userPhotoUrl ?? ''),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(top: SizeConfig.h * 0.01),
                        child: Text(
                          '${AuthService.to.userName}',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        AuthService.to.userEmail ?? '',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(169, 37, 38, 39)),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      )
    ];

    if (AuthService.to.maxRole.index > 1) {
      for (var i = 0; i <= AuthService.to.maxRole.index; i++) {
        Role role = Role.values[i];
        list.add(ListTile(
          tileColor: const Color.fromARGB(255, 241, 241, 232),
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

    for (Screen screen in values.value) {
      list.add(Padding(
          padding: EdgeInsets.only(left: SizeConfig.h * 0.01),
          child: ListTile(
            tileColor: const Color.fromARGB(255, 241, 241, 232),
            leading: Icon(
              screen.icon,
              color: Colors.black,
              // size: SizeConfig.w * 0.08,
            ),
            title: Text(
              screen.label ?? '',
              style: const TextStyle(
                  color: Colors.black,
                 
                  fontWeight: FontWeight.w400),
            ),
            onTap: () {
              Get.rootDelegate.toNamed(screen.route);
              //to close the drawer

              Navigator.of(context).pop();
            },
          )));
    }

    if (AuthService.to.isLoggedInValue) {
      list.add(const Spacer(
        flex: 1,
      ));
      list.add(Padding(
          padding: EdgeInsets.only(left: SizeConfig.h * 0.01),
          child: ListTile(
            leading: Icon(
              Icons.logout_sharp,
              color: Colors.black,
              // size: SizeConfig.w * 0.08,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w400),
            ),
            onTap: () {
              AuthService.to.logout();
              Get.rootDelegate.toNamed(Screen.LOGIN.route);
              //to close the drawer

              Navigator.of(context).pop();
            },
          )));
      list.add(SizedBox(
        height: SizeConfig.h * 0.02,
      ));
    }
    if (!AuthService.to.isLoggedInValue) {
      list.add(const Spacer(
        flex: 1,
      ));
      list.add(Padding(
          padding: EdgeInsets.only(left: SizeConfig.h * 0.01),
          child: ListTile(
            leading: Icon(
              Icons.login_sharp,
              color: Colors.black,
              // size: SizeConfig.w * 0.08,
            ),
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
          )));
    }

    return list;
  }
}
