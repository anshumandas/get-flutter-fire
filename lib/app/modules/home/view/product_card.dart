import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/app/widgets/product/add_to_cart_button.dart';
import 'package:get_flutter_fire/models/product_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final bool showAddToCart;
  const ProductCard(
      {super.key, required this.product, this.showAddToCart = true});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/product/${widget.product.id}');
      },
      child: Container(
        width: 160,
        height: (widget.showAddToCart) ? 332 : 260,
        decoration: BoxDecoration(
          color: AppTheme.colorWhite,
          borderRadius: AppTheme.borderRadius,
          border: AppTheme.cardBorder,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.vertical(top: AppTheme.borderRadius.topLeft),
              child: CachedNetworkImage(
                imageUrl: widget.product.images[0],
                fit: BoxFit.fitHeight,
                height: 80,
                width: double.infinity,
              ),
            ),
            Expanded(
              child: Padding(
                padding: AppTheme.paddingSmall,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.fontStyleDefault,
                    ),
                    const Spacing(size: AppTheme.spacingTiny),
                    Text(
                      widget.product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.fontStyleDefault.copyWith(
                        color: AppTheme.greyTextColor,
                      ),
                    ),
                    const Spacing(size: AppTheme.spacingSmall),
                    Text(
                      widget.product.unitPrice.toString(),
                      style: AppTheme.fontStyleDefaultBold,
                    ),
                    if (widget.showAddToCart) ...[
                      const Spacing(size: AppTheme.spacingTiny),
                      const Spacer(),
                      AddToCartButton(
                        product: widget.product,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
