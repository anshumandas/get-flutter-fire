import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/admin/controller/banner_controller.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class AdminBannerListScreen extends StatelessWidget {
  const AdminBannerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BannerController bannerController = Get.put(BannerController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Banners'),
        backgroundColor: AppTheme.colorRed,
      ),
      body: Obx(() {
        if (bannerController.banners.isEmpty) {
          return const Center(child: Text('No banners available.'));
        }

        return ListView.builder(
          itemCount: bannerController.banners.length,
          itemBuilder: (context, index) {
            final banner = bannerController.banners[index];
            return Card(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSmall,
                  vertical: AppTheme.spacingTiny),
              child: ListTile(
                leading: Image.network(
                  banner.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  banner.productID,
                  style: AppTheme.fontStyleDefaultBold,
                ),
                subtitle: Text(
                  banner.isActive ? 'Active' : 'Inactive',
                  style: TextStyle(
                    color: banner.isActive
                        ? AppTheme.colorBlue
                        : AppTheme.colorRed,
                  ),
                ),
                trailing: Switch(
                  value: banner.isActive,
                  onChanged: (value) {
                    bannerController.toggleBannerStatus(banner);
                  },
                  activeColor: AppTheme.colorRed,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
