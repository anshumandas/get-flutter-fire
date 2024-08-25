// ignore_for_file: inference_failure_on_function_invocation

import 'package:cached_network_image/cached_network_image.dart';
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

                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListTile(
                        leading: AnimatedContainer(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeOut,
                          child: CachedNetworkImage(
                            imageUrl: item.imageUrl,
                            height: 72,
                            width: 72,
                          ),
                        ),
                        onTap: () {
                          Get.rootDelegate.toNamed(
                            Routes.PRODUCT_DETAILS(
                              item.id,
                            ),
                            parameters: {
                              "productName": item.name,
                              'imageUrl': item.imageUrl,
                            },
                          );
                        },
                        title: Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text(item.id),
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
