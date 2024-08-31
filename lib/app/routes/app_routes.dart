// ignore_for_file: non_constant_identifier_names, constant_identifier_names

part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  static const HOME = _Paths.HOME;
  static const PROFILE = _Paths.PROFILE;
  static const ACTIVITY = _Paths.ACTIVITY;
  static const SETTINGS = _Paths.SETTINGS;
  static const HEALTH_TIPS = _Paths.HEALTH_TIPS;
  static const CHAT = _Paths.CHAT;
  static const BOOKING = _Paths.BOOKING;

  // Uncomment and modify these as needed for your app
  // static String DASHBOARD = Screen.DASHBOARD.fullPath;
  // static String PRODUCTS = Screen.PRODUCTS.fullPath;
  // static String CART = Screen.CART.fullPath;
  // static String CHECKOUT = Screen.CHECKOUT.fullPath;
  // static String CATEGORIES = _Paths.HOME + _Paths.CATEGORIES;
  // static String TASKS = _Paths.HOME + _Paths.TASKS;
  // static String USERS = _Paths.HOME + _Paths.USERS;
  // static String MY_PRODUCTS = _Paths.HOME + _Paths.MY_PRODUCTS;

  static String PRODUCT_DETAILS(String productId) =>
      '${Screen.PRODUCTS.route}/$productId';
  static String CART_DETAILS(String productId) =>
      '${Screen.CART.route}/$productId';
  static String TASK_DETAILS(String taskId) => '${Screen.TASKS.route}/$taskId';
  static String USER_PROFILE(String uId) => '${Screen.USERS.route}/$uId';

  Routes._();
  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '${Screen.LOGIN.route}?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';
  static String REGISTER_THEN(String afterSuccessfulLogin) =>
      '${Screen.REGISTER.route}?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';
}

abstract class _Paths {
  static const String HOME = '/home';
  static const String PROFILE = '/profile';
  static const String ACTIVITY = '/activity';
  static const String SETTINGS = '/settings';
  static const String HEALTH_TIPS = '/health_tips';
  static const String CHAT = '/chat';
  static const String BOOKING = '/booking';

  // Uncomment and modify these as needed for your app
  // static const String DASHBOARD = '/dashboard';
  // static const String PRODUCTS = '/products';
  // static const String CART = '/cart';
  // static const String CHECKOUT = '/checkout';
  // static const String REGISTER = '/register';
  // static const String CATEGORIES = '/categories';
  // static const String TASKS = '/tasks';
  // static const String TASK_DETAILS = '/:taskId';
  // static const String USERS = '/users';
  // static const String USER_PROFILE = '/:uId';
  // static const String MY_PRODUCTS = '/my-products';
}
