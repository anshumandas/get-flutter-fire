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
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image or Placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.local_cafe, // Same icon as in ProductsView
                  size: 100,
                  color: Colors.brown.shade700,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Product Name
            Text(
              'Premium Coffee Blend',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700,
              ),
            ),
            const SizedBox(height: 8.0),
            // Product ID
            Text(
              'Product ID: ${controller.productId}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown.shade500,
              ),
            ),
            const SizedBox(height: 16.0),
            // Product Description
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Our Premium Coffee Blend is crafted from the finest beans sourced from around the world. It features a rich, full-bodied flavor with hints of caramel and chocolate. Perfect for coffee enthusiasts who enjoy a complex and satisfying cup of coffee.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown.shade600,
              ),
            ),
            const SizedBox(height: 16.0),
            // Additional Product Info
            Text(
              'Additional Information:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '• Weight: 250g\n'
              '• Roasting Level: Medium\n'
              '• Origin: Brazil, Colombia, Ethiopia\n'
              '• Packaging: Resealable bag\n'
              '• Price: \$14.99\n'
              '• Available: In Stock',
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
