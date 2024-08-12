<<<<<<< HEAD
=======
// ignore_for_file: inference_failure_on_function_invocation

>>>>>>> origin/main
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import '../../../routes/app_pages.dart';
import '../../../../models/screens.dart';
<<<<<<< HEAD
=======
import '../../../utils/icon_constants.dart';
import '../../../widgets/screen_widget.dart';
>>>>>>> origin/main
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
<<<<<<< HEAD
            title: Obx(() => controller.isSearching.value
              ? _buildSearchBar()
              : Text(title ?? '', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
            ),
            backgroundColor: Color.fromARGB(255, 15, 43, 16),
            centerTitle: false,
            leading: GetPlatform.isIOS && current.locationString.contains(RegExp(r'(\/[^\/]*){3,}'))
              ? BackButton(onPressed: () => Get.rootDelegate.popRoute())
              : IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                  onPressed: () => AuthService.to.isLoggedInValue
                    ? controller.openDrawer()
                    : Screen.HOME.doAction(),
                ),
            actions: [
              IconButton(
                icon: Icon(controller.isSearching.value ? Icons.close : Icons.search),
                onPressed: () => controller.toggleSearch(),
              ),
              _buildProfileMenu(),
            ],
          ),
          body: GetRouterOutlet(
            initialRoute: AppPages.INITIAL,
=======
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
            actions: ScreenWidgetExtension.topRightMenuButtons(current),
            // automaticallyImplyLeading: false, //removes drawer icon
          ),
          body: GetRouterOutlet(
            initialRoute: AppPages.INITIAL,
            // anchorRoute: '/',
            // filterPages: (afterAnchor) {
            //   return afterAnchor.take(1);
            // },
>>>>>>> origin/main
          ),
        );
      },
    );
  }
<<<<<<< HEAD

  Widget _buildSearchBar() {
    return Container(
      width: 200, // Adjust this width as needed
      child: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.white60),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
        style: TextStyle(color: Colors.white),
        onSubmitted: (value) {
          // Perform search
          print('Searching for: $value');
          controller.toggleSearch(); // Close search bar after submission
        },
      ),
    );
  }

  Widget _buildProfileMenu() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.account_circle, color: Colors.white),
      onSelected: (value) {
        switch (value) {
          case 'profile':
            Screen.PROFILE.doAction();
            break;
          case 'logout':
            AuthService.to.logout();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'profile',
          child: Text('Profile'),
        ),
        const PopupMenuItem<String>(
          value: 'logout',
          child: Text('Logout'),
        ),
      ],
    );
  }
}
=======
}
>>>>>>> origin/main
