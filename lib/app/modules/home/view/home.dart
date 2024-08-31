import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/home/controllers/home_controller.dart';
import 'package:get_flutter_fire/app/widgets/common/overlay_loader.dart';
import 'package:get_flutter_fire/app/widgets/common/secondary_button.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/app/widgets/product/add_to_cart_button.dart';
import 'package:get_flutter_fire/models/banner_model.dart';
import 'package:get_flutter_fire/models/category_model.dart';
import 'package:get_flutter_fire/models/product_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const LoadingWidget();
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Spacing(size: AppTheme.spacingMedium),
                _buildCarousel(homeController.banners),
                _buildSheruProducts(
                    homeController.products
                        .where((product) => product.isSheruSpecial)
                        .toList(),
                    MediaQuery.of(context).size,
                    'Sheru Special'),
                _buildCategories(homeController.categories),
                _buildProducts(
                    homeController.products
                        .where((product) => product.isApproved)
                        .toList(),
                    MediaQuery.of(context).size,
                    'All Products'),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildCarousel(List<BannerModel> banners) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
      ),
      items: banners.map((banner) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(banner.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildCategories(List<CategoryModel> categories) {
    return Padding(
      padding: AppTheme.paddingDefault,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: AppTheme.fontStyleLarge.copyWith(
                  color: AppTheme.colorBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacing(size: AppTheme.fontSizeDefault),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Column(
                  children: [
                    Container(
                      width: 70.0,
                      height: 70.0,
                      margin: const EdgeInsets.only(right: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(category.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      category.name,
                      style: AppTheme.fontStyleDefault.copyWith(
                        color: AppTheme.colorBlack,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSheruProducts(
      List<ProductModel> products, Size size, String title) {
    return Padding(
      padding: AppTheme.paddingDefault,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.fontStyleLarge.copyWith(
              color: AppTheme.colorBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacing(size: AppTheme.fontSizeDefault),
          SizedBox(
            height: 322,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return Padding(
                  padding: const EdgeInsets.only(right: AppTheme.spacingSmall),
                  child: SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(product.images.first),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const Spacing(size: AppTheme.spacingTiny),
                        Text(
                          product.name,
                          style: AppTheme.fontStyleHeadingDefault.copyWith(
                            color: AppTheme.colorBlack,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacing(size: AppTheme.spacingTiny),
                        Text(
                          product.description,
                          style: AppTheme.fontStyleDefault.copyWith(
                            color: AppTheme.greyTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacing(size: AppTheme.spacingTiny),
                        Text(
                          "Rs. ${product.unitPrice}",
                          style: AppTheme.fontStyleDefault.copyWith(
                            color: AppTheme.colorBlack,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacing(size: AppTheme.spacingTiny),
                        AddToCartButton(product: product),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProducts(List<ProductModel> products, Size size, String title) {
    return Padding(
      padding: AppTheme.paddingDefault,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTheme.fontStyleLarge.copyWith(
                  color: AppTheme.colorBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SecondaryButton(
              //   label: "See All",
              //   onPressed: () {},
              // ),
            ],
          ),
          const Spacing(size: AppTheme.fontSizeDefault),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length ~/ 2,
            itemBuilder: (context, index) {
              final productLeft = products[index * 2];
              final productRight = products[index * 2 + 1];

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(productLeft.images.first),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const Spacing(size: AppTheme.spacingTiny),
                        Text(
                          productLeft.name,
                          style: AppTheme.fontStyleHeadingDefault.copyWith(
                            color: AppTheme.colorBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacing(size: AppTheme.spacingTiny),
                        Text(
                          productLeft.description,
                          style: AppTheme.fontStyleDefault.copyWith(
                            color: AppTheme.greyTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacing(size: AppTheme.spacingTiny),
                        Text(
                          "Rs. ${productLeft.unitPrice}",
                          style: AppTheme.fontStyleDefault.copyWith(
                            color: AppTheme.colorBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacing(size: AppTheme.spacingTiny),
                        AddToCartButton(product: productLeft),
                        const Spacing(size: AppTheme.spacingMedium),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(productRight.images.first),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Spacing(size: AppTheme.spacingTiny),
                        Text(
                          productRight.name,
                          style: AppTheme.fontStyleHeadingDefault.copyWith(
                            color: AppTheme.colorBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacing(size: AppTheme.spacingTiny),
                        Text(
                          productRight.description,
                          style: AppTheme.fontStyleDefault.copyWith(
                            color: AppTheme.greyTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacing(size: AppTheme.spacingTiny),
                        Text(
                          "Rs. ${productRight.unitPrice}",
                          style: AppTheme.fontStyleDefault.copyWith(
                            color: AppTheme.colorBlack,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacing(size: AppTheme.spacingTiny),
                        AddToCartButton(product: productRight),
                        const Spacing(size: AppTheme.spacingMedium),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          if (products.length % 2 != 0)
            SizedBox(
              width: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(products.last.images.first),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const Spacing(size: AppTheme.spacingTiny),
                  Text(
                    products.last.name,
                    style: AppTheme.fontStyleHeadingDefault.copyWith(
                      color: AppTheme.colorBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacing(size: AppTheme.spacingTiny),
                  Text(
                    products.last.description,
                    style: AppTheme.fontStyleDefault.copyWith(
                      color: AppTheme.greyTextColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacing(size: AppTheme.spacingTiny),
                  Text(
                    "Rs. ${products.last.unitPrice}",
                    style: AppTheme.fontStyleDefault.copyWith(
                      color: AppTheme.colorBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacing(size: AppTheme.spacingTiny),
                  AddToCartButton(product: products.last),
                  const Spacing(size: AppTheme.spacingMedium),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOffers(HomeController homeController) {
    return Padding(
      padding: AppTheme.paddingDefault,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Offers For You",
                style: AppTheme.fontStyleLarge.copyWith(
                  color: AppTheme.colorBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SecondaryButton(
                label: "See All",
                onPressed: () {},
              ),
            ],
          ),
          const Spacing(size: AppTheme.fontSizeDefault),
          Obx(() {
            // Check if offers list is empty
            if (homeController.offers.isEmpty) {
              return Text(
                "No offers available at the moment.",
                style: AppTheme.fontStyleDefault.copyWith(
                  color: AppTheme.colorBlack,
                ),
              );
            }

            return CarouselSlider.builder(
              itemCount: homeController.offers.length,
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                aspectRatio: 16 / 9,
                onPageChanged: (index, reason) {
                  homeController.onPageChanged(index, reason);
                },
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final offer = homeController.offers[index];
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150.0,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(offer.imageUrl),
                          fit: BoxFit.fill,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Flexible(
                      child: Text(
                        offer.title,
                        style: AppTheme.fontStyleDefault.copyWith(
                          color: AppTheme.colorBlack,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
            );
          }),
          const SizedBox(height: 10),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: homeController.offers.map((offer) {
                int index = homeController.offers.indexOf(offer);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.currentCarouselIndex.value == index
                        ? AppTheme.colorMain
                        : Colors.grey,
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }
}
