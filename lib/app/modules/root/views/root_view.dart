// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/auth_service.dart';
import '../../../routes/app_pages.dart';
import '../controllers/root_controller.dart';
import 'drawer.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        final title = current?.location;
        return Scaffold(
          drawer: const DrawerWidget(),
          appBar: AppBar(
            title: Text(title ?? ''),
            centerTitle: true,
            actions: [
              Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: IconButton(
                      // padding: EdgeInsets.zero,
                      // constraints: const BoxConstraints(),
                      tooltip:
                          (AuthService.to.isLoggedInValue) ? 'Logout' : 'Login',
                      icon: (AuthService.to.isLoggedInValue)
                          ? const Icon(Icons.logout)
                          : const Icon(Icons.login),
                      onPressed: () {
                        if (AuthService.to.isLoggedInValue) {
                          AuthService.to.logout();
                        }
                        Get.rootDelegate.toNamed(Routes.LOGIN);
                      }))
            ],
            // automaticallyImplyLeading: false, //removes drawer
          ),
          body: GetRouterOutlet(
            initialRoute: Routes.HOME,
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
