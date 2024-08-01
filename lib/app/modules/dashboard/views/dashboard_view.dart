<<<<<<< HEAD
import 'package:animated_hint_searchbar/animated_hint_searchbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/products/controllers/products_controller.dart';
import 'package:get_flutter_fire/app/modules/settings/controllers/settings_controller.dart';
import '../../root/controllers/root_controller.dart';

class DashboardView extends GetView<ProductsController> {
  DashboardView({Key? key}) : super(key: key);

  final RootController rootController = Get.find<RootController>();
  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: settingsController.selectedPersona.value?.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (rootController.isSearchVisible.value)
              Search(
                textEditingController: controller.searchController,
                micEnabled: true,
                onSearchPressed: controller.onSearchPressed,
                hintTexts: ['Search "Jeans"', 'Search "Belts"', 'Search "Watches"'],
                boxShadow: BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
                verticalDivider_color: Colors.grey,
              ),
            if (rootController.isSearchVisible.value)
              const SizedBox(height: 30),
            CarouselSlider(
              items: controller.imageList.map((item) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      item['image_path'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                );
              }).toList(),
              carouselController: controller.carouselController,
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: true,
                aspectRatio: 2,
                viewportFraction: 0.92,
                enlargeCenterPage: true,
                onPageChanged: controller.onPageChanged
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                "Featured Products",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: settingsController.selectedPersona.value?.textColor ?? Color.fromARGB(255, 15, 43, 16)
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return Card(
                    color: settingsController.selectedPersona.value?.secondaryColor ?? Color.fromARGB(255, 232, 252, 243),
                    elevation: 4,
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: settingsController.selectedPersona.value?.textColor ?? Colors.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        '\$${product.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: settingsController.selectedPersona.value?.primaryColor ?? Colors.green,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(Icons.star, size: 16, color: Colors.amber),
                                          SizedBox(width: 4),
                                          Text(
                                            product.rating.toString(),
                                            style: TextStyle(fontSize: 14, color: settingsController.selectedPersona.value?.textColor ?? Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  ElevatedButton(
                                    onPressed: () => controller.addToCart(product),
                                    child: Text('Add to Cart'),
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: settingsController.selectedPersona.value?.primaryColor ?? Color.fromARGB(255, 20, 121, 91),
                                      minimumSize: Size(double.infinity, 36),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
                              child: SizedBox(
                                height: 100,
                                child: Image.asset(
                                  product.imageAsset,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
=======
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'DashboardView is working',
                style: TextStyle(fontSize: 20),
              ),
              Text('Time: ${controller.now.value.toString()}'),
            ],
          ),
        ),
      ),
    );
  }
}
>>>>>>> origin/main
