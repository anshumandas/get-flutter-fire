import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/order_controller.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/product_controller.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/widgets/cart/order_detail_card.dart';
import 'package:get_flutter_fire/app/widgets/cart/order_summary_widget.dart';
import 'package:get_flutter_fire/app/widgets/common/custom_bottom_button.dart';
import 'package:get_flutter_fire/app/widgets/common/overlay_loader.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class OrderConfirmedScreen extends StatelessWidget {
  const OrderConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String id = Get.arguments ?? '';
    final OrderController orderController = Get.find<OrderController>();
    final ProductController productController = Get.find<ProductController>();

    return FutureBuilder<void>(
      future: orderController.loadOrder(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error loading order: ${snapshot.error}'),
            ),
          );
        }

        final order = orderController.currentOrder.value;

        if (order == null) {
          return const Scaffold(
            body: Center(
              child: Text('Order not found', style: AppTheme.fontStyleLarge),
            ),
          );
        }

        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: AppTheme.paddingSmall,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Order Confirmed",
                        style: AppTheme.fontStyleLarge),
                    const Spacing(size: AppTheme.spacingDefault),
                    Text("${order.createdAt}: #${order.id}",
                        style: AppTheme.fontStyleMedium),
                    const Spacing(size: AppTheme.spacingSmall),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: order.products.length,
                      itemBuilder: (context, index) {
                        final item = order.products[index];
                        final product =
                            productController.getProductByID(item.id);

                        return OrderDetailProductCard(
                          product: product,
                          productData: item,
                        );
                      },
                    ),
                    OrderSummaryWidget(
                      couponDiscount: order.couponDiscount,
                      couponCode: "None",
                      priceDiscount: 0,
                      subTotalPrice: 0,
                      totalPrice: order.totalPrice,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: AppTheme.paddingDefault,
              child: CustomBottomButton(
                label: "Continue Shopping",
                onPressed: () {
                  Get.offAllNamed(Routes.ROOT);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
