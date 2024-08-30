import 'package:get/get.dart';
import '../controllers/past_rides_controller.dart';

class PastRidesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PastRidesController>(
          () => PastRidesController(),
    );
  }
}