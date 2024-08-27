// lib/app/routes/app_routes.dart
import 'package:get/get.dart';
import '../../Main_View.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/signup_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/search/views/search_view.dart'; // Import SearchView
import '../modules/ranking/views/ranking_view.dart'; // Import RankingView
import '../modules/profile/views/profile_view.dart'; // Import ProfileView

class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String search = '/search'; // Add route for SearchView
  static const String ranking = '/ranking'; // Add route for RankingView
  static const String profile = '/profile'; // Add route for ProfileView
  static const String main = '/main'; // Add route for MainView

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
    GetPage(
      name: search,
      page: () => SearchView(), // Add SearchView
    ),
    GetPage(
      name: ranking,
      page: () => RankingView(), // Add RankingView
    ),
    GetPage(
      name: profile,
      page: () => ProfileView(), // Add ProfileView
    ),
    GetPage(
      name: main,
      page: () => MainView(), // Add MainView as the main navigation view
    ),
  ];
}
