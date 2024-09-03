part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static String PRODUCT_DETAILS(String productId) =>
      '${Screen.PRODUCTS.route}/$productId';
  static String CART_DETAILS(String productId) =>
      '${Screen.CART.route}/$productId';
  static String TASK_DETAILS(String taskId) => '${Screen.TASKS.route}/$taskId';
  static String USER_PROFILE(String uId) => '${Screen.USERS.route}/$uId';

  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '${Screen.LOGIN.route}?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';
  static String REGISTER_THEN(String afterSuccessfulLogin) =>
      '${Screen.REGISTER.route}?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';

  // Add these static getters for direct route access
  static const WELCOME = _Paths.WELCOME;
  static const HOME = _Paths.HOME;
  static String get LOGIN => Screen.LOGIN.route;
  static String get REGISTER => Screen.REGISTER.route;
  static String get PROFILE => Screen.PROFILE.route;
  static String get SETTINGS => Screen.SETTINGS.route;
  static String get PRODUCTS => Screen.PRODUCTS.route;
  static String get CART => Screen.CART.route;
  static String get CHECKOUT => Screen.CHECKOUT.route;
  static String get DASHBOARD => Screen.DASHBOARD.route;
  static String get USERS => Screen.USERS.route;
  static String get CATEGORIES => Screen.CATEGORIES.route;
  static String get MY_PRODUCTS => Screen.MY_PRODUCTS.route;
  static String get TASKS => Screen.TASKS.route;
}

// Keeping this as Get_Cli will require it. Any addition can later be added to Screen
abstract class _Paths {
  static const WELCOME = '/welcome';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  // ... (keep the commented out paths as they are)
}
