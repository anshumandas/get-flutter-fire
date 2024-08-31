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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                logo,
                height: 64,
                width: 64,
              ),
              const Spacing(size: AppTheme.spacingMedium),
              Text(
                'Enter OTP',
                style: AppTheme.fontStyleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacing(size: AppTheme.spacingSmall),
              RichText(
                textAlign: TextAlign.left,
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
                        color: AppTheme.colorRed,
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
                  selectedColor: AppTheme.colorRed,
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
                                    color: AppTheme.colorRed,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppTheme.colorRed),
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
