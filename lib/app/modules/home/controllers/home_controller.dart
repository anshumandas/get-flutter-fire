import 'package:get/get.dart';
import '../../../../models/role.dart';
import '../../../../services/auth_service.dart';

class HomeController extends GetxController {
  //observable role that tracks the current role of the user
  final Rx<Role> chosenRole = Rx<Role>(AuthService.to.maxRole);
  // Observable to track the selected index of the bottom navigation bar
  final RxInt selectedIndex = 0.obs;


  // Role get role => AuthService.to.maxRole;

  bool get isGuest => chosenRole.value == Role.guest;
  bool get isRegisteredUser => chosenRole.value == Role.registeredUser;
  bool get isAdmin => chosenRole.value == Role.admin;

  //Method to update the role (when the user logs in)
  void setRole(Role role){
    chosenRole.value = role;
  }
  @override
  void onInit() {
    super.onInit();
    // Example: Initialize with a role from the AuthService or other logic
    chosenRole.value = AuthService.to.maxRole;
  }
}
