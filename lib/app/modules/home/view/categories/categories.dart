import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/home/controllers/home_controller.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final categories = homeController.categories;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(
            color: AppTheme.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: AppTheme.fontSizeLarge,
          ),
        ),
        backgroundColor: AppTheme.colorWhite,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: AppTheme.paddingDefault,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppTheme.spacingDefault,
            mainAxisSpacing: AppTheme.spacingDefault,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return InkWell(
              onTap: () {
                if (kDebugMode) {
                  print('Tapped on category: ${category.id}');
                }
                Get.toNamed(
                  Routes.PRODUCTS_LISTING,
                  arguments: {'category': category.id},
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.colorWhite,
                  borderRadius: AppTheme.borderRadius,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.colorBlack.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: AppTheme.borderRadiusSmall,
                      child: Image.network(
                        category.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingTiny),
                    Text(
                      category.name,
                      style: AppTheme.fontStyleDefaultBold.copyWith(
                        fontSize: AppTheme.fontSizeMedium,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
