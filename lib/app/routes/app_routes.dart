// lib/app/routes/app_routes.dart
import 'package:get/get.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/signup_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/bindings/home_binding.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';

  static final routes = [
    GetPage(
      name: login,
      page: () => LoginView(),
    ),
    GetPage(
      name: signup,
      page: () => SignUpView(),
    ),
    GetPage(
      name: home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
