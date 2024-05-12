// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/services/auth_service.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        //This router outlet handles the appbar and the bottom navigation bar
        final currentLocation = currentRoute?.location;
        var currentIndex = 0;
        if (currentLocation?.startsWith(Routes.PRODUCTS) == true ||
            currentLocation?.startsWith(Routes.CART) == true) {
          currentIndex = 2;
        }
        if (currentLocation?.startsWith(Routes.PROFILE) == true) {
          currentIndex = 1;
        }
        return Scaffold(
          body: GetRouterOutlet(
            initialRoute: Routes.DASHBOARD,
            // anchorRoute: Routes.HOME,
            key: Get.nestedKey(Routes.HOME),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              switch (value) {
                case 0:
                  delegate.toNamed(Routes.HOME);
                case 1:
                  delegate.toNamed(Routes.PROFILE);
                case 2:
                  AuthService.to.isAdmin
                      ? delegate.toNamed(Routes.PRODUCTS)
                      : delegate.toNamed(Routes.CART);
                default:
              }
            },
            items: [
              // _Paths.HOME + [Empty]
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              // _Paths.HOME + Routes.PROFILE
              const BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded),
                label: 'Profile',
              ),
              // _Paths.HOME + _Paths.PRODUCTS
              BottomNavigationBarItem(
                icon: const Icon(Icons.trolley),
                label: AuthService.to.isAdmin ? 'Products' : 'Cart',
              ),
            ],
          ),
        );
      },
    );
  }
}
