import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import '../../../routes/app_pages.dart';
import '../../../../models/screens.dart';
import '../controllers/root_controller.dart';
import 'drawer.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        final title = current!.currentPage!.title;
        return Scaffold(
          key: controller.scaffoldKey,
          drawer: const DrawerWidget(),
          appBar: AppBar(
            title: Text(title ?? ''),
            centerTitle: true,
            leading: GetPlatform
                        .isIOS && // Since Web and Android have back button
                    current.locationString.contains(RegExp(r'(\/[^\/]*){3,}'))
                ? BackButton(
                    onPressed: () => Get.rootDelegate.popRoute(),
                  )
                : GestureDetector(
                    onTap: () => AuthService.to.isLoggedIn
                        ? controller.openDrawer()
                        : Screen.HOME.doAction(),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                        "assets/icons/Shopping Master1.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
            actions: topRightMenuButtons(current),
          ),
          body: GetRouterOutlet(
            initialRoute: AppPages.INITIAL,
          ),
        );
      },
    );
  }

  List<Widget> topRightMenuButtons(GetNavConfig current) {
    return [
      Container(
          margin: const EdgeInsets.only(right: 15),
          child: Screen.LOGIN.widget(current))
    ];
  }
}
