import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/app/modules/cart/views/checkout_view.dart';
import 'package:get_flutter_fire/app/modules/cart/views/select_address_view.dart';
import 'package:get_flutter_fire/app/modules/cart/views/select_payment_method_view.dart';
import 'package:get_flutter_fire/app/modules/profile/controllers/address_controller.dart';
import 'package:get_flutter_fire/app/widgets/cart/cart_bottom_button.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/enums/enums.dart';
import 'package:get_flutter_fire/models/address_model.dart';
import 'package:get_flutter_fire/models/order_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/utils/get_uuid.dart';

class CartRootView extends StatelessWidget {
  const CartRootView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const CheckoutView(),
      const SelectAddressView(),
      const SelectPaymentMethodView(),
    ];

    final cartController = Get.find<CartController>();
    String getButtonLabel() {
      if (cartController.pageIndex == 0) return "Proceeed To Checkout";
      if (cartController.pageIndex == 1) return "Select Address";
      if (cartController.pageIndex == 2) return "Confirm Order";
      return '';
    }

    void onBottomButtonPressed() async {
      switch (cartController.pageIndex) {
        case 0:
          if (cartController.cart.itemCount == 0) {
            Get.snackbar(
              'Cart Empty',
              'Please add some items to your cart',
            );
            return;
          }
          if (cartController.selectedAddress.isEmpty) {
            cartController.selectAddress(
                Get.find<AuthController>().user!.defaultAddressID);
          }
          cartController.changePageIndex(1);
        case 1:
          cartController.changePageIndex(2);
        case 2:
          final addressController = Get.find<AddressController>();
          final authController = Get.find<AuthController>();

          String orderID = getUUID();
          AddressModel address = addressController.addresses.firstWhere(
              (element) => element.id == cartController.selectedAddress);
          List<ProductData> products = cartController.cart.items
              .map((e) => ProductData(
                    id: e.id,
                    quantity: e.quantity,
                    price: e.price,
                  ))
              .toList();
          OrderModel order = OrderModel(
            id: orderID,
            address: address,
            totalPrice: cartController.totalPrice,
            couponDiscount: 0,
            couponID: '',
            createdAt: DateTime.now(),
            currentStatus: OrderStatus.placed,
            paymentMethod: cartController.selectedPaymentMethod,
            statusUpdates: [
              OrderStatusUpdate(
                  status: OrderStatus.placed, timestamp: DateTime.now())
            ],
            totalWeight: 0,
            userID: authController.user!.id,
            products: products,
          );
          cartController.placeOrder(order);
        default:
          break;
      }
    }

    return Obx(() => Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: AppTheme.paddingSmall,
              child: Column(
                children: [
                  const Spacing(size: AppTheme.spacingLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => cartController.changePageIndex(0),
                          child: Column(
                            children: [
                              Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: AppTheme.borderRadius,
                                  color: cartController.pageIndex >= 0
                                      ? AppTheme.colorMain
                                      : AppTheme.backgroundColor,
                                ),
                              ),
                              const Spacing(size: AppTheme.spacingTiny),
                              const Text("Checkout"),
                            ],
                          ),
                        ),
                      ),
                      const Spacing(
                          size: AppTheme.spacingTiny, isHorizontal: true),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => cartController.changePageIndex(1),
                          child: Column(
                            children: [
                              Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: AppTheme.borderRadius,
                                  color: cartController.pageIndex >= 1
                                      ? AppTheme.colorMain
                                      : AppTheme.backgroundColor,
                                ),
                              ),
                              const Spacing(size: AppTheme.spacingTiny),
                              const Text("Address"),
                            ],
                          ),
                        ),
                      ),
                      const Spacing(
                          size: AppTheme.spacingTiny, isHorizontal: true),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => cartController.changePageIndex(2),
                          child: Column(
                            children: [
                              Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: AppTheme.borderRadius,
                                  color: cartController.pageIndex == 2
                                      ? AppTheme.colorMain
                                      : AppTheme.backgroundColor,
                                ),
                              ),
                              const Spacing(size: AppTheme.spacingTiny),
                              const Text("Payment"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacing(size: AppTheme.spacingDefault),
                  if (cartController.pageIndex < 3)
                    pages[cartController.pageIndex],
                ],
              ),
            ),
          ),
          bottomNavigationBar: CartBottomButton(
            input: 'Rs. ${cartController.totalPrice}',
            label: getButtonLabel(),
            onPressed: onBottomButtonPressed,
          ),
        ));
  }
}
