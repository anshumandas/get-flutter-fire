// ignore_for_file: inference_failure_on_function_invocation

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/app/modules/products/views/products_descriptions_view.dart';
import 'package:get_flutter_fire/app/widgets/drop_down_button.dart';
import 'package:get_flutter_fire/app/widgets/drop_down_checklist.dart';
import 'package:get_flutter_fire/app/widgets/product_card.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return GetBuilder<ProductsController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async {
          ctrl.fetchProducts();
        },
        child: Scaffold(
            body: Column(
          children: [
            SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.categories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ctrl.filterByCategory(
                              ctrl.categories[index].name ?? '');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Chip(
                            label: Text(ctrl.categories[index].name ?? ''),
                          ),
                        ),
                      );
                    })),
            Row(
              children: [
                Flexible(
                  child: DropDownBtn(
                      items: ['Rs: low to high', 'Rs: high to low'],
                      selectedItemsText: 'Sort',
                      onSelected: (selected) {
                        print(selected);
                        ctrl.sortByPrice(
                            ascending:
                                selected == 'Rs: low to high' ? true : false);
                      }),
                ),
                Flexible(
                    child: DropDownChecklist(
                  items: ['Nike', 'Zara', 'H&M', 'Samsung', 'Bata'],
                  onSelectionChanged: (selectedItems) {
                    ctrl.filterByBrand(selectedItems);
                  },
                ))
              ],
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemCount: ctrl.productsInUI.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      name: ctrl.productsInUI[index].name ?? 'Name',
                      imageUrl: ctrl.productsInUI[index].image ?? 'url',
                      price: ctrl.productsInUI[index].price ?? 200,
                      offerTag: '20% off',
                      quantity: ctrl.productQuantities[
                          ctrl.productsInUI[index]]!, // Show product quantity
                      onIncrease: () {
                        ctrl.incrementProductQuantity(ctrl.productsInUI[index]);
                        cartController.addToCart(ctrl.productsInUI[index], 1);
                      },
                      onDecrease: () {
                        if (ctrl.productQuantities[ctrl.productsInUI[index]]! >
                            0) {
                          ctrl.decrementProductQuantity(
                              ctrl.productsInUI[index]);
                          cartController
                              .removeFromCart(ctrl.productsInUI[index]);
                        }
                      },
                      productTap: () {
                        Get.to(
                          ProductsDescriptionsView(
                              product: ctrl.productsInUI[index]),
                        );
                      },
                    );
                  }),
            )
          ],
        )),
      );
    });
  }
}
