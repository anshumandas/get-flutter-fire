import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/products/controllers/products_controller.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import 'package:get_flutter_fire/models/product.dart';

class DashboardView extends GetView<ProductsController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fixed image sizes for mobile and web
    final double headerImageWidth = GetPlatform.isWeb ? 1500 : double.infinity; // Adjust width for web
    final double headerImageHeight = GetPlatform.isWeb ? 300 : 150; // Adjust height for web
    final double trendingImageWidth = GetPlatform.isWeb ? 150 : 100; // Adjust width for web
    final double trendingImageHeight = GetPlatform.isWeb ? 150 : 100; // Adjust height for web

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          // Search icon in the app bar
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ProductSearchDelegate(controller));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image with size adjusted for web
            Image.network(
              'https://i.ibb.co/c2nc5pn/Header.jpg',
              width: headerImageWidth,
              height: headerImageHeight,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            // Trending Products Section with horizontal scrolling
            _buildTrendingProducts(trendingImageWidth, trendingImageHeight),
            const SizedBox(height: 20),
            // Filters
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(
                () => Wrap(
                  spacing: 8,
                  children: controller.filters.map((filter) {
                    final isSelected = controller.selectedCategory.value == filter;
                    return ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      selectedColor: Colors.blue, // Color when selected
                      backgroundColor: Colors.grey[300], // Color when not selected
                      onSelected: (selected) {
                        controller.setCategory(selected ? filter : '');
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            // Product List
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.filteredProducts[index];
                  return _buildProductCard(
                    product,
                    trendingImageWidth,
                    trendingImageHeight,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingProducts(double imageWidth, double imageHeight) {
    final double trendingProductsHeight = GetPlatform.isWeb ? 255 : 205;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trending Products',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: trendingProductsHeight, // Adjust height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.trendingProducts.length,
              itemBuilder: (context, index) {
                final product = controller.trendingProducts[index];
                return GestureDetector(
                  onTap: () {
                    Get.rootDelegate.toNamed(Routes.PRODUCT_DETAILS(product.id));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: imageWidth,
                            height: imageHeight,
                            child: Image.network(
                              product.productImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star, color: Colors.yellow),
                                    Icon(Icons.star_border, color: Colors.yellow),
                                    Icon(Icons.star_border, color: Colors.yellow),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildProductCard(Product product, double imageWidth, double imageHeight) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Image.network(
            product.productImage,
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.contain, // Ensure the whole image is visible
          ),
          title: Text(product.name),
          subtitle: Text('\$${product.price}'),
          trailing: ElevatedButton(
            onPressed: () {
              Get.rootDelegate.toNamed(Routes.PRODUCT_DETAILS(product.id));
            },
            child: Text('View'),
          ),
        ),
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate<Product?> {
  final ProductsController controller;

  ProductSearchDelegate(this.controller);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = controller.products
        .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('\$${product.price}'),
          onTap: () {
            Get.rootDelegate.toNamed(Routes.PRODUCT_DETAILS(product.id));
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = controller.products
        .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('\$${product.price}'),
          onTap: () {
            Get.rootDelegate.toNamed(Routes.PRODUCT_DETAILS(product.id));
          },
        );
      },
    );
  }
}
