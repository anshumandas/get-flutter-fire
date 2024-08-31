import 'package:flutter/material.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class OrderSummaryWidget extends StatelessWidget {
  final int subTotalPrice;
  final int priceDiscount;
  final int couponDiscount;
  final int totalPrice;
  final String? couponCode;

  const OrderSummaryWidget({
    super.key,
    required this.subTotalPrice,
    required this.priceDiscount,
    required this.couponDiscount,
    required this.totalPrice,
    this.couponCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardDecoration,
      padding: AppTheme.paddingSmall,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal",
                style: AppTheme.fontStyleDefault,
              ),
              Text(
                subTotalPrice.toString(),
                style: AppTheme.fontStyleDefaultBold,
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingTiny),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Discount",
                style: AppTheme.fontStyleDefault,
              ),
              Text(
                priceDiscount.toString(),
                style: AppTheme.fontStyleDefaultBold.copyWith(
                  color: AppTheme.colorMain,
                ),
              ),
            ],
          ),
          if (couponCode != null && couponCode!.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spacingTiny),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Coupon (",
                    style: AppTheme.fontStyleDefault,
                    children: [
                      TextSpan(
                        text: couponCode,
                        style: AppTheme.fontStyleDefaultBold.copyWith(
                          color: AppTheme.colorBlue,
                        ),
                      ),
                      const TextSpan(
                        text: ")",
                        style: AppTheme.fontStyleDefault,
                      ),
                    ],
                  ),
                ),
                Text(
                  "-$couponDiscount",
                  style: AppTheme.fontStyleDefaultBold.copyWith(
                    color: AppTheme.colorMain,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppTheme.spacingTiny),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: AppTheme.fontStyleDefault,
              ),
              Text(
                totalPrice.toString(),
                style: AppTheme.fontStyleDefaultBold.copyWith(
                  color: AppTheme.colorBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
