import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailScreen extends GetWidget<ProductDetailController> {

  const ProductDetailScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    final productId = int.parse(Get.parameters['productId']!);
    final productController = Get.put(ProductDetailController(productId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (productController.product == null) {
          return const Center(child: Text('Product not found'));
        } else {
          final product = productController.product!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  Image.network(product.thumbnail!),
                  // Product title
                  Text(product.title!,
                      style: Theme.of(context).textTheme.titleMedium),
                  // Product description
                  Text(product.description!),
                  // Other product details (price, rating, etc.)
                  // ...
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add to cart logic
                      productController.addToCart(product);
                    },
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
