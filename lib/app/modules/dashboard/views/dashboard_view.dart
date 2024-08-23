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
    final double headerImageWidth = GetPlatform.isWeb ? 1200 : double.infinity; // Adjust width for web
    final double headerImageHeight = GetPlatform.isWeb ? 300 : 150; // Adjust height for web
    final double trendingImageWidth = GetPlatform.isWeb ? 150 : 100; // Adjust width for web
    final double trendingImageHeight = GetPlatform.isWeb ? 150 : 100; // Adjust height for web

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          // Add any actions you need here
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
