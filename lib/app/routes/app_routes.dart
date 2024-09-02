// ignore_for_file: non_constant_identifier_names, constant_identifier_names

part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  static const HOME = _Paths.HOME;
  static String PROFILE = Screen.PROFILE.route;
  static String SETTINGS = Screen.SETTINGS.route;
  static String LOGIN = Screen.LOGIN.route;
  static String REGISTER = Screen.REGISTER.route;
  static String DASHBOARD = Screen.DASHBOARD.route;
  static String PRODUCTS = Screen.PRODUCTS.route;
  static String CART = Screen.CART.route;
  static String CHECKOUT = Screen.CHECKOUT.route;
  static const CATEGORIES = _Paths.HOME + _Paths.CATEGORIES;
  static const TASKS = _Paths.HOME + _Paths.TASKS;
  static const USERS = _Paths.HOME + _Paths.USERS;
  static const MY_PRODUCTS = _Paths.HOME + _Paths.MY_PRODUCTS;

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

// Keeping this as Get_Cli will require it. Any addition can later be added to Screen
abstract class _Paths {
  static const String HOME = '/home';
  static const DASHBOARD = '/dashboard';
  static const PRODUCTS = '/products';
  static const PROFILE = '/profile';
  static const SETTINGS = '/settings';
  static const PRODUCT_DETAILS = '/:productId';
  static const CART_DETAILS = '/:productId';
  static const LOGIN = '/login';
  static const CART = '/cart';
  static const CHECKOUT = '/checkout';
  static const REGISTER = '/register';
  static const CATEGORIES = '/categories';
  static const TASKS = '/tasks';
  static const TASK_DETAILS = '/:taskId';
  static const USERS = '/users';
  static const USER_PROFILE = '/:uId';
  static const MY_PRODUCTS = '/my-products';
}
