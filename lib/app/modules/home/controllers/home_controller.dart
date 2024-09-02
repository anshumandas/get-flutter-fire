import 'package:get/get.dart';

import '../../../../models/role.dart';
import '../../../../services/auth_service.dart';

class HomeController extends GetxController {
  final Rx<Role> chosenRole = Rx<Role>(AuthService.to.maxRole);

  // Role get role => AuthService.to.maxRole;

  get isBuyer => chosenRole.value == Role.buyer;

  get isAdmin => chosenRole.value == Role.admin;
}
