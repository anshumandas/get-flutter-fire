//lib/app/modules/products/views/products_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/products_controller.dart';
import '../../../widgets/product_item.dart';

class ProductPage extends GetView<ProductsController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Obx(() {
        if (controller.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return ProductItem(product: product);
          },
        );
      }),
    );
  }
}
