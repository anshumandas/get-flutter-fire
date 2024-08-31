import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/app/modules/home/controllers/home_product_controller.dart';
import 'package:get_flutter_fire/app/modules/home/view/product_bottom.dart';
import 'package:get_flutter_fire/app/widgets/common/overlay_loader.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/models/cart_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productID;

  const ProductDetailScreen({super.key, required this.productID});

  @override
  Widget build(BuildContext context) {
    final HomeProductController productController = Get.put(
      HomeProductController(productID),
    ); // Pass productID as a named argument
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      body: Obx(() {
        if (productController.isLoading.value) {
          return const LoadingWidget();
        }

        final product = productController.product.value;
        if (product == null) {
          return const Center(
            child: Text(
              'Product not found',
              style: AppTheme.fontStyleDefaultBold,
            ),
          );
        }

        // final isInCart = cartController.isProductInCart(product.id);

        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const Spacing(size: AppTheme.spacingExtraSmall),
                  CarouselSlider.builder(
                    itemCount: product.images.length,
                    itemBuilder: (context, index, pageViewIndex) {
                      var imageUrl = product.images[index];
                      return CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                    options: CarouselOptions(
                      height: 320,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      enableInfiniteScroll: product.images.length != 1,
                      onPageChanged: (index, reason) {
                        productController.onPageChanged(index);
                      },
                    ),
                  ),
                  const Spacing(size: 300),
                ],
              ),
            ),
            Positioned(
              top: 35,
              left: 16,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: AppTheme.colorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_sharp,
                      size: 14, color: AppTheme.greyTextColor),
                ),
              ),
            ),
            Positioned(
              top: 35,
              right: 16,
              child: InkWell(
                onTap: () {
                  // TODO: Add share product functionality
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: AppTheme.colorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  ),
                  child: const Icon(Icons.share,
                      size: 14, color: AppTheme.greyTextColor),
                ),
              ),
            ),
            Positioned(
              top: 300,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
                child: Container(
                  color: AppTheme.colorWhite,
                  padding: AppTheme.paddingDefault,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: AppTheme.paddingTiny,
                        decoration: BoxDecoration(
                          borderRadius: AppTheme.borderRadiusSmall,
                          border: Border.all(
                            color: AppTheme.colorRed,
                          ),
                        ),
                        child: Text(
                          'RS ${product.unitPrice}',
                          style: AppTheme.fontStyleDefaultBold.copyWith(
                            color: AppTheme.colorRed,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingSmall),
                      Row(
                        children: [
                          Text(
                            product.name,
                            style: AppTheme.fontStyleDefault,
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacingTiny),
                      Text(
                        'Dimension: ${product.unitWeight} gm',
                        style: AppTheme.fontStyleDefault,
                      ),
                      const SizedBox(height: AppTheme.spacingSmall),
                      const Text(
                        'Product Description',
                        style: AppTheme.fontStyleDefaultBold,
                      ),
                      const SizedBox(height: AppTheme.spacingTiny),
                      Text(
                        product.description,
                        style: AppTheme.fontStyleDefault,
                      ),
                      const SizedBox(height: AppTheme.spacingSemiMedium),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 340,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.greyTextColor,
                    borderRadius: AppTheme.borderRadiusSmall,
                  ),
                  child: DotsIndicator(
                    dotsCount: product.images.length,
                    position: productController.currentCarouselIndex.toInt(),
                    decorator: DotsDecorator(
                      color: AppTheme.colorDisabled,
                      activeColor: AppTheme.colorBlack,
                      activeSize: const Size(22.0, 9.0),
                      activeShape: AppTheme.rrShape,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        final product = productController.product.value;
        if (product == null) return const SizedBox.shrink();

        final isInCart = cartController.isProductInCart(product.id);
        return ProductBottomButton(
          product: product,
          isWholesale: true,
          label: isInCart ? 'Go to Cart' : 'Add to Cart',
          totalPrice: product.unitPrice.toString(),
          originalPrice: product.unitPrice.toString(),
          onPressed: () {
            if (isInCart) {
              Get.toNamed('/cart');
            } else {
              cartController.addItem(product as CartItem);
            }
          },
        );
      }),
    );
  }
}
