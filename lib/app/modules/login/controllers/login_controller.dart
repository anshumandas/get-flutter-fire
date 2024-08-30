import 'package:get/get.dart';
import '../../../../services/auth_service.dart';

class LoginController extends GetxController {
  static AuthService get to => Get.find();

  final Rx<bool> showReverificationButton = Rx(false);
  final Rx<bool> isRecaptchaVerified = Rx(false);

  bool get isRobot => AuthService.to.robot.value == true;

  set robot(bool v) => AuthService.to.robot.value = v;

  bool get isLoggedIn => AuthService.to.isLoggedInValue;

  bool get isAnon => AuthService.to.isAnon;

  bool get isRegistered =>
      AuthService.to.registered.value || AuthService.to.isEmailVerified;

  Future<bool> verifyRecaptcha(String token) async {
    if (token.isNotEmpty) {
      isRecaptchaVerified.value = true;
      return true;
    }
    return false;
  }
}
