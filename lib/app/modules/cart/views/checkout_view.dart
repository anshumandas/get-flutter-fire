import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/app/modules/home/controllers/home_controller.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final homeController = Get.find<HomeController>();
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Total Items", style: AppTheme.fontStyleDefault),
                Text(" (${cartController.cart.itemCount})",
                    style: AppTheme.fontStyleDefaultBold),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      cartController.clearCart();
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: AppTheme.colorRed,
                    )),
              ],
            ),
            const SizedBox(height: AppTheme.spacingTiny),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartController.cart.items.length,
              itemBuilder: (context, index) {
                final item = cartController.cart.items[index];
                final product = homeController.products.firstWhere(
                  (element) => element.id == item.id,
                );
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
                  child: Container(
                    decoration: AppTheme.cardDecoration,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: AppTheme.borderRadius.topLeft,
                              bottomLeft: AppTheme.borderRadius.bottomLeft,
                            ),
                            child: Image.network(
                              product.images.first,
                              height: 152,
                              width: 146,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(
                                AppTheme.spacingExtraSmall),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: AppTheme.fontStyleDefault,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacing(size: AppTheme.spacingTiny),
                                Text(
                                  "Rs.${item.price}",
                                  style: AppTheme.fontStyleDefaultBold,
                                ),
                                const Spacing(size: AppTheme.spacingTiny),
                                Container(
                                  width: double.infinity,
                                  decoration: AppTheme.cardDecoration.copyWith(
                                    border: Border.all(
                                      color: AppTheme.colorBlue,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () => cartController
                                            .decrementQuantity(item),
                                        child: Container(
                                          padding: AppTheme.paddingTiny,
                                          child: const Center(
                                            child: Icon(Icons.remove),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: AppTheme.paddingTiny,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                color: AppTheme.colorBlue,
                                              ),
                                              right: BorderSide(
                                                color: AppTheme.colorBlue,
                                              ),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              item.quantity.toString(),
                                              style: AppTheme.fontStyleDefault,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          cartController
                                              .incrementQuantity(item);
                                        },
                                        child: Container(
                                          padding: AppTheme.paddingTiny,
                                          child: const Center(
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacing(size: AppTheme.spacingTiny),
                                // SecondaryButton(
                                //   label: context.loc.removeItem,
                                //   onPressed: () => _removeItem(item),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
