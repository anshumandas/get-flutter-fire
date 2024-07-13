import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/remote_config.dart';
import 'action_enum.dart';
import 'access_level.dart';
import '../../services/auth_service.dart';

enum AccessedVia {
  auto,
  widget,
  topRight,
  topCenter,
  topLeft,
  topBar, //bar below the main top menu bar
  navigator, //bottom nav. can be linked to drawer items. left strip in expanded web //handled in ScreenWidget
  drawer, //creates nav tree. persistant in expanded web and linked with nav icons //handled in RootView
  bottomSheet, //context menu for web handled via the Button that calls the sheet
  fab, //handled in ScreenWidget
  singleTap, //when an item of a list is clicked
  longTap //or double click
}

enum Screen implements ActionEnum {
  NONE.none(), //null
  HOME('/home',
      icon: Icons.home,
      label: "Home",
      accessor_: AccessedVia.drawer,
      accessLevel: AccessLevel.public), //first screen is default screen
  DASHBOARD('/dashboard',
      icon: Icons.home,
      label: "Home",
      accessor_: AccessedVia.navigator,
      accessLevel: AccessLevel.public,
      parent: HOME),
  PRODUCTS('/products',
      icon: Icons.dataset,
      label: "Products",
      accessor_: AccessedVia.navigator,
      accessLevel: AccessLevel.public,
      parent: HOME),
  PRODUCT_DETAILS('/:productId',
      accessLevel: AccessLevel.public, parent: PRODUCTS),
  PROFILE('/profile',
      icon: Icons.account_box_rounded,
      label: "Profile",
      accessor_: AccessedVia.drawer,
      accessLevel: AccessLevel.authenticated,
      remoteConfig: "useBottomSheetForProfileOptions"),
  SETTINGS('/settings',
      icon: Icons.settings,
      label: "Settings",
      accessor_: AccessedVia.drawer,
      accessLevel: AccessLevel.authenticated,
      remoteConfig: "useBottomSheetForProfileOptions"),
  CART('/cart',
      icon: Icons.trolley,
      label: "Cart",
      parent: HOME,
      accessor_: AccessedVia.navigator,
      accessLevel: AccessLevel.guest),
  CART_DETAILS('/:productId', parent: CART, accessLevel: AccessLevel.guest),
  CHECKOUT('/checkout',
      icon: Icons.check_outlined,
      label: "Checkout",
      accessor_: AccessedVia.fab, //fab appears in parent
      parent: CART,
      accessLevel: AccessLevel.authenticated),
  REGISTER('/register',
      accessor_: AccessedVia.auto, accessLevel: AccessLevel.authenticated),
  CATEGORIES('/categories',
      icon: Icons.category,
      label: "Categories",
      parent: HOME,
      accessor_: AccessedVia.navigator,
      accessLevel: AccessLevel.roleBased),
  TASKS('/tasks',
      icon: Icons.task,
      label: "Tasks",
      parent: HOME,
      accessor_: AccessedVia.navigator,
      accessLevel: AccessLevel.roleBased),
  TASK_DETAILS('/:taskId', parent: TASKS, accessLevel: AccessLevel.roleBased),
  USERS('/users',
      icon: Icons.verified_user,
      label: "Users",
      parent: HOME,
      accessor_: AccessedVia.navigator,
      accessLevel: AccessLevel.roleBased),
  USER_PROFILE('/:uId', parent: USERS, accessLevel: AccessLevel.roleBased),
  MY_PRODUCTS('/my-products',
      parent: HOME,
      icon: Icons.inventory,
      accessor_: AccessedVia.navigator,
      label: "Inventory",
      accessLevel: AccessLevel.roleBased),
  MY_PRODUCT_DETAILS('/:productId',
      parent: MY_PRODUCTS, accessLevel: AccessLevel.roleBased),
  SEARCH('/search',
      icon: Icons.search,
      label: "Search",
      accessor_: AccessedVia.topRight,
      remoteConfig: "showSearchBarOnTop",
      accessLevel: AccessLevel.public),
  LOGOUT('/login',
      icon: Icons.logout,
      label: "Logout",
      accessor_: AccessedVia.topRight,
      remoteConfig: "useBottomSheetForProfileOptions",
      accessLevel: AccessLevel.authenticated),
  LOGIN('/login',
      icon: Icons.login,
      accessor_: AccessedVia.topRight,
      accessLevel: AccessLevel.notAuthed),
  ;

  const Screen(this.path,
      {this.icon,
      this.label,
      this.parent = Screen.NONE,
      this.accessor_ = AccessedVia.singleTap,
      this.accessLevel = AccessLevel.authenticated,
      this.remoteConfig});

  const Screen.none()
      : path = '',
        icon = null,
        label = null,
        parent = null,
        accessor_ = AccessedVia.singleTap,
        accessLevel = AccessLevel.authenticated,
        remoteConfig = null;

  @override
  final IconData? icon;
  @override
  final String? label;

  final String path;
  final AccessedVia accessor_;
  final Screen? parent;
  final AccessLevel
      accessLevel; //if false it is role based. true means allowed for all
  final String? remoteConfig;

  Future<AccessedVia> get accessor async {
    if (remoteConfig == "useBottomSheetForProfileOptions" &&
        (await RemoteConfig.instance).useBottomSheetForProfileOptions()) {
      return AccessedVia.bottomSheet;
    }
    return accessor_;
  }

  Iterable<Screen> get children =>
      Screen.values.where((Screen screen) => screen.parent == this);

  Iterable<Screen> get fabs => Screen.values.where((Screen screen) =>
      screen.parent == this && screen.accessor_ == AccessedVia.fab);

  Iterable<Screen> get navTabs => Screen.values.where((Screen screen) =>
      screen.parent == this && screen.accessor_ == AccessedVia.navigator);

  String get route => (parent != null ? parent?.route : '')! + path;

  static Future<Iterable<Screen>> sheet(Screen? parent) async {
    List<Screen> list = [];
    await Future.forEach(Screen.values, (Screen screen) async {
      if (screen.parent == parent &&
          (await screen.accessor) == AccessedVia.bottomSheet) {
        list.add(screen);
      }
    });
    return list;
  }

  static Future<Iterable<Screen>> drawer() async {
    //drawer is not parent linked
    List<Screen> list = [];
    await Future.forEach(Screen.values, (Screen screen) async {
      if ((await screen.accessor) == AccessedVia.drawer) {
        list.add(screen);
      }
    });
    return list;
  }

  static Future<Iterable<Screen>> topRightMenu() async {
    return Screen.values.where((Screen screen) =>
        screen.accessor_ == AccessedVia.topRight &&
        AuthService.to.accessLevel.index >= screen.accessLevel.index);
  }

  @override
  Future<dynamic> doAction() async {
    if (this == LOGOUT) {
      AuthService.to.logout();
    }
    Get.rootDelegate.toNamed(route);
  }
}
