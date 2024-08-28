//lib/app/widgets/product_item.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/product.dart'; // Ensure this path is correct
import '../../app/routes/app_pages.dart';

class ProductItem extends StatelessWidget {
  final Products product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(product.thumbnail ?? ''),
      title: Text(product.title ?? 'No Title'),
      subtitle: Text('\$${product.price ?? 0}'),
      onTap: () {
        Get.toNamed(
          Routes.PRODUCT_DETAILS as String,
          parameters: {'productId': product.id.toString()},
        );
      },
    );
  }
}

