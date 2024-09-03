import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../../models/screens.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final role = controller.chosenRole.value;
      final route =
          role.tabs.isNotEmpty ? role.tabs[0].route : Screen.DASHBOARD.route;

      int currentIndex = role.getCurrentIndexFromRoute(Get.currentRoute);
      currentIndex = currentIndex.clamp(0, role.tabs.length - 1);

      return Scaffold(
        appBar: AppBar(
          title: Text('Shopping Master'),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/icons/Shopping Master1.png'),
          ),
        ),
        body: GetRouterOutlet(
          initialRoute: route,
        ),
        bottomNavigationBar: role.tabs.isNotEmpty
            ? BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (index) => role.routeTo(index, Get.rootDelegate),
                items: role.tabs
                    .map((Screen tab) => BottomNavigationBarItem(
                          icon: Icon(tab.icon),
                          label: tab.label ?? '',
                        ))
                    .toList(),
              )
            : null,
      );
    });
  }
}
