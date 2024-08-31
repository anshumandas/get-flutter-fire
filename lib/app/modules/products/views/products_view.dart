import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/role.dart';
import '../../../routes/app_pages.dart';
import '../controllers/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import '../controllers/products_controller.dart';
  import '../../../../models/product.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    var arg = Get.rootDelegate.arguments();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      floatingActionButton: (arg != null && Get.rootDelegate.arguments()["role"] == Role.seller)
          ? FloatingActionButton.extended(
              onPressed: controller.loadDemoProductsFromSomeWhere,
              label: const Text('Add Product'),
              backgroundColor: Colors.orange,
              icon: const Icon(Icons.add),
            )
          : null,
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            controller.products.clear();
            controller.loadDemoProductsFromSomeWhere();
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final item = controller.products[index];
              return _buildProductCard(item);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(Product item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          leading: CircleAvatar(
            backgroundColor: Colors.orange.shade100,
            child: Icon(
              Icons.local_cafe,
              size: 40,
              color: Colors.brown.shade700,
            ),
          ),
          title: Text(
            item.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown.shade700,
            ),
          ),
          subtitle: Text(
            item.id,
            style: TextStyle(
              fontSize: 14,
              color: Colors.brown.shade500,
            ),
          ),
          onTap: () {
            Get.rootDelegate.toNamed(Routes.PRODUCT_DETAILS(item.id));
          },
          tileColor: Colors.orange.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
