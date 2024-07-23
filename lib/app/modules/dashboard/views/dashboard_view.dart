import 'package:animated_hint_searchbar/animated_hint_searchbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/products/controllers/products_controller.dart';
import 'package:get_flutter_fire/app/modules/settings/controllers/settings_controller.dart';
import 'package:get_flutter_fire/app/widgets/ProductCard.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../root/controllers/root_controller.dart';

class DashboardView extends GetView<ProductsController> {
  DashboardView({Key? key}) : super(key: key);

  final RootController rootController = Get.find<RootController>();
  final SettingsController themeController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    final List<String> categories = ['All', 'AirPods', 'Laptop', 'Headphones', 'Phones', 'Tablets'];

    return Scaffold(
      backgroundColor: themeController.activePersona.backgroundColor,
      body: Obx(
            () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (rootController.isSearchVisible.value)
                Search(
                  textEditingController: controller.searchController,
                  micEnabled: true,
                  onSearchPressed: controller.onSearchPressed,
                  hintTexts: ['Search "Mobiles"', 'Search "EarPhones"', 'Search "Watches"'],
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
              Stack(
                children: [
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
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.imageList.asMap().entries.map((entry) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(
                                controller.currentIndex.value == entry.key ? 0.9 : 0.4
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Category",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ElevatedButton(
                          onPressed: () {
                            controller.setSelectedCategory(categories[index]);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: controller.selectedCategory.value == categories[index] ? Colors.white : Colors.blue,
                            backgroundColor: controller.selectedCategory.value == categories[index] ? Colors.blue : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: Colors.blue),
                            ),
                          ),
                          child: Text(categories[index]),
                        ),
                      ));
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Obx(() => GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kIsWeb ? 4 : 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: controller.getFilteredProducts().length,
                  itemBuilder: (context, index) {
                    final product = controller.getFilteredProducts()[index];
                    return GestureDetector(
                      onTap: () => controller.addToCart(product),
                      child: ProductCard(
                        imageUrl: product.imageUrl,
                        productName: product.name,
                        price: product.price,
                        rating: product.rating,
                        productId: product.id,
                      ),
                    );
                  },
                )),
              ),
            ],
          ),
            ),
      ),
    );
  }
}