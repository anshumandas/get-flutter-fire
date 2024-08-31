import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/models/order_model.dart';
import 'package:get_flutter_fire/models/product_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class OrderDetailProductCard extends StatelessWidget {
  final ProductModel product;
  final ProductData productData;

  const OrderDetailProductCard({
    super.key,
    required this.productData,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
      child: Container(
        decoration: AppTheme.cardDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: AppTheme.borderRadius.topLeft,
                bottomLeft: AppTheme.borderRadius.bottomLeft,
              ),
              child: CachedNetworkImage(
                imageUrl: product.images[0],
                height: 152,
                width: 146,
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingExtraSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: AppTheme.fontStyleDefaultBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product.description,
                      style: AppTheme.fontStyleDefault.copyWith(
                        color: AppTheme.greyTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacing(size: AppTheme.spacingSmall),
                    Text(
                      productData.price.toString(),
                      style: AppTheme.fontStyleDefaultBold,
                    ),
                    const Spacing(size: AppTheme.spacingExtraSmall),
                    RichText(
                        text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Quantity: ",
                          style: AppTheme.fontStyleDefault,
                        ),
                        TextSpan(
                            text: productData.quantity.toString(),
                            style: AppTheme.fontStyleDefaultBold),
                      ],
                    )),
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
