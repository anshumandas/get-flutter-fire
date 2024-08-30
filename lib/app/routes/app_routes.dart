part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  static const HOME = _Paths.HOME;
  static const LOGIN = Screen.LOGIN.route;
  static const REGISTER = Screen.REGISTER.route;

  // Example of a secure route requiring authentication
  static String adminDashboard(String adminId) =>
      AuthGuard.isAuthenticated && AuthGuard.userRole == 'admin'
          ? '${Screen.ADMIN_DASHBOARD.route}/$adminId'
          : LOGIN_THEN('${Screen.ADMIN_DASHBOARD.route}/$adminId');

  static String productDetails(String productId) =>
      '${Screen.PRODUCTS.route}/$productId';
  static String cartDetails(String productId) =>
      '${Screen.CART.route}/$productId';
  static String taskDetails(String taskId) =>
      '${Screen.TASKS.route}/$taskId';
  static String userProfile(String uId) =>
      '${Screen.USERS.route}/$uId';

  Routes._();

  static String loginThen(String afterSuccessfulLogin) =>
      '${Screen.LOGIN.route}?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';
  static String registerThen(String afterSuccessfulLogin) =>
      '${Screen.REGISTER.route}?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';

  // Example of a secure route requiring authentication
  static String secureRoute(String route, {String role = 'user'}) {
    if (AuthGuard.isAuthenticated && AuthGuard.hasRole(role)) {
      return route;
    }
    return LOGIN_THEN(route);
  }
}

// Retain this as Get_Cli might require it for route management
abstract class _Paths {
  static const HOME = '/home';
  static const ADMIN_DASHBOARD = '/admin-dashboard';
}

class AuthGuard {
  static bool isAuthenticated = false; // This should be dynamically set based on user auth state
  static String userRole = 'guest'; // This should be set based on logged-in user's role

  static bool hasRole(String role) {
    // Implement your role-checking logic here
    return role == userRole;
  }
}

// This class can be expanded to include JWT validation, token expiration checks, etc.
class AuthService {
  static bool validateToken(String token) {
    // Add JWT or any other token validation logic here
    return true; // Dummy implementation
  }

  static void logRouteAccess(String route) {
    // Implement logging of route access for monitoring and security purposes
    print('Route accessed: $route');
  }
}
