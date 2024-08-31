import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_button.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/otp_controller.dart';
import 'package:get_flutter_fire/theme/assets.dart';

class OtpScreen extends StatelessWidget {
  final String phoneNumber;
  OtpScreen({super.key, required this.phoneNumber});

  final OtpController otpController = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppTheme.paddingDefault,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  logo,
                  height: 100,
                  width: 100,
                  color: AppTheme.colorMain,
                ),
              ),
              const Spacing(size: AppTheme.spacingMedium),
              Center(
                child: Text(
                  'Enter OTP',
                  style: AppTheme.fontStyleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacing(size: AppTheme.spacingSmall),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text:
                          'An OTP has been sent to your registered mobile number ',
                      style: AppTheme.fontStyleDefault,
                    ),
                    TextSpan(
                      text: phoneNumber,
                      style: AppTheme.fontStyleDefaultBold.copyWith(
                        color: AppTheme.colorMain,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacing(size: AppTheme.spacingDefault),
              PinCodeTextField(
                length: 6,
                appContext: context,
                keyboardType: TextInputType.number,
                textStyle: AppTheme.fontStyleDefault,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveColor: AppTheme.greyTextColor,
                  activeColor: AppTheme.greyTextColor,
                  selectedColor: AppTheme.colorMain,
                ),
                onChanged: (value) {
                  otpController.otp.value = value;
                  otpController.checkOtpFields();
                },
              ),
              const Spacing(size: AppTheme.spacingTiny),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      otpController.isResendButtonEnabled.value
                          ? InkWell(
                              onTap: otpController.resendCode,
                              child: Text(
                                'Resend OTP',
                                style: AppTheme.fontStyleDefaultBold.copyWith(
                                    color: AppTheme.colorMain,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppTheme.colorMain),
                              ),
                            )
                          : Row(
                              children: [
                                Text(
                                  'Resend OTP ',
                                  style: AppTheme.fontStyleDefaultBold.copyWith(
                                    color: AppTheme.greyTextColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Obx(() => Text(
                                      'in ${otpController.timerSeconds.value}s',
                                      style: AppTheme.fontStyleDefault.copyWith(
                                        color: AppTheme.greyTextColor,
                                      ),
                                    )),
                              ],
                            ),
                    ],
                  )),
              const Spacing(size: AppTheme.spacingLarge),
              Obx(() => CustomButton(
                    isDisabled: otpController.isDisabled.value,
                    onPressed: otpController.submitOtp,
                    text: 'Submit',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
