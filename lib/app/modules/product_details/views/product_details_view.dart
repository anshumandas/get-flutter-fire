import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/models/product.dart';

import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetWidget<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Obx(
      () => Scaffold(
          floatingActionButton: cartController
                  .getProducts()
                  .where((p) => p.name == controller.productName)
                  .isNotEmpty
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    cartController.addProduct(
                      Product(
                        name: controller.productName,
                        id: controller.productId,
                        imageUrl: controller.imageUrl,
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.add_shopping_cart_rounded,
                  ),
                ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: controller.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                stretch: true,
                automaticallyImplyLeading: false,
                toolbarHeight: 200,
              ),
              SliverList.list(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TODO: Make some UI Changes in here

                        const SizedBox(height: 16),
                        Text('ProductId: ${controller.productId}'),
                        const SizedBox(height: 8),
                        Text(controller.productName),
                        const SizedBox(height: 8),
                        Text('Image Url: ${controller.imageUrl}'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
          // Column(
          //   mainAxisSize: MainAxisSize.max,
          //   children: [
          //     CachedNetworkImage(
          //       imageUrl: controller.imageUrl,
          //       width: double.infinity,
          //       fit: BoxFit.cover,
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 8),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           const SizedBox(height: 16),
          //           Text('ProductId: ${controller.productId}'),
          //           const SizedBox(height: 8),
          //           Text(controller.productName),
          //           const SizedBox(height: 8),
          //           Text('Image Url: ${controller.imageUrl}'),
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          ),
    );
  }
}
