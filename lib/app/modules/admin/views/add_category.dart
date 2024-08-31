import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/admin/controller/category_controller.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_textfield.dart';
import 'package:get_flutter_fire/models/category_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  AddCategoryScreenState createState() => AddCategoryScreenState();
}

class AddCategoryScreenState extends State<AddCategoryScreen> {
  final CategoryController categoryController = Get.find<CategoryController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  File? selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
        imageUrlController.clear();
      });
    }
  }

  Future<void> _addCategory() async {
    if (nameController.text.isNotEmpty) {
      final category = CategoryModel(
        id: DateTime.now().toString(),
        name: nameController.text,
        imageUrl: imageUrlController.text,
      );

      try {
        Get.dialog(
          const Center(child: CircularProgressIndicator()),
          barrierDismissible: false,
        );

        await categoryController.addCategory(category,
            imageFile: selectedImage);

        Get.back();
      } catch (e) {
        Get.back();
        Get.snackbar('Error', 'Failed to add category: $e');
      }
    } else {
      Get.snackbar('Error', 'Category name is required');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Category'),
      ),
      body: Padding(
        padding: AppTheme.paddingDefault,
        child: Column(
          children: [
            CustomTextField(
              labelText: 'Category Name',
              controller: nameController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              labelText: 'Image URL (optional)',
              controller: imageUrlController,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.upload),
              label: const Text('Upload Image'),
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppTheme.colorRed),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addCategory,
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppTheme.colorRed),
              child: const Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }
}
