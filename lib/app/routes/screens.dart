import 'package:flutter/material.dart';

import '../../models/role.dart';

enum AccessedBy {
  auto,
  navigator,
  drawer,
  bottomSheet, //top right button with menu in web
  fab,
  singleTap, //when an item of a list is clicked
  longTap //or double click
}

enum Screen {
  HOME('/home',
      icon: Icons.home,
      label: "Home",
      accessor: AccessedBy.drawer,
      accessLevel: AccessLevel.public), //first screen is defalu screen
  DASHBOARD('/dashboard',
      icon: Icons.home,
      label: "Home",
      accessor: AccessedBy.navigator,
      accessLevel: AccessLevel.public,
      parent: HOME),
  PRODUCTS('/products',
      icon: Icons.trolley,
      label: "Products",
      accessor: AccessedBy.navigator,
      accessLevel: AccessLevel.public,
      parent: HOME),
  PRODUCT_DETAILS('/:productId',
      accessLevel: AccessLevel.public, parent: PRODUCTS),
  PROFILE('/profile',
      icon: Icons.account_box_rounded,
      label: "Profile",
      accessor: AccessedBy.drawer,
      accessLevel: AccessLevel.authenticated),
  SETTINGS('/settings',
      icon: Icons.settings,
      label: "Settings",
      accessor: AccessedBy.drawer,
      accessLevel: AccessLevel.authenticated),
  LOGIN('/login',
      icon: Icons.login,
      toggleIcon: Icons.logout,
      label: "Login",
      toggleLabel: "Logout",
      accessor: AccessedBy.bottomSheet,
      accessLevel: AccessLevel.public),
  CART('/cart',
      icon: Icons.trolley,
      label: "Cart",
      parent: HOME,
      accessor: AccessedBy.navigator,
      accessLevel: AccessLevel.guest),
  CART_DETAILS('/:productId', parent: CART, accessLevel: AccessLevel.guest),
  CHECKOUT('/checkout',
      icon: Icons.check_outlined,
      label: "Checkout",
      accessor: AccessedBy.fab,
      parent: CART,
      accessLevel: AccessLevel.authenticated),
  REGISTER('/register',
      accessor: AccessedBy.auto, accessLevel: AccessLevel.authenticated),
  CATEGORIES('/categories',
      icon: Icons.category,
      label: "Categories",
      parent: HOME,
      accessor: AccessedBy.navigator,
      accessLevel: AccessLevel.roleBased),
  TASKS('/tasks',
      icon: Icons.task,
      label: "Tasks",
      parent: HOME,
      accessor: AccessedBy.navigator,
      accessLevel: AccessLevel.roleBased),
  TASK_DETAILS('/:taskId', parent: TASKS, accessLevel: AccessLevel.roleBased),
  USERS('/users',
      icon: Icons.verified_user,
      label: "Users",
      parent: HOME,
      accessor: AccessedBy.navigator,
      accessLevel: AccessLevel.roleBased),
  USER_PROFILE('/:uId', parent: USERS, accessLevel: AccessLevel.roleBased),
  MY_PRODUCTS('/my-products',
      parent: HOME,
      icon: Icons.trolley,
      accessor: AccessedBy.navigator,
      label: "Inventory",
      accessLevel: AccessLevel.roleBased),
  MY_PRODUCT_DETAILS('/:productId',
      parent: MY_PRODUCTS, accessLevel: AccessLevel.roleBased),
  ;

  const Screen(
    this.path, {
    this.icon,
    this.label,
    this.parent,
    this.accessor = AccessedBy.singleTap,
    this.accessLevel = AccessLevel.authenticated,
    this.toggleIcon,
    this.toggleLabel,
  });
  final String path;
  final IconData? icon;
  final IconData? toggleIcon;
  final String? label;
  final String? toggleLabel;
  final AccessedBy accessor;
  final Screen? parent;
  final AccessLevel
      accessLevel; //if false it is role based. true means allowed for all
  Iterable<Screen> get children =>
      Screen.values.where((Screen screen) => screen.parent == this);

  String get route => (parent != null ? parent?.route : '')! + path;
}
