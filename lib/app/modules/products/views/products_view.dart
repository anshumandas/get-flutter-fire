import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/role.dart';
import '../../../routes/app_pages.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProductsFromApi();
    });

    var arg = Get.rootDelegate.arguments();
    return Scaffold(
      floatingActionButton:
          (arg != null && Get.rootDelegate.arguments()["role"] == Role.seller)
              ? FloatingActionButton.extended(
                  onPressed: controller.fetchProductsFromApi,
                  label: const Text('Refresh'),
                  icon: const Icon(Icons.refresh),
                )
              : null,
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: () async {
                  await controller.fetchProductsFromApi();
                },
                child: controller.products.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) {
                          final product = controller.products[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  width: 1),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              onTap: () {
                                Get.rootDelegate.toNamed(
                                    Routes.PRODUCT_DETAILS(product.id));
                              },
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '${product.brandName}\n${product.category.isNotEmpty ? product.category : 'No Category'}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ),
                              leading: product.productImage.isNotEmpty
                                  ? CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(product.productImage),
                                      radius: 30,
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 30,
                                      child: Icon(Icons.image_not_supported,
                                          size: 30, color: Colors.white),
                                    ),
                              trailing: Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
