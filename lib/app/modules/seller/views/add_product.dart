import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/seller/controllers/seller_controller.dart';
import 'package:get_flutter_fire/models/category_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_textfield.dart';
import 'package:get_flutter_fire/app/widgets/common/overlay_loader.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  AddProductPageState createState() => AddProductPageState();
}

class AddProductPageState extends State<AddProductPage> {
  final SellerController sellerController = Get.find<SellerController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final RxList<String> images = <String>[].obs;
  final RxBool isUploading = false.obs;
  final RxString selectedCategory = ''.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final fetchedCategories = await sellerController.fetchCategories();
    categories.assignAll(fetchedCategories);
    if (fetchedCategories.isNotEmpty) {
      selectedCategory.value = fetchedCategories.first.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: AppTheme.colorRed,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppTheme.paddingDefault,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  labelText: 'Product Name',
                  controller: nameController,
                ),
                const SizedBox(height: AppTheme.spacingDefault),
                CustomTextField(
                  labelText: 'Description',
                  controller: descriptionController,
                ),
                const SizedBox(height: AppTheme.spacingDefault),
                CustomTextField(
                  labelText: 'Price',
                  controller: priceController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppTheme.spacingDefault),
                CustomTextField(
                  labelText: 'Quantity',
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppTheme.spacingDefault),
                CustomTextField(
                  labelText: 'Unit Weight (grams)',
                  controller: weightController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppTheme.spacingDefault),
                Obx(() => DropdownButton<String>(
                      value: selectedCategory.value,
                      onChanged: (value) {
                        if (value != null) {
                          selectedCategory.value = value;
                        }
                      },
                      items: categories
                          .map((category) => DropdownMenuItem<String>(
                                value: category.id,
                                child: Text(category.name),
                              ))
                          .toList(),
                    )),
                const SizedBox(height: AppTheme.spacingDefault),
                CustomTextField(
                  labelText: 'Image URL (optional)',
                  controller: imageUrlController,
                ),
                const SizedBox(height: AppTheme.spacingDefault),
                _buildImagePicker(images, isUploading),
                const SizedBox(height: AppTheme.spacingDefault),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        priceController.text.isEmpty ||
                        quantityController.text.isEmpty ||
                        weightController.text.isEmpty ||
                        (images.isEmpty && imageUrlController.text.isEmpty)) {
                      Get.snackbar('Error',
                          'Please fill all fields and add at least one image or provide an image URL.');
                      return;
                    }

                    // Add image URL to the list if it is provided
                    if (imageUrlController.text.isNotEmpty) {
                      images.add(imageUrlController.text);
                    }

                    sellerController.addSellerProduct(
                      name: nameController.text,
                      description: descriptionController.text,
                      unitPrice: int.parse(priceController.text),
                      remainingQuantity: int.parse(quantityController.text),
                      unitWeight: int.parse(weightController.text),
                      images: images.toList(),
                      categoryID: selectedCategory.value,
                    );

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.colorRed,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(RxList<String> images, RxBool isUploading) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Product Images', style: AppTheme.fontStyleMedium),
            const SizedBox(height: AppTheme.spacingSmall),
            Wrap(
              spacing: 10,
              children: [
                ...images.map((image) => _buildImagePreview(image, images)),
                _buildAddImageButton(images, isUploading),
              ],
            ),
            if (isUploading.value)
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Center(
                  child: LoadingWidget(),
                ),
              ),
          ],
        ));
  }

  Widget _buildImagePreview(String imagePath, RxList<String> images) {
    return Stack(
      children: [
        Image.file(
          File(imagePath),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => images.remove(imagePath),
            child: Container(
              color: Colors.black54,
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddImageButton(RxList<String> images, RxBool isUploading) {
    return GestureDetector(
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        isUploading.value = true;
        try {
          final pickedFile =
              await picker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            images.add(pickedFile.path);
          }
        } finally {
          isUploading.value = false;
        }
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: AppTheme.colorDisabled,
          borderRadius: AppTheme.borderRadius,
        ),
        child: const Icon(Icons.add_a_photo, color: Colors.white),
      ),
    );
  }
}
