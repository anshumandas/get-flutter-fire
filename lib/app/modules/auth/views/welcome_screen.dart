import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_button.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/models/user_model.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/theme/assets.dart';
import 'package:get_flutter_fire/enums/enums.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final isInitialPosition = true.obs;
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 400), () {
      isInitialPosition.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.find<AuthService>();

    return Scaffold(
      body: Stack(
        children: [
          Obx(() => AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                top: isInitialPosition.value
                    ? MediaQuery.of(context).size.height * 0.4
                    : MediaQuery.of(context).size.height * 0.2,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    logo,
                    height: 144,
                    width: 144,
                  ),
                ),
              )),
          Obx(() => AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                top: isInitialPosition.value
                    ? MediaQuery.of(context).size.height
                    : MediaQuery.of(context).size.height * 0.74,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacing(size: AppTheme.spacingLarge),
                      const Spacing(size: AppTheme.spacingLarge),
                      CustomButton(
                        onPressed: () {
                          Get.toNamed(Routes.LOGIN);
                        },
                        text: 'Get Started',
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'New to the app and in doubt? ',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                            children: [
                              TextSpan(
                                text: 'Explore Now',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Set user as guest and navigate to RootView
                                    authController.user = UserModel(
                                      id: 'guest',
                                      name: 'Guest User',
                                      phoneNumber: '',
                                      email: null,
                                      isBusiness: false,
                                      businessName: null,
                                      businessType: null,
                                      gstNumber: null,
                                      panNumber: null,
                                      userType: UserType.guest,
                                      defaultAddressID: '',
                                      createdAt: DateTime.now(),
                                      lastSeenAt: DateTime.now(),
                                      fcmTokens: [],
                                    );
                                    Get.offAllNamed(Routes.ROOT);
                                  },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
