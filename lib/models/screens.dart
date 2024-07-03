import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/widgets/login_widgets.dart';
import 'action_enum.dart';
import 'access_level.dart';
import '../../services/auth_service.dart';

enum AccessedVia {
  auto,
  widget, //example: top right button
  navigator, //bottom nav. can be linked to drawer items //handled in ScreenWidget
  drawer, //creates nav tree //handled in RootView
  bottomSheet, //context menu for web handled via the Button that calls the sheet
  fab, //handled in ScreenWidget
  singleTap, //when an item of a list is clicked
  longTap //or double click
}

enum Screen implements ActionEnum {
  HOME('/home',
      icon: Icons.home,
      label: "Home",
      accessor: AccessedVia.drawer,
      accessLevel: AccessLevel.public), //first screen is default screen
  DASHBOARD('/dashboard',
      icon: Icons.home,
      label: "Home",
      accessor: AccessedVia.navigator,
      accessLevel: AccessLevel.public,
      parent: HOME),
  PRODUCTS('/products',
      icon: Icons.dataset,
      label: "Products",
      accessor: AccessedVia.navigator,
      accessLevel: AccessLevel.public,
      parent: HOME),
  PRODUCT_DETAILS('/:productId',
      accessLevel: AccessLevel.public, parent: PRODUCTS),
  LOGIN('/login',
      icon: Icons.login,
      accessor: AccessedVia.widget,
      accessLevel: AccessLevel.notAuthed),
  LOGOUT('/login',
      icon: Icons.logout,
      label: "Logout",
      accessor: AccessedVia.bottomSheet,
      accessLevel: AccessLevel.authenticated),
  PROFILE('/profile',
      icon: Icons.account_box_rounded,
      label: "Profile",
      accessor: AccessedVia.drawer,
      accessLevel: AccessLevel.authenticated),
  SETTINGS('/settings',
      icon: Icons.settings,
      label: "Settings",
      accessor: AccessedVia.drawer,
      accessLevel: AccessLevel.authenticated),
  CART('/cart',
      icon: Icons.trolley,
      label: "Cart",
      parent: HOME,
      accessor: AccessedVia.navigator,
      accessLevel: AccessLevel.guest),
  CART_DETAILS('/:productId', parent: CART, accessLevel: AccessLevel.guest),
  CHECKOUT('/checkout',
      icon: Icons.check_outlined,
      label: "Checkout",
      accessor: AccessedVia.fab, //fab appears in parent
      parent: CART,
      accessLevel: AccessLevel.authenticated),
  REGISTER('/register',
      accessor: AccessedVia.auto, accessLevel: AccessLevel.authenticated),
  CATEGORIES('/categories',
      icon: Icons.category,
      label: "Categories",
      parent: HOME,
      accessor: AccessedVia.navigator,
      accessLevel: AccessLevel.roleBased),
  TASKS('/tasks',
      icon: Icons.task,
      label: "Tasks",
      parent: HOME,
      accessor: AccessedVia.navigator,
      accessLevel: AccessLevel.roleBased),
  TASK_DETAILS('/:taskId', parent: TASKS, accessLevel: AccessLevel.roleBased),
  USERS('/users',
      icon: Icons.verified_user,
      label: "Users",
      parent: HOME,
      accessor: AccessedVia.navigator,
      accessLevel: AccessLevel.roleBased),
  USER_PROFILE('/:uId', parent: USERS, accessLevel: AccessLevel.roleBased),
  MY_PRODUCTS('/my-products',
      parent: HOME,
      icon: Icons.inventory,
      accessor: AccessedVia.navigator,
      label: "Inventory",
      accessLevel: AccessLevel.roleBased),
  MY_PRODUCT_DETAILS('/:productId',
      parent: MY_PRODUCTS, accessLevel: AccessLevel.roleBased),
  ;

  const Screen(this.path,
      {this.icon,
      this.label,
      this.parent,
      this.accessor = AccessedVia.singleTap,
      this.accessLevel = AccessLevel.authenticated});

  @override
  final IconData? icon;
  @override
  final String? label;

  final String path;
  final AccessedVia accessor;
  final Screen? parent;
  final AccessLevel
      accessLevel; //if false it is role based. true means allowed for all

  Iterable<Screen> get children =>
      Screen.values.where((Screen screen) => screen.parent == this);

  Iterable<Screen> get fabs => Screen.values.where((Screen screen) =>
      screen.parent == this && screen.accessor == AccessedVia.fab);

  Iterable<Screen> get navTabs => Screen.values.where((Screen screen) =>
      screen.parent == this && screen.accessor == AccessedVia.navigator);

  String get route => (parent != null ? parent?.route : '')! + path;

  static Iterable<Screen> sheet(Screen? parent) =>
      Screen.values.where((Screen screen) =>
          screen.parent == parent &&
          screen.accessor == AccessedVia.bottomSheet);

  static Iterable<Screen> drawer() => //drawer is not parent linked
      Screen.values
          .where((Screen screen) => screen.accessor == AccessedVia.drawer);

  @override
  Future<dynamic> doAction() async {
    if (this == LOGOUT) {
      AuthService.to.logout();
    }
    Get.rootDelegate.toNamed(route);
  }

  Widget? widget(GetNavConfig current) =>
      (this == LOGIN) ? LoginBottomSheetToggle(current) : null;
}
