import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_button.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_phone_textfield.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/theme/assets.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
    final LoginController loginController = Get.put(LoginController());

    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      body: Padding(
        padding: AppTheme.paddingDefault,
        child: Stack(
          children: [
            Obx(() => AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  top: loginController.isInitialPosition.value
                      ? -MediaQuery.of(context).size.height * 0.628
                      : MediaQuery.of(context).size.height * 0.05,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          logo,
                          height: 100,
                          width: 100,
                          color: AppTheme.colorMain,
                        ),
                      ),
                      const Spacing(size: AppTheme.spacingLarge),
                      Center(
                        child: Text('Enter Number',
                            style: AppTheme.fontStyleLarge.copyWith(
                              color: AppTheme.colorBlack,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 10),
                      Obx(() => Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'An OTP will be sent to this number: ',
                                style: AppTheme.fontStyleSmall.copyWith(
                                  color: AppTheme.greyTextColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: loginController.phoneNumber.value,
                                    style: AppTheme.fontStyleSmall.copyWith(
                                      color: AppTheme.colorMain,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      const SizedBox(height: 10),
                      Container(
                        decoration: AppTheme.cardDecoration,
                        child: PhoneTextField(
                          hintText: 'Phone Number',
                          readOnly: false,
                          controller: loginController.phoneController,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(() => CustomButton(
                          onPressed: () {
                            loginController.verifyPhoneNumber(authService);
                            if (kDebugMode) {
                              print(
                                  "The phone number is ${loginController.phoneController.text}");
                            }
                          },
                          text: 'Get OTP',
                          isDisabled: loginController.isDisabled.value)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
