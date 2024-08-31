import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/regster_controller.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_phone_textfield.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_textfield.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_button.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/theme/assets.dart';

class RegisterScreen extends StatelessWidget {
  final String phoneNumber;

  RegisterScreen({super.key, required this.phoneNumber});

  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: AppTheme.paddingDefault,
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: AppTheme.rrShape,
              elevation: 10,
              shadowColor: AppTheme.colorBlack.withOpacity(0.15),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingLarge),
                child: Column(
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
                    const Spacing(size: AppTheme.spacingLarge),
                    Center(
                      child: Text(
                        'Register',
                        style: AppTheme.fontStyleLarge.copyWith(
                          color: AppTheme.colorBlack,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacing(size: AppTheme.spacingMedium),
                    CustomTextField(
                      labelText: 'Full Name',
                      controller: controller.nameController,
                    ),
                    const Spacing(size: AppTheme.spacingSmall),
                    CustomTextField(
                      labelText: 'Email (optional)',
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
                    ),
                    const Spacing(size: AppTheme.spacingSmall),
                    PhoneTextField(
                      hintText: 'Enter your 10-digit mobile number',
                      readOnly: true,
                      controller: TextEditingController(text: phoneNumber),
                    ),
                    const Spacing(size: AppTheme.spacingMedium),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Here for Selling?',
                            style: AppTheme.fontStyleMedium),
                        Obx(() => Switch(
                              activeColor: Colors.white,
                              inactiveTrackColor: Colors.white,
                              inactiveThumbColor: Colors.black,
                              activeTrackColor: AppTheme.colorMain,
                              trackOutlineColor: null,
                              value: controller.isBusiness.value,
                              onChanged: controller.toggleBusiness,
                            )),
                      ],
                    ),
                    Obx(() => Visibility(
                          visible: controller.isBusiness.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Business Details',
                                style: AppTheme.fontStyleDefaultBold.copyWith(
                                  fontSize: 16,
                                  color: AppTheme.colorBlack,
                                ),
                              ),
                              const Spacing(size: AppTheme.spacingSmall),
                              CustomTextField(
                                labelText: 'Business Name',
                                controller: controller.businessNameController,
                              ),
                              const Spacing(size: AppTheme.spacingSmall),
                              CustomTextField(
                                labelText: 'Business Type',
                                controller: controller.businessTypeController,
                              ),
                              const Spacing(size: AppTheme.spacingSmall),
                              CustomTextField(
                                labelText: 'GST Number',
                                controller: controller.gstNumberController,
                              ),
                              const Spacing(size: AppTheme.spacingSmall),
                              CustomTextField(
                                labelText: 'PAN Number',
                                controller: controller.panNumberController,
                              ),
                            ],
                          ),
                        )),
                    const Spacing(size: AppTheme.spacingLarge),
                    CustomButton(
                      onPressed: () {
                        controller.registerUser(phoneNumber);
                      },
                      text: 'Register',
                      isDisabled: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
