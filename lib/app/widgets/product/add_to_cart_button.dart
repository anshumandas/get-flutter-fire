import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/models/cart_model.dart';
import 'package:get_flutter_fire/models/product_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class AddToCartButton extends StatelessWidget {
  final ProductModel product;
  final bool disableButton;

  const AddToCartButton(
      {super.key, required this.product, this.disableButton = false});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Obx(() {
      final isInCart = cartController.isProductInCart(product.id);
      return Material(
        borderRadius: AppTheme.borderRadius,
        color: disableButton
            ? AppTheme.backgroundColor
            : isInCart
                ? Colors.white
                : AppTheme.colorMain,
        child: InkWell(
          onTap: () {
            if (!disableButton) {
              if (isInCart) {
                Get.toNamed(Routes.CART);
              } else {
                cartController.addItem(CartItem(
                  id: product.id,
                  quantity: 1,
                  price: product.unitPrice,
                ));
              }
            }
          },
          child: Container(
            height: AppTheme.spacingExtraLarge,
            decoration: BoxDecoration(
              borderRadius: AppTheme.borderRadius,
              border: isInCart ? Border.all(color: AppTheme.colorMain) : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isInCart ? Icons.shopping_cart : Icons.add,
                  color: isInCart ? AppTheme.colorMain : AppTheme.colorWhite,
                ),
                const Spacing(size: AppTheme.spacingTiny, isHorizontal: true),
                Text(
                  isInCart ? 'Go to Cart' : 'Add to Cart',
                  textAlign: TextAlign.center,
                  style: AppTheme.fontStyleHeadingDefault.copyWith(
                    color: isInCart ? AppTheme.colorMain : AppTheme.colorWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
