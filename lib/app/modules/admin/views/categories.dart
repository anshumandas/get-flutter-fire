import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/admin/controller/category_controller.dart';
import 'package:get_flutter_fire/app/modules/admin/views/add_category.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class CategoryListScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    categoryController.fetchCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Categories'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: categoryController.categories.length,
          itemBuilder: (context, index) {
            final category = categoryController.categories[index];
            return ListTile(
              title: Text(category.name),
              // ignore: unnecessary_null_comparison
              leading: category.imageUrl != null
                  ? Image.network(category.imageUrl, width: 30, height: 30)
                  : const Icon(Icons.image_not_supported),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  categoryController.deleteCategory(category.id);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddCategoryScreen());
        },
        backgroundColor: AppTheme.colorRed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
