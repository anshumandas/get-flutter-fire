import 'package:get/get.dart';
import '../controllers/add_ride_controller.dart';

class AddRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRidesController>(
          () => AddRidesController(),
    );
  }
}