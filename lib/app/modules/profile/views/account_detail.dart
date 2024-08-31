import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_bottom_button.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_phone_textfield.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_textfield.dart';
import 'package:get_flutter_fire/app/widgets/common/show_loader.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  AccountDetailsScreenState createState() => AccountDetailsScreenState();
}

class AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _businessTINController = TextEditingController();
  final _businessVATController = TextEditingController();
  String? selectedBusinessType;

  final List<String> businessTypes = ['Fashion', 'Electronics', 'Groceries'];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    final authController = Get.find<AuthController>();
    final user = authController.user;
    if (user == null) return;
    _fullNameController.text = user.name;
    _emailController.text = user.email ?? '';
    _phoneNumberController.text = user.phoneNumber;
    _businessNameController.text = user.businessName ?? '';
    _businessTINController.text = user.gstNumber ?? '';
    _businessVATController.text = user.panNumber ?? '';
    selectedBusinessType =
        businessTypes.contains(user.businessType) ? user.businessType : null;
  }

  void _updateProfile() {
    showLoader();
    final authController = Get.find<AuthController>();
    final user = authController.user;

    if (user == null) return;

    final newUser = user.copyWith(
      name: _fullNameController.text,
      email: _emailController.text.isNotEmpty ? _emailController.text : null,
      businessName: _businessNameController.text,
      businessType: selectedBusinessType,
      gstNumber: _businessTINController.text,
      panNumber: _businessVATController.text,
    );

    authController.registerUser(newUser);

    dismissLoader();
    Get.back();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _businessNameController.dispose();
    _businessTINController.dispose();
    _businessVATController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp,
              color: AppTheme.greyTextColor),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Account Details',
          style: AppTheme.fontStyleDefaultBold.copyWith(
            color: AppTheme.greyTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingDefault),
        child: GetBuilder<AuthController>(
          builder: (authController) {
            if (authController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: [
                const Text(
                  'Personal Details',
                  style: AppTheme.fontStyleDefaultBold,
                ),
                const Spacing(size: AppTheme.spacingSmall),
                CustomTextField(
                  labelText: 'Name',
                  controller: _fullNameController,
                ),
                const Spacing(size: AppTheme.spacingSmall),
                CustomTextField(
                  labelText: 'Email (Optional)',
                  controller: _emailController,
                ),
                const Spacing(size: AppTheme.spacingSmall),
                PhoneTextField(
                  hintText: 'Enter 9-digit mobile number',
                  readOnly: true,
                  controller: _phoneNumberController,
                ),
                const Spacing(size: AppTheme.spacingDefault),
                const Text(
                  'Business Details',
                  style: AppTheme.fontStyleDefaultBold,
                ),
                const Spacing(size: AppTheme.spacingSmall),
                CustomTextField(
                  labelText: 'Business Name',
                  controller: _businessNameController,
                ),
                const Spacing(size: AppTheme.spacingSmall),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Business Type',
                    border: AppTheme.textfieldUnderlineBorder,
                  ),
                  value: selectedBusinessType,
                  items: businessTypes
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBusinessType = value;
                    });
                  },
                ),
                const Spacing(size: AppTheme.spacingSmall),
                CustomTextField(
                  labelText: 'TIN Number (Optional)',
                  controller: _businessTINController,
                ),
                const Spacing(size: AppTheme.spacingSmall),
                CustomTextField(
                  labelText: 'VRN Number (Optional)',
                  controller: _businessVATController,
                ),
                const Spacing(size: AppTheme.spacingMedium),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: AppTheme.colorWhite,
        child: CustomBottomButton(
          label: 'Save Changes',
          onPressed: _updateProfile,
        ),
      ),
    );
  }
}
