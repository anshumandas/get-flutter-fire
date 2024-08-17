// lib/app/modules/dashboard/views/dashboard_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fixed image sizes for mobile and web
    final double headerImageWidth = 800;
    final double headerImageHeight = 150;
    final double productImageWidth = 50;
    final double productImageHeight = 100;
    final double trendingImageWidth = 200;
    final double trendingImageHeight = 150;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image with fixed size 800x150
            Image.network(
              'https://i.ibb.co/c2nc5pn/Header.jpg',
              width: headerImageWidth,
              height: headerImageHeight,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            // Trending Products Section
            _buildTrendingProducts(trendingImageWidth, trendingImageHeight),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Obx(
                () => Wrap(
                  spacing: 8,
                  children: controller.filters.map((filter) {
                    return ChoiceChip(
                      label: Text(filter),
                      selected: controller.selectedFilter.value == filter,
                      onSelected: (selected) {
                        controller.updateFilter(selected ? filter : null);
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
                  return _buildProductCard(
                    controller.filteredProducts[index],
                    productImageWidth,
                    productImageHeight,
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
            height: 255,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.trendingProducts.length,
              itemBuilder: (context, index) {
                return _buildTrendingProductCard(
                  controller.trendingProducts[index],
                  imageWidth,
                  imageHeight,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingProductCard(Map<String, String> product, double imageWidth, double imageHeight) {
    return Padding(
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
                product['image']!,
                fit: BoxFit.contain, // Ensure the whole image is visible
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product['price']!,
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
    );
  }

  Widget _buildProductCard(Map<String, String> product, double imageWidth, double imageHeight) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Image.network(
            product['image']!,
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.contain, // Ensure the whole image is visible
          ),
          title: Text(product['name']!),
          subtitle: Text(product['price']!),
          trailing: ElevatedButton(
            onPressed: () {
              // No navigation action here
              // Just an empty callback
            },
            child: Text('View'),
          ),
        ),
      ),
    );
  }
}
