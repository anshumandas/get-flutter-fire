import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/product.dart';
import '../routes/app_pages.dart';

class ProductItem extends StatelessWidget {
  final Products product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Get.rootDelegate.toNamed(
              Routes.PRODUCT_DETAILS(product.id.toString()),
              parameters: {'productId': product.id.toString()});
        },
        title: Text(product.title ?? ''),
        subtitle: Text('Price: \$${product.price}'),
        trailing: Image.network(
            product.images?[0] ??
                'https://as2.ftcdn.net/v2/jpg/00/59/96/75/1000_F_59967553_9g2bvhTZf18zCmEVWcKigEoevGzFqXzq.jpg',
            width: 50,
            height: 50),
      ),
    );
  }
}
