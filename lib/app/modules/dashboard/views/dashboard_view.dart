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
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
      appBar: AppBar(
        title: const Text('Clothing App Dashboard'),
      ),
>>>>>>> dbf771fddc3f1e60b7f7d1df5117f9dd06f61dd6
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
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
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
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
<<<<<<< HEAD
=======
=======
=======
            Image.network(
              'https://via.placeholder.com/800x150',
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            _buildTrendingProducts(),
>>>>>>> dbf771fddc3f1e60b7f7d1df5117f9dd06f61dd6
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Wrap(
                spacing: 8,
                children: [
<<<<<<< HEAD
                  Chip(
                    label: Text('Male'),
                  ),
                  Chip(
                    label: Text('Female'),
                  ),
                  Chip(
                    label: Text('Unisex'),
                  ),
                ],
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
              ),
            ),
            // Product List
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
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
<<<<<<< HEAD
=======
=======
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(controller.products[index], productImageWidth, productImageHeight);
                },
              ),
            ),
=======
                  Chip(label: Text('Men')),
                  Chip(label: Text('Women')),
                  Chip(label: Text('Kids')),
                  Chip(label: Text('Accessories')),
                ],
              ),
            ),
            _buildProductList(),
>>>>>>> dbf771fddc3f1e60b7f7d1df5117f9dd06f61dd6
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildTrendingProducts(double imageWidth, double imageHeight) {
=======
<<<<<<< HEAD
  Widget _buildTrendingProducts(double imageWidth, double imageHeight) {
=======
<<<<<<< HEAD
  Widget _buildTrendingProducts(double imageWidth, double imageHeight) {
=======
  Widget _buildTrendingProducts() {
>>>>>>> dbf771fddc3f1e60b7f7d1df5117f9dd06f61dd6
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
          Text(
            'Trending Products',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
          const Text(
            'Trending Now',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
>>>>>>> dbf771fddc3f1e60b7f7d1df5117f9dd06f61dd6
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
          SizedBox(
            height: 255,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.trendingProducts.length,
              itemBuilder: (context, index) {
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
                return _buildTrendingProductCard(
                  controller.trendingProducts[index],
                  imageWidth,
                  imageHeight,
                );
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
                return _buildTrendingProductCard(controller.trendingProducts[index], imageWidth, imageHeight);
=======
                return _buildTrendingProductCard(controller.trendingProducts[index]);
>>>>>>> dbf771fddc3f1e60b7f7d1df5117f9dd06f61dd6
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
              },
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildTrendingProductCard(Map<String, String> product, double imageWidth, double imageHeight) {
=======
<<<<<<< HEAD
  Widget _buildTrendingProductCard(Map<String, String> product, double imageWidth, double imageHeight) {
=======
<<<<<<< HEAD
  Widget _buildTrendingProductCard(Map<String, String> product, double imageWidth, double imageHeight) {
=======
  Widget _buildTrendingProductCard(Map<String, String> product) {
>>>>>>> dbf771fddc3f1e60b7f7d1df5117f9dd06f61dd6
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
<<<<<<< HEAD
        margin: EdgeInsets.symmetric(horizontal: 4),
=======
<<<<<<< HEAD
        margin: EdgeInsets.symmetric(horizontal: 4),
=======
<<<<<<< HEAD
        margin: EdgeInsets.symmetric(horizontal: 4),
=======
        margin: const EdgeInsets.symmetric(horizontal: 4),
>>>>>>> dbf771fddc3f1e60b7f7d1df5117f9dd06f61dd6
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
              width: imageWidth,
              height: imageHeight,
              child: Image.network(
                product['image']!,
                fit: BoxFit.contain, // Ensure the whole image is visible
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
              height: 150,
              width: 180,
              child: Image.network(
                product['image']!,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
>>>>>>> dbf771fddc3f1e60b7f7d1df5117f9dd06f61dd6
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name']!,
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
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
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product['price']!,
                    style: const TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
>>>>>>> dbf771fddc3f1e60b7f7d1df5117f9dd06f61dd6
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
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

<<<<<<< HEAD
  Widget _buildProductCard(Map<String, String> product, double imageWidth, double imageHeight) {
=======
<<<<<<< HEAD
  Widget _buildProductCard(Map<String, String> product, double imageWidth, double imageHeight) {
=======
<<<<<<< HEAD
  Widget _buildProductCard(Map<String, String> product, double imageWidth, double imageHeight) {
=======
  Widget _buildProductList() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          return _buildProductCard(controller.products[index]);
        },
      ),
    );
  }

  Widget _buildProductCard(Map<String, String> product) {
>>>>>>> dbf771fddc3f1e60b7f7d1df5117f9dd06f61dd6
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 4,
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Image.network(
            product['image']!,
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.contain, // Ensure the whole image is visible
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Image.network(
            product['image']!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
>>>>>>> dbf771fddc3f1e60b7f7d1df5117f9dd06f61dd6
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
          ),
          title: Text(product['name']!),
          subtitle: Text(product['price']!),
          trailing: ElevatedButton(
            onPressed: () {
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
              // No navigation action here
              // Just an empty callback
            },
            child: Text('View'),
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
              // Navigate to product details page or perform action
            },
            child: Text('View'),
=======
              // Add navigation or action logic here
            },
            child: const Text('View'),
>>>>>>> dbf771fddc3f1e60b7f7d1df5117f9dd06f61dd6
>>>>>>> 702ea24b0a8011c719515d0533b30a0bd796d698
>>>>>>> 2cacd2f6d6101e0f8f72fc187e313d8fa5dc41c4
          ),
        ),
      ),
    );
  }
}
