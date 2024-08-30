import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../settings/controllers/settings_controller.dart';
import '../../add_ride/controllers/add_ride_controller.dart';
import '../../ride_search/controllers/ride_search_controller.dart';
import '../../past_rides/controllers/past_rides_controller.dart';
import '../../active_ride/controllers/active_ride_controller.dart'; // Import ActiveRideController

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<AddRidesController>(() => AddRidesController());
    Get.lazyPut<RideSearchController>(() => RideSearchController());
    Get.lazyPut<PastRidesController>(() => PastRidesController());
    Get.lazyPut<ActiveRideController>(() => ActiveRideController()); // Bind ActiveRideController
  }
}
