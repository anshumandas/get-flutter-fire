import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/role.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../../widgets/ProductCard.dart';
import '../../settings/controllers/settings_controller.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  ProductsView({super.key});

  final SettingsController themeController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    var arg = Get.rootDelegate.arguments();
    final List<String> categories = ['All', 'AirPods', 'Laptop', 'Headphones', 'Phones', 'Tablets'];

    return Scaffold(
      backgroundColor: themeController.activePersona.backgroundColor,
      floatingActionButton: (arg != null && Get.rootDelegate.arguments()["role"] == Role.seller)
          ? FloatingActionButton.extended(
        onPressed: controller.addDemoProduct,
        label: const Text('Add'),
      )
          : null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
    );
  }
}