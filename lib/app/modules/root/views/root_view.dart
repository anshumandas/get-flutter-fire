import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/screens.dart';
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
        final title = current!.currentPage!.title;
        return Scaffold(
          key: controller.scaffoldKey,
          drawer: const DrawerWidget(),
          appBar: AppBar(
            title: _buildTitle(title),
            centerTitle: true,
            leading: GetPlatform.isIOS &&
                current.locationString.contains(RegExp(r'(\/[^\/]*){3,}'))
                ? BackButton(
              onPressed: () => Get.rootDelegate.popRoute(),
            )
                : IconButton(
              icon: ImageIcon(
                const AssetImage("assets/icons/logo.png"),
                color: Colors.grey.shade800,
              ),
              onPressed: () => AuthService.to.isLoggedInValue
                  ? controller.openDrawer()
                  : {Screen.HOME.doAction()},
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

  Widget _buildTitle(String? title) {
    return Obx(() {
      final isSearching = controller.isSearching.value;
      return isSearching
          ? TextField(
        autofocus: true,
        onChanged: (value) {
          // Handle search query
        },
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
        ),
      )
          : Text(title ?? '');
    });
  }

  List<Widget> topRightMenuButtons(GetNavConfig current) {
    final isLoggedIn = AuthService.to.isLoggedInValue;
    final isAnonymous = AuthService.to.user?.isAnonymous ?? false;

    return [
      Container(
        margin: const EdgeInsets.only(right: 15),
        child: IconButton(
          icon: Icon(Icons.search, color: Colors.grey.shade800),
          onPressed: () {
            controller.isSearching.value = !controller.isSearching.value;
          },
        ),
      ),
      Container(
        margin: const EdgeInsets.only(right: 15),
        child: IconButton(
          icon: Icon(Icons.login, color: Colors.grey.shade800),
          onPressed: () {
            if (!isLoggedIn) {
              // Navigate to the Login screen
              Get.rootDelegate.toNamed(Screen.LOGIN.route);
            } else {
              // Handle logout if already logged in
              AuthService.to.logout(); // Ensure your logout logic is correct
            }
          },
        ),
      ),
      PopupMenuButton<String>(
        onSelected: (value) {
          // Handle your popup menu actions here
          if (value == 'Customer Support 24X7') {
            // Do something for Option 1
          } else if (value == 'My Orders') {
            // Do something for Option 2
          }
        },
        itemBuilder: (BuildContext context) {
          final items = <String>['Customer Support 24X7'];

          if (isLoggedIn && !isAnonymous) {
            items.add('My Orders');
          }

          return items.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
        icon: Icon(Icons.more_vert, color: Colors.grey.shade800),
      ),
    ];
  }
}
