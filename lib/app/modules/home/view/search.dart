import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/home/controllers/category_filter_controller.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/widgets/common/secondary_button.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/models/product_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Timer? _typingTimer;
  List<ProductModel> _searchResults = [];
  String _query = "";

  final CategoryFilterController productsController =
      Get.put(CategoryFilterController());

  void _onChange(String text) {
    if (_typingTimer?.isActive ?? false) {
      _typingTimer?.cancel();
    }

    _typingTimer = Timer(const Duration(milliseconds: 500), () {
      if (text.isNotEmpty) {
        setState(() {
          _query = text;
        });
        _searchProducts(text);
      } else {
        setState(() {
          _searchResults = [];
          _query = "";
        });
      }
    });
  }

  void _searchProducts(String query) {
    setState(() {
      _searchResults = productsController.searchProducts(query);
    });
  }

  void _clearSearchHistory() {
    productsController.clearSearchHistory();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: AppTheme.paddingSmall,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppTheme.greyTextColor),
                      onPressed: () => Get.back(),
                    ),
                    const Spacing(
                        size: AppTheme.spacingTiny, isHorizontal: true),
                    Expanded(
                      child: Hero(
                        tag: 'searchField',
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: const TextStyle(
                              color: AppTheme.greyTextColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: AppTheme.borderRadius,
                              borderSide: const BorderSide(
                                color: AppTheme.greyTextColor,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 12.0),
                          ),
                          onChanged: _onChange,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacing(size: AppTheme.spacingSmall),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    var product = _searchResults[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: AppTheme.spacingTiny,
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CachedNetworkImage(
                          imageUrl: product.images[0],
                          height: 24,
                          width: 24,
                        ),
                        title: Text(product.name),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: AppTheme.greyTextColor),
                        onTap: () async {
                          productsController.addToSearchHistory(product.id);
                          Get.toNamed('/product/${product.id}');
                        },
                      ),
                    );
                  },
                ),
                _query.isNotEmpty
                    ? InkWell(
                        onTap: () async {
                          productsController.addToSearchHistory(_query);
                          Get.toNamed(Routes.PRODUCTS_LISTING,
                              arguments: {'query': _query});
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Search for ',
                                style: AppTheme.fontStyleDefault,
                              ),
                              TextSpan(
                                  text: ' "$_query"',
                                  style: AppTheme.fontStyleDefaultBold.copyWith(
                                    color: AppTheme.colorBlue,
                                  )),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const Spacing(size: AppTheme.spacingDefault),
                Obx(() {
                  List<String> searchHistory = productsController.searchHistory;

                  if (searchHistory.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Past Searches',
                              style: AppTheme.fontStyleHeadingDefault.copyWith(
                                color: AppTheme.colorBlue,
                              ),
                            ),
                            SecondaryButton(
                              label: 'Clear History',
                              onPressed: _clearSearchHistory,
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchHistory.length,
                          itemBuilder: (context, index) {
                            String query = searchHistory[index];
                            ProductModel? product =
                                productsController.getProductByID(query);
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppTheme.spacingTiny,
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: product != null
                                    ? CachedNetworkImage(
                                        imageUrl: product.images[0],
                                        height: 24,
                                        width: 24,
                                      )
                                    : const Icon(Icons.history,
                                        color: AppTheme.greyTextColor),
                                title: Text(product?.name ?? query),
                                trailing: const Icon(Icons.arrow_forward_ios,
                                    color: AppTheme.greyTextColor),
                                onTap: () async {
                                  if (product != null) {
                                    Get.toNamed('/product/${product.id}');
                                  } else {
                                    Get.toNamed(Routes.PRODUCTS_LISTING,
                                        arguments: {'query': query});
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
