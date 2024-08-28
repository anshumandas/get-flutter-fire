import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _buildMainContent(),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            _buildPurpleBackground(),
            _buildContent(),
          ],
        ),
      ],
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
        width: 360,
        height: 360,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300),
          color: Colors.purple.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Column(
        children: [
          _buildTitle(),
          const SizedBox(height: 10),
          _buildSearchBar(),
          const SizedBox(height: 20),
          _buildPopularCategories(),
          const SizedBox(height: 20), // Add some spacing before the image
          _buildCarousel(), // Add the carousel here
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
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
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search in store',
            prefixIcon: const Icon(Icons.search),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildPopularCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Popular Categories',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // New method to build the carousel
  Widget _buildCarousel() {
    final List<String> imgList = [
      'assets/images/dash.png', // Replace with your image paths
      'assets/images/dash.png', // Add more images if needed
      'assets/images/dash.png',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
      ),
      items: imgList.map((item) => _buildImageContainer(item)).toList(),
    );
  }

  Widget _buildImageContainer(String imagePath) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color
            spreadRadius: 2, // The spread of the shadow
            blurRadius: 8, // The blur effect of the shadow
            offset: const Offset(
                0, 4), // The position of the shadow (horizontal, vertical)
          ),
        ],
      ),
    );
  }
}
