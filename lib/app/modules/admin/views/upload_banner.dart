import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/admin/controller/banner_controller.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class AdminBannerUploadScreen extends StatelessWidget {
  const AdminBannerUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BannerController bannerController = Get.put(BannerController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Banner'),
        backgroundColor: AppTheme.colorRed,
      ),
      body: Padding(
        padding: AppTheme.paddingDefault,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppTheme.spacingSmall),
            TextField(
              controller: bannerController.imageUrlController,
              decoration: InputDecoration(
                labelText: 'Image URL',
                border: AppTheme.textfieldBorder,
              ),
            ),
            const SizedBox(height: AppTheme.spacingSmall),
            Center(
              child: ElevatedButton(
                onPressed: bannerController.pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.colorBlue,
                ),
                child: const Text(
                  'Upload Image',
                  style: TextStyle(color: AppTheme.colorWhite),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingSmall),
            Obx(() => bannerController.selectedImage.value != null
                ? Text(
                    'Selected image: ${bannerController.selectedImage.value!.path}')
                : const Text('No image selected')),
            const SizedBox(height: AppTheme.spacingSmall),
            TextField(
              controller: bannerController.productIDController,
              decoration: InputDecoration(
                labelText: 'Product ID',
                border: AppTheme.textfieldBorder,
              ),
            ),
            const SizedBox(height: AppTheme.spacingSmall),
            Obx(() => SwitchListTile(
                  title: const Text('Active'),
                  value: bannerController.isActive.value,
                  onChanged: (value) {
                    bannerController.isActive.value = value;
                  },
                  activeColor: AppTheme.colorRed,
                )),
            const SizedBox(height: AppTheme.spacingLarge),
            Center(
              child: ElevatedButton(
                onPressed: bannerController.uploadBanner,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.colorRed,
                  padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.spacingDefault,
                      horizontal: AppTheme.spacingLarge),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                      color: AppTheme.colorWhite,
                      fontSize: AppTheme.fontSizeMedium),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
