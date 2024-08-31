import 'package:flutter/material.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/app/widgets/product/add_to_cart_button.dart';
import 'package:get_flutter_fire/models/product_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class ProductBottomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final ProductModel product;
  final String label;
  final String totalPrice;
  final String originalPrice;
  final bool disabled;
  final bool isWholesale;

  const ProductBottomButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.totalPrice,
    required this.originalPrice,
    required this.product,
    this.disabled = false,
    this.isWholesale = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: AppTheme.paddingDefault,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    totalPrice,
                    style: AppTheme.fontStyleMedium.copyWith(
                      color: AppTheme.colorRed,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    originalPrice,
                    style: AppTheme.fontStyleSmall.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: AppTheme.greyTextColor,
                    ),
                  ),
                ],
              ),
              const Spacing(size: AppTheme.spacingSmall, isHorizontal: true),
              SizedBox(
                width: 100,
                child: AddToCartButton(
                  product: product,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
