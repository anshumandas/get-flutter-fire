import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/admin/controller/approve_seller_controller.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class ApproveSellerScreen extends StatelessWidget {
  const ApproveSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ApproveSellerController controller =
        Get.put(ApproveSellerController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Approve Sellers'),
        backgroundColor: AppTheme.colorRed,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.usersToApprove.isEmpty) {
          return const Center(child: Text('No sellers pending approval.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppTheme.spacingSmall),
          itemCount: controller.usersToApprove.length,
          itemBuilder: (context, index) {
            final user = controller.usersToApprove[index];
            return Card(
              margin:
                  const EdgeInsets.symmetric(vertical: AppTheme.spacingTiny),
              shape: RoundedRectangleBorder(
                borderRadius: AppTheme.borderRadius,
              ),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.colorBlue,
                  child: Text(
                    user.name.substring(0, 1).toUpperCase(),
                    style: AppTheme.fontStyleDefaultBold
                        .copyWith(color: AppTheme.colorWhite),
                  ),
                ),
                title: Text(
                  user.name,
                  style: AppTheme.fontStyleMedium,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppTheme.spacingTiny),
                    Text('Phone: ${user.phoneNumber}',
                        style: AppTheme.fontStyleSmall),
                    if (user.email != null)
                      Text('Email: ${user.email}',
                          style: AppTheme.fontStyleSmall),
                    if (user.businessName != null)
                      Text('Business Name: ${user.businessName}',
                          style: AppTheme.fontStyleSmall),
                    if (user.businessType != null)
                      Text('Business Type: ${user.businessType}',
                          style: AppTheme.fontStyleSmall),
                    const SizedBox(height: AppTheme.spacingTiny),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () => controller.approveSeller(user),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.colorRed,
                  ),
                  child: const Text('Approve'),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
