import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';
import '../../models/role.dart';
import '../../models/screens.dart';

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
    print('role : $role');
    bool isDesktop = GetPlatform.isDesktop;
    Iterable<Screen> fabs = screen.fabs;
    return Scaffold(
      body: body,
      appBar: appBar,
      bottomNavigationBar: isDesktop || screen.navTabs.isEmpty
          ? null
          : BottomNavigationBar(
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
            ),
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
