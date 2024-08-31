import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/home/controllers/home_controller.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
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
                Hero(
                  tag: 'searchField',
                  child: InkWell(
                    onTap: () {
                      // context.push(Routes.search);
                      Get.toNamed(Routes.SEARCH);
                    },
                    child: Padding(
                      padding: AppTheme.paddingDefault,
                      child: Container(
                        padding: AppTheme.paddingTiny,
                        decoration: BoxDecoration(
                          color: AppTheme.greyTextColor,
                          borderRadius: AppTheme.borderRadius,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search,
                              color: AppTheme.colorWhite,
                            ),
                            const Spacing(
                                size: AppTheme.spacingTiny, isHorizontal: true),
                            Text(
                              "search",
                              style: AppTheme.fontStyleDefault.copyWith(
                                color: AppTheme.colorWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _buildCarousel(homeController.banners),
                _buildCategories(homeController.categories),
                _buildProducts(
                    homeController.products, MediaQuery.of(context).size),
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
              SecondaryButton(
                label: "See All",
                onPressed: () {
                  Get.toNamed(Routes.CATEGORIES);
                },
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

  Widget _buildProducts(List<ProductModel> products, Size size) {
    return Padding(
      padding: AppTheme.paddingDefault,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Products",
                style: AppTheme.fontStyleLarge.copyWith(
                  color: AppTheme.colorBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SecondaryButton(
                label: "See All",
                onPressed: () {
                  Get.toNamed(
                    Routes.PRODUCTS_LISTING,
                    arguments: {'category': 'ALL'},
                  );
                },
              ),
            ],
          ),
          const Spacing(size: AppTheme.fontSizeDefault),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (products.length / 2).ceil(),
            itemBuilder: (context, index) {
              final productLeft = products[index * 2];
              final productRight = (index * 2 + 1 < products.length)
                  ? products[index * 2 + 1]
                  : null;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildProductItem(productLeft),
                  if (productRight != null) _buildProductItem(productRight),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(ProductModel product) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/product/${product.id}');
      },
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
                  fit: BoxFit.cover,
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
            ),
            const Spacing(size: AppTheme.spacingTiny),
            AddToCartButton(product: product),
            const Spacing(size: AppTheme.spacingMedium),
          ],
        ),
      ),
    );
  }
}
