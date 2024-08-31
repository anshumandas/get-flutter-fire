import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/home/view/product_card.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/app/modules/home/controllers/category_filter_controller.dart';

class ProductsListingScreen extends StatefulWidget {
  const ProductsListingScreen({super.key});

  @override
  State<ProductsListingScreen> createState() => _ProductsListingScreenState();
}

class _ProductsListingScreenState extends State<ProductsListingScreen> {
  String? query;
  String? category;

  @override
  void initState() {
    super.initState();

    query = Get.arguments['query'];
    category = Get.arguments['category'];

    if (kDebugMode) {
      print("The category ID is $category");
    }

    final CategoryFilterController productsController =
        Get.put(CategoryFilterController());

    if (category != null) {
      productsController.fetchProductsByCategory(category!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final CategoryFilterController productsController =
        Get.find<CategoryFilterController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          style: TextStyle(
            color: AppTheme.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: AppTheme.fontSizeLarge,
          ),
        ),
        backgroundColor: AppTheme.colorWhite,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        final products = productsController.products;

        if (products.isEmpty) {
          return const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: AppTheme.paddingSmall,
              child: Text('No products found', style: AppTheme.fontStyleMedium),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: AppTheme.paddingSmall,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      query != null
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppTheme.spacingSmall),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${products.length}",
                                      style: AppTheme.fontStyleDefaultBold,
                                    ),
                                    TextSpan(
                                        text: " results for ",
                                        style:
                                            AppTheme.fontStyleDefault.copyWith(
                                          color: AppTheme.greyTextColor,
                                        )),
                                    TextSpan(
                                      text: '"$query"',
                                      style: AppTheme.fontStyleDefaultBold
                                          .copyWith(
                                        color: AppTheme.colorBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppTheme.spacingSmall),
                              child: Text(
                                "${products.length} results",
                                style: AppTheme.fontStyleDefault,
                              ),
                            ),
                    ],
                  ),
                  const Spacing(size: AppTheme.spacingSmall),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(product: product);
                    },
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
