import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPurpleBackground(),
            const SizedBox(height: 20),
            _buildCarousel(context),
            const SizedBox(height: 20),
            _buildCarousel(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPurpleBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple[300],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.all(0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300),
          color: Colors.purple.withOpacity(0.4),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100),
            _buildTitle(),
            const SizedBox(height: 10),
            _buildSearchBar(),
            const SizedBox(height: 20),
            _buildPopularCategories(),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Good Day For Shopping...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search in store',
            prefixIcon: Icon(Icons.search),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildPopularCategories() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Popular Categories',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // New method to build the carousel
  Widget _buildCarousel(BuildContext context) {
    return SizedBox(
      height: 220,
      child: CarouselView(
        controller: CarouselController(),
        backgroundColor: Colors.transparent,
        itemSnapping: true,
        shrinkExtent: MediaQuery.of(context).size.width,
        itemExtent: double.infinity,
        children: [
          ...controller.items.map((item) => _buildImageContainer(item)),
        ],
      ),
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Image.asset(
                imagePath,
                height: 150,
              ),
              const Text("Very Good Lenin Shirt"),
              const Text("\$1000"),
            ],
          ),
          Column(
            children: [
              Image.asset(
                imagePath,
                height: 150,
              ),
              const Text("Very Good Lenin Shirt"),
              const Text("\$1000"),
            ],
          ),
        ],
      ),
    );
  }
}
