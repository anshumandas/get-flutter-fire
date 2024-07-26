// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import '../../../../models/teams.dart';
import '../../../routes/app_pages.dart';
import '../../../../models/screens.dart';
import '../../../utils/icon_constants.dart';
import '../controllers/root_controller.dart';
import 'drawer.dart';

class RootView extends GetView<RootController> {
  // const RootView({super.key});

  final RxBool isSearchBarVisible = false.obs;
  final RxList<Team> searchResults = <Team>[].obs;

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        final title = current!.currentPage!.title;
        final isHomePage = current.currentPage!.name == Routes.HOME;
        return Scaffold(
          key: controller.scaffoldKey,
          drawer: const DrawerWidget(),
          appBar: AppBar(
              title: Text(title ?? ''),
              centerTitle: true,
              leading: GetPlatform
                          .isIOS // Since Web and Android have back button
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
                if (isHomePage)
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      isSearchBarVisible.value = !isSearchBarVisible.value;
                    },
                  ),
                Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: Screen.LOGIN.widget(current))
              ]
              // automaticallyImplyLeading: false, //removes drawer icon
              ),
          body: Stack(children: [
            GetRouterOutlet(
              initialRoute: AppPages.INITIAL,
              // anchorRoute: '/',
              // filterPages: (afterAnchor) {
              //   return afterAnchor.take(1);
              // },
            ),
            //
            Obx(() {
              if (isSearchBarVisible.value && isHomePage) {
                return buildSearchBar();
              } else {
                return SizedBox
                    .shrink(); //an empty widget with zero width and height, effectively hiding the search bar.
              }
            })
          ]),
        );
      },
    );
  }

//Method to build the Search Bar
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
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey, width: 1.0)),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      suffixIcon: IconButton(
                        onPressed: () {
                          searchController.clear();
                          searchResults.clear();
                          print('Clear button is working');
                        },
                        icon: Icon(
                          Icons.clear,
                          size: 21,
                        ),
                      )),
                  onChanged: (value) {
                    print('Typed: $value');
                    searchResults.value = searcht(value);
                  },
                ),
              ),
              if (searchResults.isNotEmpty)
                Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final team = searchResults[index];
                          return ListTile(
                            title: Text(team.name),
                            subtitle: Text('Captain: ${team.captain}'),
                            trailing: Text('Titles: ${team.titles}'),
                            onTap: () {
                              print('Selected: ${team.name}');
                              searchController.text = team.name;
                              searchResults.clear();
                            },
                          );
                        },
                      ),
                    )),
            ]),
          );
        }));
  }

//This could be used to add icon buttons in expanded web view instead of the context menu
  // List<Widget> topRightMenuButtons(GetNavConfig current, bool isHomePage) {
  //   return [
  //     //Search Button
  //     if (isHomePage)
  //       IconButton(
  //         icon: Icon(Icons.search),
  //         onPressed: () {
  //           isSearchBarVisible.value = !isSearchBarVisible.value;
  //         },
  //       ),
  //     Container(
  //         margin: const EdgeInsets.only(right: 15),
  //         child: Screen.LOGIN.widget(current))
  //   ]; //TODO add seach button
  // }
}

List<Team> searcht(String query) {
  query = query.toLowerCase().trim();
  return teams.where((team) {
    final name = team.name.toLowerCase();
    final captain = team.captain.toLowerCase();
    final shortForm =
        name.split(' ').map((word) => word[0]).join().toLowerCase();
    return name.contains(query) ||
        captain.contains(query) ||
        shortForm.contains(query);
  }).toList();
}
