// ignore_for_file: inference_failure_on_function_invocation

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
                )
              : null,
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
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final item = controller.products[index];
                    return ListTile(
                      onTap: () {
                        Get.rootDelegate.toNamed(Routes.PRODUCT_DETAILS(
                            item.id)); //we could use Get Parameters
                      },
                      title: Text(item.name),
                      subtitle: Text(item.id),
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
