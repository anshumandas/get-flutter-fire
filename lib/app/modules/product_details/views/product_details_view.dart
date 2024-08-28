//lib/app/modules/product_details/views/product_details_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = controller.product.value;

        if (product == null) {
          return const Center(child: Text('Product not found'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title ?? 'No Title', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Image.network(product.images?.first ?? ''),
              const SizedBox(height: 10),
              Text('Price: \$${product.price ?? 0}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text('Description: ${product.description ?? 'No Description'}'),
              const SizedBox(height: 10),
              Text('Category: ${product.category ?? 'No Category'}'),
              // Add other product details here
            ],
          ),
        );
      }),
    );
  }
}

