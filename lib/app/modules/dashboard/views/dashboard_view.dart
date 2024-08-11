import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://marketplace.canva.com/EAFMpwTmiRI/1/0/800w/canva-cream-elegant-fashion-sale-email-header-AR3z0NO4h7U.jpg',
              width: double.infinity,
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            // Trending Products Section
            _buildTrendingProducts(),
            const SizedBox(height: 20),
            _buildCarousel(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Wrap(
                spacing: 8,
                children: [
                  Chip(
                    label: Text('Category 1'),
                  ),
                  Chip(
                    label: Text('Category 2'),
                  ),
                  Chip(
                    label: Text('Category 3'),
                  ),
                ],
              ),
            ),
            // Product List
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  return _buildProductCard(controller.products[index]);
                },
              ),
            ),
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
          Text(
            'Trending Products',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
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
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 180,
              child: Image.network(
                product['image']!,
                fit: BoxFit.contain,
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
                    '\$ Product Price',
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

  Widget _buildCarousel() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Products',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 11),
          CarouselSlider(
            options: CarouselOptions(
              // height: 200.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
            items: controller.products.map((product) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          product['image']!,
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.infinity,
                        ),
                        Center(
                          child: Text(
                            product['name']!,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, String> product) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Image.network(
            product['image']!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          title: Text(product['name']!),
          subtitle: Text('\$ Product Price'),
          trailing: ElevatedButton(
            onPressed: () {
              // Navigate to product details page or perform action
            },
            child: Text('View'),
          ),
        ),
      ),
    );
  }
}
