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
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'ProductDetailsView is working',
                style: TextStyle(fontSize: 20),
              ),
              Text('ProductId: ${controller.productId}'),
              Text('Product Name: ${controller.productName}'),
              Text('Image Url: ${controller.imageUrl}'),
              CachedNetworkImage(imageUrl: controller.imageUrl),
            ],
          ),
        ),
      ),
    );
  }
}
