import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/app/modules/cart/views/checkout_view.dart';
import 'package:get_flutter_fire/app/modules/cart/views/select_address_view.dart';
import 'package:get_flutter_fire/app/modules/cart/views/select_payment_method_view.dart';
import 'package:get_flutter_fire/app/modules/profile/controllers/address_controller.dart';
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
      if (cartController.pageIndex == 0) return "Proceed To Checkout";
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
          break;
        case 1:
          cartController.changePageIndex(2);
          break;
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
          break;
        default:
          break;
      }
    }

    return Obx(() => DefaultTabController(
          length: 3,
          child: Scaffold(
            body: Column(
              children: [
                const Spacing(size: AppTheme.spacingLarge),
                TabBar(
                  onTap: (index) {
                    if (index <= cartController.pageIndex) {
                      cartController.changePageIndex(index);
                    }
                  },
                  indicator: const BoxDecoration(),
                  labelColor: AppTheme.colorRed,
                  unselectedLabelColor: Colors.grey,
                  tabs: List.generate(3, (index) {
                    return Tab(
                      icon: Icon(
                        index == 0
                            ? Icons.shopping_cart
                            : index == 1
                                ? Icons.location_on
                                : Icons.payment,
                        color: index <= cartController.pageIndex
                            ? AppTheme.colorRed
                            : Colors.grey,
                      ),
                      text: index == 0
                          ? 'Checkout'
                          : index == 1
                              ? 'Address'
                              : 'Payment',
                    );
                  }),
                ),
                Expanded(
                  child: Padding(
                    padding: AppTheme.paddingSmall,
                    child: IndexedStack(
                      index: cartController.pageIndex,
                      children: pages,
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: onBottomButtonPressed,
              label: Text(getButtonLabel()),
              icon: const Icon(Icons.arrow_forward),
              backgroundColor: AppTheme.colorRed,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
        ));
  }
}
