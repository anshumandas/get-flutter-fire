import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../products/views/products_view.dart'; // Ensure this path is correct
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sale banner
          Container(
            width: double.infinity,
            color: Colors.redAccent,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Sale 50% OFF!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Space between banner and other content
          const SizedBox(height: 16.0),
          // Banner image for key item
          Container(
            width: double.infinity,
            height: 200.0, // Adjust height as needed
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/key_item_banner.jpg'), // Update with your image asset path
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          // Space between image and other content
          const SizedBox(height: 16.0),
          // Product category cards
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              crossAxisCount: 3, // Adjust the number of columns
              crossAxisSpacing: 8.0, // Space between columns
              mainAxisSpacing: 8.0, // Space between rows
              children: [
                _buildCategoryCard('Headphones', Icons.headphones),
                _buildCategoryCard('Smartphones', Icons.phone_android),
                _buildCategoryCard('Laptops', Icons.laptop),
                _buildCategoryCard('Smartwatches', Icons.watch),
                _buildCategoryCard('Refrigerators', Icons.kitchen),
                _buildCategoryCard('TVs', Icons.tv),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to create a category card
  Widget _buildCategoryCard(String categoryName, IconData icon) {
    return Card(
      elevation: 2.0, // Reduced elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to ProductsView without passing any category
          Get.to(() => const ProductPage());
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40.0, color: Colors.blue), // Reduced icon size
            const SizedBox(height: 8.0),
            Text(
              categoryName,
              style: const TextStyle(
                fontSize: 14, // Reduced font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
