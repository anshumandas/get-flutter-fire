import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/widgets/common/show_toast.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/services/notification_service.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/theme/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();
    _authController = Get.put(AuthController());

    Future.delayed(const Duration(seconds: 2), () async {
      if (_authController.user != null) {
        showToast("Welcome", isShort: true);

        await _storeUserToken(_authController.user!.id);

        Get.offNamed(Routes.ROOT);
      } else {
        showToast("Welcome", isShort: true);
        Get.offNamed(Routes.WELCOME);
      }
    });
  }

  // Function to store user token
  Future<void> _storeUserToken(String userID) async {
    try {
      NotificationService notificationService = NotificationService();
      await notificationService.storeToken(userID);
    } catch (e) {
      // Handle any errors while storing the token
      print("Error storing token: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              const Spacing(size: AppTheme.spacingDefault),
              Image.asset(
                logo,
                height: 144,
                width: 144,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
