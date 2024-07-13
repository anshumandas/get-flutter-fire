import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';
import '../../models/role.dart';
import '../../models/screens.dart';
import 'login_widgets.dart';

class ScreenWidget extends StatelessWidget {
  final Widget body;
  final Role? role;

  final GetDelegate? delegate;

  final GetNavConfig? currentRoute;

  final Screen screen;
  final AppBar? appBar;

  const ScreenWidget({
    super.key,
    required this.body,
    required this.screen,
    this.role = Role.buyer,
    this.delegate,
    this.currentRoute,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    int currentIndex =
        role != null ? role!.getCurrentIndexFromRoute(currentRoute) : 0;
    Iterable<Screen> fabs = screen.fabs;
    return Scaffold(
      body: body,
      appBar: appBar,
      bottomNavigationBar: (screen.navTabs.isNotEmpty)
          ? BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (value) {
                if (delegate != null) {
                  role!.routeTo(value, delegate!);
                }
              },
              items:
                  role!.tabs //screen may have more navTabs but we need by role
                      .map((Screen tab) => BottomNavigationBarItem(
                            icon: Icon(tab.icon),
                            label: tab.label,
                          ))
                      .toList(),
            )
          : null,
      floatingActionButton: fabs.isNotEmpty ? getFAB(fabs) : null,
      // bottomSheet: //this is used for persistent bar like status bar
    );
  }

  FloatingActionButton? getFAB(Iterable<Screen> fabs) {
    if (fabs.length == 1) {
      var screen = fabs.firstOrNull!;
      return FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () => Get.rootDelegate.toNamed(screen.route),
        label: Text(screen.label ?? ''),
        icon: screen.icon == null
            ? null
            : Icon(
                screen.icon,
                color: Colors.white,
              ),
      );
    }
    return null; //TODO multi fab button on press
  }
}

extension ScreenWidgetExtension on Screen {
  Widget? widget(GetNavConfig current) {
    //those with accessor == widget must be handled here
    switch (this) {
      case Screen.SEARCH:
        return IconButton(onPressed: () => {}, icon: Icon(icon));
      case Screen.LOGIN:
        return LoginBottomSheetToggle(current);
      case Screen.LOGOUT:
        return LoginBottomSheetToggle(current);
      default:
    }
    return null;
  }

//This could be used to add icon buttons in expanded web view instead of the context menu
  static List<Widget> topRightMenuButtons(GetNavConfig current) {
    List<Widget> widgets = [];
    Screen.topRightMenu().then((v) {
      for (var screen in v) {
        widgets.add(Container(
            margin: const EdgeInsets.only(right: 15),
            child: screen.widget(current)));
      }
    });
    return widgets; //This will return empty. We need a Obx
  }
}
