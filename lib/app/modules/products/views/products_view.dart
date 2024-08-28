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
    return Container(
      color: Colors.purple[300], // Set the background color to purple
      child: Scaffold(
        backgroundColor:
            Colors.transparent, // Make Scaffold's background transparent
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
                          color: Colors
                              .white, // Set container color to purple[300]
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.all(10),
                        child: InkWell(
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
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: item.imageUrl,
                                height: 72,
                                width: 144,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(item.id),
                                  ],
                                ),
                              )
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
      ),
    );
  }
}
