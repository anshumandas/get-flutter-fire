import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/order_controller.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/product_controller.dart';
import 'package:get_flutter_fire/app/widgets/cart/order_detail_card.dart';
import 'package:get_flutter_fire/app/widgets/cart/order_summary_widget.dart';
import 'package:get_flutter_fire/app/widgets/common/overlay_loader.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/app/widgets/orders/order_status_indicator.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String orderID = Get.arguments['id'];
    final OrderController orderController = Get.find<OrderController>();
    final ProductController productController = Get.find<ProductController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingDefault),
        child: SingleChildScrollView(
          child: Obx(() {
            if (orderController.isLoading.value) {
              return const LoadingWidget();
            }

            final order = orderController.getOrderByID(orderID);
            final coupon = orderController.orders
                .firstWhere((o) => o.id == orderID)
                .couponID;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacing(size: AppTheme.spacingLarge),
                OrderStatusIndicator(currentStatus: order.currentStatus),
                const Spacing(size: AppTheme.spacingSmall),
                Center(
                  child: Text(
                    "Order ${order.currentStatus.name.capitalizeFirst}",
                    style: AppTheme.fontStyleLarge.copyWith(
                      color: AppTheme.colorMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingDefault),
                const Text(
                  'Item Information',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.colorMain,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSmall),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: order.products.length,
                  itemBuilder: (context, index) {
                    final item = order.products[index];
                    final product = productController.getProductByID(item.id);

                    return OrderDetailProductCard(
                      product: product,
                      productData: order.products[index],
                    );
                  },
                ),
                const SizedBox(height: AppTheme.spacingDefault),
                const Text(
                  'Payment Information',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.colorMain,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSmall),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: AppTheme.colorMain,
                    ),
                  ),
                  padding: AppTheme.paddingSmall,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (order.paymentMethod == "cash") ? 'Cash' : 'Paid',
                            style: AppTheme.fontStyleDefaultBold.copyWith(
                              color: AppTheme.colorBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            (order.paymentMethod == "cash")
                                ? 'Cash on Delivery'
                                : 'Online Payment',
                            style: AppTheme.fontStyleDefault,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.spacingDefault),
                const Text(
                  'Delivery Address',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.colorMain,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSmall),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: AppTheme.colorMain,
                    ),
                  ),
                  padding: AppTheme.paddingSmall,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${order.address.name} (${order.address.phoneNumber})",
                          style: AppTheme.fontStyleDefaultBold,
                        ),
                        const Spacing(size: AppTheme.spacingSmall),
                        Text(
                          "${order.address.line1}\n${order.address.line2}",
                          style: AppTheme.fontStyleDefault,
                        ),
                        const Spacing(size: AppTheme.spacingTiny),
                        Text(
                          "${order.address.district}, ${order.address.city}",
                          style: AppTheme.fontStyleDefault,
                        ),
                        const Spacing(size: AppTheme.spacingSmall),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingDefault),
                const Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.colorMain,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSmall),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.colorMain,
                      ),
                      borderRadius: AppTheme.borderRadius),
                  child: OrderSummaryWidget(
                    couponDiscount: order.couponDiscount,
                    couponCode: coupon,
                    priceDiscount: 0,
                    subTotalPrice: order.totalPrice,
                    totalPrice: order.totalPrice,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLarge),
              ],
            );
          }),
        ),
      ),
    );
  }
}
