import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/auth_service.dart';
import '../../../../models/role.dart';
import '../../../../models/screens.dart';
import '../../../../utils/size_config.dart';
import '../controllers/my_drawer_controller.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MyDrawerController controller =
        Get.put(MyDrawerController([]), permanent: true);
    Screen.drawer().then((v) => {controller.values.value = v});
    SizeConfig.init(context);
    double drawerWidth =
        GetPlatform.isDesktop ? SizeConfig.w * 0.27 : SizeConfig.w * 0.7;

    return Obx(() {
      Role userRole = AuthService.to.maxRole;
      return LayoutBuilder(
        builder: (context, constraints) {
          bool isHorizontal = GetPlatform.isDesktop;

          double leftPanelWidth =
              isHorizontal ? SizeConfig.w * 0.16 : drawerWidth;

          return Row(
            children: [
              if (isHorizontal)
                Container(
                  width: SizeConfig.w * 0.08,
                  color: Colors.blueGrey,
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.h * 0.1),
                      IconButton(
                        icon: const Icon(Icons.dashboard),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      if (GetPlatform.isDesktop)
                        ...userRole.tabs.map((tab) => Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: IconButton(
                                icon: Icon(tab.icon),
                                onPressed: () {
                                  Get.rootDelegate.toNamed(tab.route);
                                  Navigator.of(context).pop();
                                },
                              ),
                            )),
                    ],
                  ),
                ),
              SizedBox(
                width: leftPanelWidth,
                child: Drawer(
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: drawerItems(context, controller.values),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  List<Widget> drawerItems(BuildContext context, Rx<Iterable<Screen>> values) {
    double sWidth =
        GetPlatform.isDesktop ? SizeConfig.w * 0.25 : SizeConfig.w * 0.7;
    List<Widget> list = [
      Container(
        height: SizeConfig.h * 0.37,
        color: Colors.blueGrey,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(
                left: SizeConfig.h * 0.02,
                top: SizeConfig.h * 0.02,
                right: SizeConfig.h * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.white,
            ),
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
                              fontWeight: FontWeight.bold),
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
                    const SizedBox(height: 10),
                  ],
                )),
          ),
        ),
      ),
      Obx(
        () {
          return Column(
            children: values.value.map((screen) {
              return Padding(
                padding: EdgeInsets.only(left: SizeConfig.h * 0.01),
                child: ListTile(
                  leading: Icon(screen.icon),
                  title: Text(
                    screen.label ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                  onTap: () {
                    Get.rootDelegate.toNamed(screen.route);
                    Navigator.of(context).pop();
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    ];

    if (AuthService.to.isLoggedInValue) {
      list.add(const Spacer(flex: 1));
      list.add(
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.h * 0.01),
          child: ListTile(
            leading: const Icon(
              Icons.logout_sharp,
              color: Colors.black,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
            ),
            onTap: () {
              AuthService.to.logout();
              Get.rootDelegate.toNamed(Screen.LOGIN.route);
              Navigator.of(context).pop();
            },
          ),
        ),
      );
      list.add(SizedBox(height: SizeConfig.h * 0.02));
    } else {
      list.add(const Spacer(flex: 1));
      list.add(
        Padding(
          padding: EdgeInsets.only(left: SizeConfig.h * 0.01),
          child: ListTile(
            leading: const Icon(
              Icons.login_sharp,
              color: Colors.black,
            ),
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
          ),
        ),
      );
    }

    return list;
  }
}
