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
  final bool isWeb;

  const ScreenWidget({
    super.key,
    required this.body,
    required this.screen,
    this.role = Role.buyer,
    this.delegate,
    this.currentRoute,
    this.appBar,
    this.isWeb = false,
  });

  @override
  Widget build(BuildContext context) {
    int currentIndex = role?.getCurrentIndexFromRoute(currentRoute) ?? 0;
    Iterable<Screen> fabs = screen.fabs;

    return Scaffold(
      appBar: appBar,
      body: isWeb
          ? Row(
        children: [
          if (screen.navTabs.isNotEmpty)
            NavigationRail(
              selectedIndex: currentIndex,
              onDestinationSelected: (value) {
                if (delegate != null) {
                  role!.routeTo(value, delegate!);
                }
              },
              labelType: NavigationRailLabelType.all,
              destinations: role!.tabs
                  .map((Screen tab) => NavigationRailDestination(
                icon: Icon(tab.icon),
                label: Text(tab.label!),
              ))
                  .toList(),
            ),
          Expanded(child: body),
        ],
      )
          : body,
      bottomNavigationBar: (!isWeb && screen.navTabs.isNotEmpty)
          ? Container( decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
            child: BottomNavigationBar(
              backgroundColor: Color.fromARGB(255, 15, 43, 16),
              selectedItemColor: Colors.white,
              unselectedItemColor: Color.fromARGB(255, 137, 244, 230),
                    currentIndex: currentIndex,
                    onTap: (value) {
            if (delegate != null) {
              role!.routeTo(value, delegate!);
            }
                    },
                    items: role!.tabs
              .map((Screen tab) => BottomNavigationBarItem(
            icon: Icon(tab.icon),
            label: tab.label,
                    ))
              .toList(),
                  ),
          ))
          : null,
      floatingActionButton: fabs.isNotEmpty ? getFAB(fabs) : null,
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
    return null;
  }
}