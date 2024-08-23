import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/role.dart';
import '../../../routes/app_pages.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    var arg = Get.rootDelegate.arguments();
    return Scaffold(
      floatingActionButton:
          (arg != null && Get.rootDelegate.arguments()["role"] == Role.seller)
              ? FloatingActionButton.extended(
                  onPressed: controller.loadDemoProductsFromSomeWhere,
                  label: const Text('Add'),
                  backgroundColor: Colors.pinkAccent, // Theme color for FAB
                )
              : null,
      appBar: AppBar(
        title: const Text('Perfumes'),
        backgroundColor: Colors.pink, // Theme color for AppBar
        actions: [
          PopupMenuButton<String>(
            onSelected: controller.setCategory,
            itemBuilder: (context) => [
              const PopupMenuItem(value: '', child: Text('All')),
              const PopupMenuItem(value: 'Women', child: Text('Women')),
              const PopupMenuItem(value: 'Men', child: Text('Men')),
              const PopupMenuItem(value: 'Unisex', child: Text('Unisex')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const Hero(
            tag: 'heroLogo',
            child: FlutterLogo(),
          ),
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: () async {
                  controller.products.clear();
                  controller.loadDemoProductsFromSomeWhere();
                },
                child: ListView.builder(
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredProducts[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.1), // Theme color for shadow
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        onTap: () {
                          Get.rootDelegate.toNamed(Routes.PRODUCT_DETAILS(item.id));
                        },
                        title: Text(
                          item.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${item.description}\n${item.category.isNotEmpty ? item.category : 'No Category'}',
                            style: const TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                        leading: item.productImage.isNotEmpty
                            ? Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(item.productImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.image_not_supported, size: 30, color: Colors.white),
                              ),
                        trailing: Text(
                          '₹${item.sellingPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.pink, // Theme color for price
                          ),
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
