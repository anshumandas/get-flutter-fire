import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/role.dart';
import '../../../routes/app_pages.dart';
import '../controllers/products_controller.dart';
import '../../../../models/product.dart'; // Ensure this import is correct

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    var arg = Get.rootDelegate.arguments();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          if (arg != null && Get.rootDelegate.arguments()["role"] == Role.seller)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                controller.loadDemoProductsFromSomeWhere();
              },
            ),
        ],
      ),
      body: Obx(
            () => RefreshIndicator(
          onRefresh: () async {
            controller.products.clear();
            controller.loadDemoProductsFromSomeWhere();
          },
          child: ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final item = controller.products[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: InkWell(
                  onTap: () {
                    Get.rootDelegate.toNamed(Routes.PRODUCT_DETAILS(item.id));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(item.icon, size: 50, color: Colors.blueGrey[700]), // Use icon for product
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                '\$${item.price.toStringAsFixed(2)}', // Display price
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green[700],
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Date: ${item.date.toLocal().toString().split(' ')[0]}', // Display date in YYYY-MM-DD format
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
