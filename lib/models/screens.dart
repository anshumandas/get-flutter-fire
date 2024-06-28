import 'package:flutter/material.dart';
import 'package:get_flutter_fire/app/widgets/login_widgets.dart';

import 'role.dart';

enum AccessedVia {
  auto,
  widget, //example: top right button
  navigator, //bottom nav. can be linked to drawer items
  drawer, //creates nav tree
  bottomSheet, //context menu for web
  fab,
  singleTap, //when an item of a list is clicked
  longTap //or double click
}

enum Screen {
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
  LOGIN('/login',
      widget: LoginLogoutToggle(),
      accessor: AccessedVia.widget,
      accessLevel: AccessLevel.notAuthed),
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
      accessor: AccessedVia.fab,
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
      this.accessLevel = AccessLevel.authenticated,
      this.widget});
  final String path;
  final IconData? icon;
  final String? label;
  final AccessedVia accessor;
  final Screen? parent;
  final Widget? widget;
  final AccessLevel
      accessLevel; //if false it is role based. true means allowed for all

  Iterable<Screen> get children =>
      Screen.values.where((Screen screen) => screen.parent == this);

  static Iterable<Screen> drawer({Screen? parent}) =>
      Screen.values.where((Screen screen) =>
          screen.parent == parent && screen.accessor == AccessedVia.drawer);

  String get route => (parent != null ? parent?.route : '')! + path;
}
