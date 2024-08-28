// views/root_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/categories.dart'; // Updated to use categories
import '../../../../services/auth_service.dart';
import '../../../routes/app_pages.dart';
import '../../../../models/screens.dart';
import '../../../utils/icon_constants.dart';
import '../controllers/root_controller.dart';
import 'drawer.dart';

class RootView extends GetView<RootController> {
  final RxBool isSearchBarVisible = false.obs;
  final RxList<String> searchResults = <String>[].obs;

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
            leading: GetPlatform.isIOS &&
                current.locationString.contains(RegExp(r'(\/[^\/]*){3,}'))
                ? BackButton(
              onPressed: () => Get.rootDelegate.popRoute(),
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
            actions: topRightMenuButtons(current),
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
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                        searchResults.clear();
                      },
                      icon: const Icon(Icons.clear, size: 21),
                    ),
                  ),
                  onChanged: (value) {
                    searchResults.value = searchCategories(value).cast<String>();
                  },
                ),
              ),
              if (searchResults.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final category = searchResults[index];
                        return ListTile(
                          title: Text(category),
                          onTap: () {
                            searchController.text = category;
                            searchResults.clear();
                            // Navigate to SearchView
                            Get.toNamed('/search');
                          },
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  List<Widget> topRightMenuButtons(GetNavConfig current) {
    return [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          isSearchBarVisible.value = !isSearchBarVisible.value;
        },
      ),
      Container(
        margin: const EdgeInsets.only(right: 15),
        child: IconButton(
          icon: const Icon(Icons.login),
          onPressed: () {
            // Handle login button action
          },
        ),
      ),
    ];
  }
}

List<Category> searchCategories(String query) {
  query = query.toLowerCase().trim();
  return categories.where((category) {
    final name = category.name.toLowerCase();
    return name.contains(query);
  }).toList();
}
