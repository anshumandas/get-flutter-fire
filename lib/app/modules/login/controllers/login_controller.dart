import 'package:get/get.dart';

import '../../../../services/auth_service.dart';

class LoginController extends GetxController {
  bool get isLoggedIn => AuthService.to.isLoggedInValue;
}
