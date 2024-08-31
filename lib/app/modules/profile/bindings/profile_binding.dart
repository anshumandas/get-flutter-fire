import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/profile/controllers/profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());

  }
}
