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
  RootView({super.key});
  final RxBool isSearchBarVisible = false.obs;

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
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Toggle search bar visibility
                  isSearchBarVisible.value = !isSearchBarVisible.value;
                },
              ),
              topRightMenuButtons(current),
            ],
          ),
          body: Stack(
            children: [
              GetRouterOutlet(
                initialRoute: AppPages.INITIAL,
              ),
              Obx(() {
                if (isSearchBarVisible.value) {
                  return buildSearchBar();
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ],
          ),
        );
      },
    );
  }

  Widget topRightMenuButtons(GetNavConfig current) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Screen.LOGIN.widget(current),
    );
  }

Widget buildSearchBar() {
  final TextEditingController searchController = TextEditingController();

  return Positioned(
    top: 0,
    left: 10,
    right: 10,
    child: Obx(() {
      return Visibility(
        visible: isSearchBarVisible.value,
        maintainState: true,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        searchController.clear();
                        print('Clear button pressed');
                      },
                    ),
                  ),
                  onChanged: (value) {
                    print('Typed: $value');
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_outlined),
                onPressed: () {
                  String searchText = searchController.text.trim();
                  if (searchText.isNotEmpty) {
                    print('Performing search for: $searchText');
                    isSearchBarVisible.value = false;
                  } else {
                    print('Search text is empty');
                  }
                },
              ),
            ],
          ),
        ),
      );
    }),
  );
}
}
