import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/seller/controllers/seller_controller.dart';
import 'package:get_flutter_fire/models/product_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_textfield.dart';
import 'package:get_flutter_fire/app/widgets/common/overlay_loader.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart:io';

class EditProductPage extends StatelessWidget {
  final ProductModel product;
  final SellerController sellerController = Get.find<SellerController>();

  EditProductPage({super.key, required this.product});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final RxList<String> images = <String>[].obs;
  final RxBool isUploading = false.obs;

  @override
  Widget build(BuildContext context) {
    nameController.text = product.name;
    descriptionController.text = product.description;
    priceController.text = product.unitPrice.toString();
    quantityController.text = product.remainingQuantity.toString();
    weightController.text = product.unitWeight.toString();
    images.assignAll(product.images);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
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
                _buildImagePicker(images, isUploading),
                const SizedBox(height: AppTheme.spacingDefault),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        priceController.text.isEmpty ||
                        quantityController.text.isEmpty ||
                        weightController.text.isEmpty ||
                        images.isEmpty) {
                      Get.snackbar('Error',
                          'Please fill all fields and add at least one image.');
                      return;
                    }

                    sellerController.updateSellerProduct(
                      id: product.id,
                      name: nameController.text,
                      description: descriptionController.text,
                      unitPrice: int.parse(priceController.text),
                      remainingQuantity: int.parse(quantityController.text),
                      unitWeight: int.parse(weightController.text),
                      images: images.toList(),
                    );

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.colorRed,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Update Product'),
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
        Image.network(
          imagePath,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
        // Image.file(
        //   File(imagePath),
        //   width: 100,
        //   height: 100,
        //   fit: BoxFit.cover,
        // ),
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
