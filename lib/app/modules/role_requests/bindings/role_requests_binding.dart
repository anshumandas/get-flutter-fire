import 'package:get/get.dart';
import '../controllers/role_requests_controllers.dart';

class RoleRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleRequestController>(
      () => RoleRequestController(),
    );
  }
}
