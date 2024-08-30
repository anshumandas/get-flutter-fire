import 'package:get/get.dart';
import '../../../../services/auth_service.dart';

class SettingsController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  void signOut() async {
    await _authService.signOut();
    Get.offAllNamed('/login');
  }
}