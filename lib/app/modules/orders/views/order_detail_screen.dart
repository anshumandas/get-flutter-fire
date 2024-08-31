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
        padding: AppTheme.paddingSmall,
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
                    style: AppTheme.fontStyleLarge,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingDefault),
                const Text(
                  'Item Information',
                  style: AppTheme.fontStyleDefaultBold,
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
                const SizedBox(height: AppTheme.spacingTiny),
                const Text(
                  'Payment Information',
                  style: AppTheme.fontStyleDefaultBold,
                ),
                const SizedBox(height: AppTheme.spacingSmall),
                Container(
                  decoration: AppTheme.cardDecoration,
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
                  style: AppTheme.fontStyleDefaultBold,
                ),
                const SizedBox(height: AppTheme.spacingSmall),
                Container(
                  decoration: AppTheme.cardDecoration,
                  padding: AppTheme.paddingSmall,
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
                      Row(
                        children: [
                          const Text(
                            "Full Name: ",
                            style: AppTheme.fontStyleDefault,
                          ),
                          Text(
                            order.address.name,
                            style: AppTheme.fontStyleDefaultBold,
                          ),
                        ],
                      ),
                      const Spacing(size: AppTheme.spacingTiny),
                      Row(
                        children: [
                          const Text(
                            "Phone Number: ",
                            style: AppTheme.fontStyleDefault,
                          ),
                          Text(
                            order.address.phoneNumber,
                            style: AppTheme.fontStyleDefaultBold,
                          ),
                        ],
                      ),
                      const Spacing(size: AppTheme.spacingTiny),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.spacingDefault),
                const Text(
                  'Order Summary',
                  style: AppTheme.fontStyleDefaultBold,
                ),
                const SizedBox(height: AppTheme.spacingSmall),
                OrderSummaryWidget(
                  couponDiscount: order.couponDiscount,
                  couponCode: coupon,
                  priceDiscount: 0,
                  subTotalPrice: order.totalPrice,
                  totalPrice: order.totalPrice,
                ),
                const SizedBox(height: AppTheme.spacingDefault),
              ],
            );
          }),
        ),
      ),
      // bottomNavigationBar: Obx(() {
      //   return BottomButton(
      //     onPressed: () => orderController.createPDF(
      //         order: orderController.currentOrder.value!,
      //         user: Get.find<AuthProvider>().user!,
      //         products: productController.products),
      //     label: 'Download Invoice',
      //     disabled: false,
      //   );
      // }),
    );
  }
}
