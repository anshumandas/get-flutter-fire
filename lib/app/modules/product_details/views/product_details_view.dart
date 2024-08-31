import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetWidget<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Obx(() {
        final product = controller.product.value;

        // Define sizes and descriptions matching product names from the controller
        final sizes = {
          'T-shirt': ['S', 'M', 'L', 'XL'],
          'Pages': [], // No sizes for Pages
          'Sports': ['Small', 'Medium', 'Large'],
          'Jacket': ['S', 'M', 'L', 'XL'],
          'Handwash': [], // No sizes for Handwash
        }[product.name] ?? [];

        final descriptions = {
          'T-shirt': 'A comfortable cotton t-shirt for everyday wear.',
          'Pages': 'A notebook with pages for writing.',
          'Sports': 'Various sports equipment for different activities.',
          'Jacket': 'Warm and cozy jacket for cold days.',
          'Handwash': 'A gentle handwash to keep your hands clean.',
        }[product.name] ?? 'No description available.';

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Icon
                Center(
                  child: Icon(
                    product.icon,
                    size: 150, // Adjust size as needed
                    color: Colors.blueGrey[700], // Or any color you prefer
                  ),
                ),
                SizedBox(height: 16),

                // Product Title
                Text(
                  product.name,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),

                // Product Price
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),

                // Product Date
                Text(
                  'Date Added: ${product.date.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 20),

                // Available Sizes
                if (sizes.isNotEmpty) ...[
                  Text(
                    'Available Sizes:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  DropdownButton<String>(
                    value: controller.selectedSize.value.isNotEmpty
                        ? controller.selectedSize.value
                        : null, // Default selected size
                    hint: Text('Select Size'),
                    onChanged: (String? newSize) {
                      if (newSize != null) {
                        controller.selectedSize.value = newSize;
                      }
                    },
                    items: sizes.map((size) {
                      return DropdownMenuItem<String>(
                        value: size,
                        child: Text(size),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                ],

                // Product Description
                Text(
                  'Description:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  descriptions,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),

                // Add to Cart Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (sizes.isNotEmpty && controller.selectedSize.value.isEmpty) {
                        Get.snackbar(
                          'Size Required',
                          'Please select a size before adding to cart.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else {
                        controller.addToCart();
                        Get.snackbar(
                          'Added to Cart',
                          '${product.name} has been added to your cart.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
