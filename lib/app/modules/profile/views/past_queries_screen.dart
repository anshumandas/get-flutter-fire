import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/profile/controllers/contact_controller.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/utils/months.dart';

class PastQueriesScreen extends StatelessWidget {
  final ContactController contactController = Get.put(ContactController());

  PastQueriesScreen({super.key});

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
          'Past Queries',
          style: AppTheme.fontStyleDefault.copyWith(
            color: AppTheme.greyTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: AppTheme.paddingDefault,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacing(size: AppTheme.spacingTiny),
            Row(
              children: [
                _buildTabButton('Pending'),
                const Spacing(
                  size: AppTheme.spacingDefault,
                  isHorizontal: true,
                ),
                _buildTabButton('In-Progress'),
                const Spacing(
                  size: AppTheme.spacingDefault,
                  isHorizontal: true,
                ),
                _buildTabButton('Completed'),
              ],
            ),
            const Spacing(size: AppTheme.spacingMedium),
            Expanded(
              child: Obx(() {
                if (contactController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (contactController.filteredEnquiries.isEmpty) {
                  return const Center(child: Text('No queries found.'));
                }

                return ListView.builder(
                  itemCount: contactController.filteredEnquiries.length,
                  itemBuilder: (context, index) {
                    final enquiry = contactController.filteredEnquiries[index];
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.insert_drive_file,
                                color: AppTheme.greyTextColor),
                            const Spacing(
                                size: AppTheme.spacingSmall,
                                isHorizontal: true),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(enquiry.message,
                                      style: AppTheme.fontStyleDefaultBold),
                                  const Spacing(size: AppTheme.spacingTiny),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 8.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          border: Border.all(
                                              color: AppTheme.colorRed),
                                        ),
                                        child: Text(enquiry.queryType.name,
                                            style: AppTheme.fontStyleDefault
                                                .copyWith(
                                              color: AppTheme.colorRed,
                                            )),
                                      ),
                                      const Spacing(
                                          size: AppTheme.spacingSmall),
                                      Text(
                                        '${enquiry.timestamp.day} ${monthString(enquiry.timestamp.month)}, ${enquiry.timestamp.year}, ${enquiry.timestamp.hour}:${enquiry.timestamp.minute} ${enquiry.timestamp.hour >= 12 ? "PM" : "AM"}',
                                        style: AppTheme.fontStyleDefault,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                            height: 32, color: AppTheme.greyTextColor),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String tab) {
    return Expanded(
      child: Obx(() {
        final isSelected = contactController.selectedTab.value == tab;
        return InkWell(
          onTap: () {
            contactController.changeTab(tab);
          },
          child: Container(
            padding: AppTheme.paddingSmall,
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.colorRed : AppTheme.colorWhite,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: isSelected ? AppTheme.colorRed : AppTheme.greyTextColor,
              ),
            ),
            child: Center(
              child: Text(
                tab,
                style: AppTheme.fontStyleDefaultBold.copyWith(
                  fontSize: 12,
                  color: isSelected ? AppTheme.colorWhite : AppTheme.colorBlack,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        );
      }),
    );
  }
}
