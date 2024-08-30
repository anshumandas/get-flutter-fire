import 'package:get/get.dart';
import '../controllers/ride_search_controller.dart';

class RideSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideSearchController>(
          () => RideSearchController(),
    );
  }
}