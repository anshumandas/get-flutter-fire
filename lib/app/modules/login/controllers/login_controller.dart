import 'package:get/get.dart';

import '../../../../services/auth_service.dart';

class LoginController extends GetxController {
  Rx<bool> robot = RxBool(true);

  bool get isLoggedIn => AuthService.to.isLoggedInValue;

  bool get isAnon => AuthService.to.isAnon;
}
