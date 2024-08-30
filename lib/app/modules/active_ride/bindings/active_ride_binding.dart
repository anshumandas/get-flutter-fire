import 'package:get/get.dart';
import '../controllers/active_ride_controller.dart';

class ActiveRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActiveRideController>(
          () => ActiveRideController(),
    );
  }
}