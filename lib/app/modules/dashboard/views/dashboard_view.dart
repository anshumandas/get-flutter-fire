import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solitaire Perfume '),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/image1.jpg', 
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            _buildTrendingProducts(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Wrap(
                spacing: 8,
                children: [
                  Chip(label: Text('Perfume for Men')),
                  Chip(label: Text('Perfume for Women')),
                  Chip(label: Text('Unisex ')),

                  
                ],
              ),
            ),
            _buildProductList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingProducts() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Trending Now',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 255,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.trendingProducts.length,
              itemBuilder: (context, index) {
                return _buildTrendingProductCard(controller.trendingProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingProductCard(Map<String, String> product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 180,
              child: Image.asset(
                product['image']!, // Loading image from assets
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name']!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product['price']!,
                    style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 92, 2, 86), fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(Icons.star, color: Color.fromARGB(255, 206, 59, 255)),
                      Icon(Icons.star, color: Color.fromARGB(255, 206, 59, 255)),
                      Icon(Icons.star, color: Color.fromARGB(255, 206, 59, 255)),
                      Icon(Icons.star_border, color: Color.fromARGB(255, 206, 59, 255)),
                      Icon(Icons.star_border, color: Color.fromARGB(255, 206, 59, 255)),
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Image.asset(
            product['image']!, // Loading image from assets
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          title: Text(product['name']!),
          subtitle: Text(product['price']!),
          // // trailing: ElevatedButton(
          // //   onPressed: () {
          // //     // Add navigation or action logic here
          // //   },
          // //   child: const Text('View'),
          // ),
        ),
      ),
    );
  }
}
