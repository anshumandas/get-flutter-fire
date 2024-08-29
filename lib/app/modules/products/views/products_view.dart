import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import '../../../../models/role.dart';
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
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two products per row
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.75, // Adjust to control height/width ratio
                  ),
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Get.rootDelegate.toNamed(Routes.PRODUCT_DETAILS(item.id));
                      },
                      child: Container(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: item.productImage.isNotEmpty
                                    ? Image.network(
                                        item.productImage,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item.description}\n${item.category.isNotEmpty ? item.category : 'No Category'}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '₹${item.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
