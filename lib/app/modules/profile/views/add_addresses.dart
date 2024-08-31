import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/profile/controllers/address_controller.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_textfield.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_button.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class AddAddressScreen extends StatelessWidget {
  final AddressController controller = Get.put(AddressController());

  AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
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
                    Text(
                      'Address Details',
                      style: AppTheme.fontStyleLarge.copyWith(
                        color: AppTheme.colorBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacing(size: AppTheme.spacingMedium),
                    CustomTextField(
                      labelText: 'Address Line 1',
                      controller: controller.line1Controller,
                    ),
                    const Spacing(size: AppTheme.spacingSmall),
                    CustomTextField(
                      labelText: 'Address Line 2',
                      controller: controller.line2Controller,
                    ),
                    const Spacing(size: AppTheme.spacingSmall),
                    CustomTextField(
                      labelText: 'City',
                      controller: controller.cityController,
                    ),
                    const Spacing(size: AppTheme.spacingSmall),
                    CustomTextField(
                      labelText: 'District',
                      controller: controller.districtController,
                    ),
                    const Spacing(size: AppTheme.spacingSmall),
                    CustomTextField(
                      labelText: 'Latitude (optional)',
                      keyboardType: TextInputType.number,
                      controller: controller.latitudeController,
                    ),
                    const Spacing(size: AppTheme.spacingSmall),
                    CustomTextField(
                      labelText: 'Longitude (optional)',
                      keyboardType: TextInputType.number,
                      controller: controller.longitudeController,
                    ),
                    const Spacing(size: AppTheme.spacingExtraLarge),
                    CustomButton(
                      onPressed: controller.saveAddress, // Use saveAddress here
                      text: 'Save Address',
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
