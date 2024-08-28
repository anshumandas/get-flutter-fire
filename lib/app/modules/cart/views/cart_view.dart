import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import '../../../widgets/screen_widget.dart';
import '../../../../services/auth_service.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    final products = controller.getProducts();

    return ScreenWidget(
      appBar: AppBar(
        title: Text('${AuthService.to.userName} Cart'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              color: Colors.white, // Set container color to purple[300]
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: products[index].imageUrl,
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
                        products[index].name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(products[index].id),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      screen: screen!,
    );
  }
}
