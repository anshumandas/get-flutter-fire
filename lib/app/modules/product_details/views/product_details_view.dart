// Accommodation Details

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/product_details_controller.dart';
import '../../cart/controllers/cart_controller.dart';

class ProductDetailsView extends GetWidget<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            controller.accommodationName.value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.white,
          ),
        )),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the main image
              Obx(
                    () => Image.asset(
                  controller.additionalImages.isNotEmpty
                      ? controller.additionalImages.first
                      : controller.accommodationName.value,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Display the additional images in a horizontal list
              Obx(
                    () => SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.additionalImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.asset(
                          controller.additionalImages[index],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Display the accommodation name
              Obx(
                    () => Text(
                  controller.accommodationName.value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Display the location
              Obx(
                    () => Text(
                  'Location: ${controller.accommodationLocation.value}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ),
              const SizedBox(height: 16),

              // Display the price
              Obx(
                    () => Text(
                  'Price: Rs ${controller.accommodationPrice.value} per night',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              // Display the description
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Obx(
                    () => Text(
                  controller.accommodationDescription.value,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 24),

              // Add to Cart button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    controller.addToCart();
                  },
                  icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                  ),
                  label: Text('Add to Wishlist'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
