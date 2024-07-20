import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';
import '../../models/role.dart';
import '../../models/screens.dart';

class ScreenWidget extends StatefulWidget {
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
  _ScreenWidgetState createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<ScreenWidget> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    // Initialize currentIndex based on the role and route
    _currentIndex = widget.role != null
        ? widget.role!.getCurrentIndexFromRoute(widget.currentRoute)
        : 0;
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (widget.delegate != null) {
      widget.role!.routeTo(index, widget.delegate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = GetPlatform.isDesktop;
    Iterable<Screen> fabs = widget.screen.fabs;

    return Scaffold(
      body: widget.body,
      appBar: widget.appBar,
      bottomNavigationBar: isDesktop || widget.screen.navTabs.isEmpty
          ? null
          : BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: Colors.black, 
              unselectedItemColor: Colors.grey, 
              onTap: _onTabTapped,
              items: widget.role!.tabs
                  .map((Screen tab) => BottomNavigationBarItem(
                        icon: Icon(tab.icon),
                        label: tab.label,
                      ))
                  .toList(),
            ),
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
    return null; //TODO multi fab button on press
  }
}
