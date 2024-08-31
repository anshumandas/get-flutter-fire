import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/app/modules/profile/controllers/address_controller.dart';
import 'package:get_flutter_fire/app/widgets/cart/select_address_card.dart';
import 'package:get_flutter_fire/models/address_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class SelectAddressView extends StatelessWidget {
  const SelectAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.find<AddressController>();
    final cartController = Get.find<CartController>();
    final user = Get.find<AuthController>().user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Address",
          style: AppTheme.fontStyleDefaultBold,
        ),
        const SizedBox(height: AppTheme.spacingSmall),
        ListView.builder(
          itemCount: addressController.addresses.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            AddressModel address = addressController.addresses[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
              child: Obx(() => SelectAddressCard(
                    isDefault: user!.defaultAddressID == address.id,
                    selectedAddressID: cartController.selectedAddress,
                    address: address,
                    onSelect: (address) {
                      cartController.selectAddress(address.id);
                    },
                  )),
            );
          },
        ),
        // Center(
        //   child: SecondaryButton(
        //     label: context.loc.addAddress,
        //     onPressed: () => context.go(Routes.addAddress),
        //   ),
        // ),
      ],
    );
  }
}
