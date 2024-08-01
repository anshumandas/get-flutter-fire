import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/foundation.dart' show kIsWeb;
=======
>>>>>>> origin/main
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/screen_widget.dart';
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
<<<<<<< HEAD
=======
        //This router outlet handles the appbar and the bottom navigation bar
>>>>>>> origin/main
        return ScreenWidget(
          screen: screen!,
          body: GetRouterOutlet(
            initialRoute: route,
<<<<<<< HEAD
=======
            // anchorRoute: Routes.HOME,
>>>>>>> origin/main
            key: Get.nestedKey(route),
          ),
          role: controller.chosenRole.value,
          delegate: delegate,
          currentRoute: currentRoute,
<<<<<<< HEAD
          isWeb: kIsWeb,
=======
>>>>>>> origin/main
        );
      },
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/main
