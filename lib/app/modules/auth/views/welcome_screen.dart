import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_button.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/theme/assets.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final isInitialPosition = true.obs;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 400), () {
      isInitialPosition.value = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
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
                    height: 94,
                    width: 94,
                    color: AppTheme.colorMain,
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
                                  color: AppTheme.colorMain,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
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
