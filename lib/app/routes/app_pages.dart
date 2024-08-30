import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/ride_search/bindings/ride_search_binding.dart';
import '../modules/ride_search/views/ride_search_view.dart';
import '../modules/active_ride/bindings/active_ride_binding.dart';
import '../modules/active_ride/views/active_ride_view.dart';
import '../modules/past_rides/bindings/past_rides_binding.dart';
import '../modules/past_rides/views/past_rides_view.dart';
import '../modules/settings/bindings/settings_bindings.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/add_ride/bindings/add_ride_binding.dart';
import '../modules/add_ride/views/add_ride_view.dart';
import '../modules/driver_dashboard/bindings/driver_dashboard_binding.dart';
import '../modules/driver_dashboard/views/driver_dashboard_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.RIDE_SEARCH,
      page: () => RideSearchView(),
      binding: RideSearchBinding(),
    ),
    GetPage(
      name: Routes.ACTIVE_RIDE,
      page: () => ActiveRideView(),
      binding: ActiveRideBinding(),
    ),
    GetPage(
      name: Routes.PAST_RIDES,
      page: () => PastRidesView(),
      binding: PastRidesBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.ADD_RIDE,
      page: () => AddRidesView(),
      binding: AddRideBinding(),
    ),
    GetPage(
      name: Routes.DRIVER_DASHBOARD,
      page: () => DriverDashboardView(),
      binding: DriverDashboardBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}