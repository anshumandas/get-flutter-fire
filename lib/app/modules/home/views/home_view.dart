import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/screens.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        //This router outlet handles the appbar and the bottom navigation bar
        int currentIndex =
            controller.chosenRole.value.getCurrentIndexFromRoute(currentRoute);
        return Scaffold(
          body: GetRouterOutlet(
            initialRoute: controller.chosenRole.value.tabs[0].route,
            // anchorRoute: Routes.HOME,
            key: Get.nestedKey(Routes.HOME),
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
