import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/products_controller.dart';
import '../../../routes/app_pages.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          PopupMenuButton<String>(
            onSelected: controller.setCategory,
            itemBuilder: (context) => [
              const PopupMenuItem(value: '', child: Text('All')),
              const PopupMenuItem(value: 'Male', child: Text('Male')),
              const PopupMenuItem(value: 'Female', child: Text('Female')),
              const PopupMenuItem(value: 'Unisex', child: Text('Unisex')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
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
                          color: Colors.black.withOpacity(0.1),
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
                          '${item.brandName}\n${item.category.isNotEmpty ? item.category : 'No Category'}',
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
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
