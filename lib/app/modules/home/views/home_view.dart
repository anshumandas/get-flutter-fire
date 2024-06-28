import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/screens.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        var arg = Get.rootDelegate.arguments();
        if (arg != null) {
          controller.chosenRole.value = arg["role"];
        }
        var route = controller.chosenRole.value.tabs[0].route;
        //This router outlet handles the appbar and the bottom navigation bar
        int currentIndex =
            controller.chosenRole.value.getCurrentIndexFromRoute(currentRoute);
        return Scaffold(
          body: GetRouterOutlet(
            initialRoute: route,
            // anchorRoute: Routes.HOME,
            key: Get.nestedKey(route),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              controller.chosenRole.value.routeTo(value, delegate);
            },
            items: controller.chosenRole.value.tabs
                .map((Screen tab) => BottomNavigationBarItem(
                      icon: Icon(tab.icon),
                      label: tab.label,
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
