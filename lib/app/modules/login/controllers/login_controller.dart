import 'package:get/get.dart';

import '../../../../services/auth_service.dart';

class LoginController extends GetxController {
  bool get isRobot => AuthService.to.robot.value == true;
  set robot(bool v) => AuthService.to.robot.value = v;

  bool get isLoggedIn => AuthService.to.isLoggedInValue;

  bool get isAnon => AuthService.to.isAnon;
}
