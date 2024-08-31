import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/profile/controllers/contact_controller.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_bottom_button.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_dropdown.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_textfield.dart';
import 'package:get_flutter_fire/app/widgets/common/show_loader.dart';
import 'package:get_flutter_fire/app/widgets/common/show_toast.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/enums/enums.dart';
import 'package:get_flutter_fire/models/contact_enquiry_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/theme/assets.dart';
import 'package:get_flutter_fire/utils/get_reference.dart';
import 'package:get_flutter_fire/utils/get_uuid.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';

class SupportScreen extends StatelessWidget {
  final ContactController contactController = Get.put(ContactController());
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController _messageController = TextEditingController();
  final Rx<QueryType?> _selectedQueryType = Rx<QueryType?>(null);

  SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> supportOptions = [
      {
        'imagePath': iconPhone,
        'text': '+91 9324366823',
        'onTap': () {},
      },
      {
        'imagePath': iconMail,
        'text': 'basedharsh@gmail.com',
        'onTap': () {},
      },
      {
        'imagePath': iconWhatsapp,
        'text': '+91 9324366823',
        'onTap': () {},
      },
      {
        'imagePath': iconLocation,
        'text': 'Mumbai, India...',
        'onTap': () {},
      },
    ];

    void submitEnquiry() async {
      if (_selectedQueryType.value == null) {
        showToast("Please select a query type");
        return;
      }

      if (_messageController.text.trim().isEmpty) {
        showToast("Please enter a message");
        return;
      }

      showLoader();

      try {
        String successMessage = "Enquiry submitted successfully";
        String id = getUUID();

        ContactEnquiryModel contactEnquiry = ContactEnquiryModel(
          id: id,
          message: _messageController.text.trim(),
          timestamp: DateTime.now(),
          userID: authController.user!.id,
          queryType: _selectedQueryType.value!,
          reference: getReference(),
          status: EnquiryStatus.pending,
        );

        await contactController.addEnquiry(contactEnquiry);

        _messageController.clear();
        _selectedQueryType.value = null;

        showToast(successMessage);
      } catch (e) {
        showToast("Failed to submit enquiry. Please try again.");
      } finally {
        dismissLoader();
      }
    }

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
          'Support',
          style: AppTheme.fontStyleDefaultBold.copyWith(
            color: AppTheme.greyTextColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppTheme.paddingDefault,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: supportOptions.length,
                itemBuilder: (context, index) {
                  final option = supportOptions[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: Image.asset(option['imagePath'] as String,
                            height: 24.0, width: 24.0),
                        title: Text(option['text'] as String,
                            style: AppTheme.fontStyleDefault),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            size: 16, color: AppTheme.greyTextColor),
                        onTap: option['onTap'] as VoidCallback,
                      ),
                      if (index != supportOptions.length - 1)
                        const Spacing(size: AppTheme.spacingTiny),
                      const Divider(height: 0.1, color: AppTheme.greyTextColor),
                    ],
                  );
                },
              ),
              const Spacing(size: AppTheme.spacingLarge),
              Text('Send Query',
                  style: AppTheme.fontStyleLarge.copyWith(
                    color: AppTheme.colorBlack,
                    fontWeight: FontWeight.bold,
                  )),
              const Spacing(size: AppTheme.spacingSmall),
              Obx(() {
                return CustomDropdown<QueryType>(
                  hintText: 'Select Query Type',
                  items: QueryType.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.toString().split('.').last),
                          ))
                      .toList(),
                  onChanged: (QueryType? val) {
                    _selectedQueryType.value = val;
                  },
                  value: _selectedQueryType.value,
                );
              }),
              const Spacing(size: AppTheme.spacingSmall),
              CustomTextField(
                labelText: 'Write your query',
                controller: _messageController,
              ),
              const Spacing(size: AppTheme.spacingDefault),
              CustomBottomButton(
                label: 'Submit',
                onPressed: submitEnquiry,
              ),
              const Spacing(size: AppTheme.spacingSmall),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.PAST_QUERIES);
                  },
                  child: Text(
                    'Visit Past Queries',
                    style: AppTheme.fontStyleDefaultBold.copyWith(
                      color: AppTheme.colorRed,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const Spacing(size: AppTheme.spacingSmall),
            ],
          ),
        ),
      ),
    );
  }
}
