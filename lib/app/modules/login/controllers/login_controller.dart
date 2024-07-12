import 'package:get/get.dart';

import '../../../../services/auth_service.dart';

class LoginController extends GetxController {
  static AuthService get to => Get.find();

  final Rx<bool> showReverificationButton = Rx(false);

  bool get isRobot => AuthService.to.robot.value == false;

  set robot(bool v) => AuthService.to.robot.value = v;

  bool get isLoggedIn => AuthService.to.isLoggedInValue;

  bool get isAnon => AuthService.to.isAnon;

  bool get isRegistered =>
      AuthService.to.registered.value || AuthService.to.isEmailVerified;
}
