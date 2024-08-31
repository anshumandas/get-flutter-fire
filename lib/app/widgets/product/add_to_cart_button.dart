import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/modules/profile/controllers/address_controller.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/widgets/common/show_toast.dart';
import 'package:get_flutter_fire/models/cart_model.dart';
import 'package:get_flutter_fire/models/product_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/enums/enums.dart'; // Import for UserType

class AddToCartButton extends StatelessWidget {
  final ProductModel product;
  final bool disableButton;

  const AddToCartButton({
    super.key,
    required this.product,
    this.disableButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    final AddressController addressController = Get.put(AddressController());
    final AuthController authController = Get.find<AuthController>();

    return Obx(() {
      final isInCart = cartController.isProductInCart(product.id);
      return Material(
        borderRadius: AppTheme.borderRadius,
        color: disableButton
            ? AppTheme.backgroundColor
            : isInCart
                ? Colors.white
                : const Color.fromARGB(255, 237, 0, 0),
        child: GestureDetector(
          onTap: () async {
            if (!disableButton) {
              if (authController.user!.userType == UserType.guest) {
                showToast('Please log in or register to add products to cart.');
                Get.toNamed(Routes.WELCOME);
                return;
              }

              if (isInCart) {
                if (addressController.addresses.isEmpty) {
                  await addressController.fetchAddresses();
                }

                if (addressController.addresses.isEmpty) {
                  // No address found, redirect to Manage Address page
                  Get.snackbar('Info', 'Please add an address to proceed.');
                  Get.offAllNamed(Routes.MANAGE_ADDRESS);
                } else {
                  // User has at least one address, go to cart
                  Get.toNamed(Routes.CART);
                }
              } else {
                // Add product to cart
                cartController.addItem(CartItem(
                  id: product.id,
                  quantity: 1,
                  price: product.unitPrice,
                ));
              }
            }
          },
          child: Material(
            borderRadius: AppTheme.borderRadius,
            color: disableButton
                ? AppTheme.backgroundColor
                : isInCart
                    ? Colors.white
                    : AppTheme.colorRed,
            child: Container(
              height: AppTheme.spacingExtraLarge,
              decoration: BoxDecoration(
                borderRadius: AppTheme.borderRadius,
                border: isInCart ? Border.all(color: AppTheme.colorRed) : null,
              ),
              child: Center(
                child: Text(
                  isInCart ? 'Go to cart' : 'Add to cart',
                  textAlign: TextAlign.center,
                  style: AppTheme.fontStyleHeadingDefault.copyWith(
                    color: isInCart ? AppTheme.colorRed : AppTheme.colorWhite,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
