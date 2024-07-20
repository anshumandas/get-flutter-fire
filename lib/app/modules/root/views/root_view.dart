// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import '../../../routes/app_pages.dart';
import '../../../../models/screens.dart';
import '../../../utils/icon_constants.dart';
import '../../../widgets/screen_widget.dart';
import '../controllers/root_controller.dart';
import 'drawer.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        final title = current!.currentPage!.title;
        controller.updateMenuButtons(current);
        return Scaffold(
          key: controller.scaffoldKey,
          drawer: const DrawerWidget(),
          appBar: AppBar(
            title: Text(title ?? ''),
            centerTitle: true,
            leading: GetPlatform.isIOS // Since Web and Android have back button
                    &&
                    current.locationString.contains(RegExp(r'(\/[^\/]*){3,}'))
                ? BackButton(
                    onPressed: () =>
                        Get.rootDelegate.popRoute(), //Navigator.pop(context),
                  )
                : IconButton(
                    icon: ImageIcon(
                      const AssetImage(IconConstants.logo),
                      color: Colors.grey.shade800,
                    ),
                    onPressed: () => AuthService.to.isLoggedInValue
                        ? controller.openDrawer()
                        : {Screen.HOME.doAction()},
                  ),
            actions: [
              Obx(() {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: controller.menuButtons.toList(),
                );
              }),
            ],
            // automaticallyImplyLeading: false, //removes drawer icon
          ),
          body: GetRouterOutlet(
            initialRoute: AppPages.INITIAL,
            // anchorRoute: '/',
            // filterPages: (afterAnchor) {
            //   return afterAnchor.take(1);
            // },
          ),
        );
      },
    );
  }
}
