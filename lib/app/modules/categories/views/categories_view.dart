import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/categories/controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoryController> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Obx(() {
        if (controller.categories.isEmpty) {
          return const Center(child: Text('No categories'));
        }
        return ListView.builder(
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            return ExpansionTile(
              title: Text(category.name),
              children: category.subCategories.map((subCategory) => ListTile(
                title: Text(subCategory.name),
              )).toList(),
            );
          },
        );
      }),
    );
  }
}
