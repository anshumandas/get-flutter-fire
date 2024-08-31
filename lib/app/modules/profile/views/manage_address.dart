import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/profile/controllers/address_controller.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_bottom_button.dart';
import 'package:get_flutter_fire/app/widgets/common/overlay_loader.dart';
import 'package:get_flutter_fire/app/widgets/common/show_loader.dart';
import 'package:get_flutter_fire/app/widgets/profile/address_container.dart';
import 'package:get_flutter_fire/models/address_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class ManageAddressScreen extends StatefulWidget {
  const ManageAddressScreen({super.key});

  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  final AddressController addressController = Get.put(AddressController());

  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    addressController.fetchAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp,
              color: AppTheme.greyTextColor, size: 18),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Manage Address',
          style: AppTheme.fontStyleDefaultBold.copyWith(
            color: AppTheme.greyTextColor,
          ),
        ),
      ),
      body: Obx(() {
        if (addressController.addresses.isEmpty) {
          return const LoadingWidget();
        }

        return Padding(
          padding: AppTheme.paddingSmall,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: addressController.addresses.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    AddressModel address = addressController.addresses[index];
                    bool isDefault = address.id ==
                        authController.currentUser.value?.defaultAddressID;

                    return Column(
                      children: [
                        if (index != 0)
                          const SizedBox(height: AppTheme.spacingTiny),
                        AddressContainer(
                          address: address,
                          onDelete: (id) {
                            showLoader();
                            addressController.deleteAddress(id).then((_) {
                              dismissLoader();
                            });
                          },
                          isDefault: isDefault,
                          onSetAsDefault: (id) {
                            showLoader();
                            addressController
                                .setDefaultAddress(address)
                                .then((_) {
                              dismissLoader();
                            });
                          },
                        ),
                        const Divider(
                          color: AppTheme.greyTextColor,
                          height: 0.1,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: AppTheme.colorWhite,
        child: CustomBottomButton(
          label: 'Add New Address',
          onPressed: () {
            Get.toNamed(Routes.ADD_ADDRESS);
          },
        ),
      ),
    );
  }
}
