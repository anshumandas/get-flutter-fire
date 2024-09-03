import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import 'package:get_flutter_fire/models/product.dart';
import 'package:get_flutter_fire/models/category.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import 'package:get_flutter_fire/app/widgets/custom_widgets.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: controller.fetchDashboardData,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: 20),
                _buildFeaturedProducts(),
                SizedBox(height: 20),
                _buildFeaturedCategories(),
                SizedBox(height: 20),
                _buildRecentlyViewedProducts(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            'Discover the latest products',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Featured Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.featuredProducts.length,
            itemBuilder: (context, index) {
              return _buildProductCard(controller.featuredProducts[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedCategories() {
    print(
        "Building featured categories. Count: ${controller.featuredCategories.length}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Featured Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        if (controller.featuredCategories.isEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("No featured categories available."),
          )
        else
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.featuredCategories.length,
              itemBuilder: (context, index) {
                return _buildCategoryCard(controller.featuredCategories[index]);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryCard(Category category) {
    print(
        "Building category card for: ${category.name}, Image: ${category.imageUrl}");
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PRODUCTS, arguments: {'category': category.id});
      },
      child: Container(
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                category.imageUrl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print("Error loading image for ${category.name}: $error");
                  return Icon(Icons.error);
                },
              ),
            ),
            SizedBox(height: 8),
            Text(
              category.name,
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentlyViewedProducts() {
    if (controller.recentlyViewedProducts.isEmpty) return SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Recently Viewed',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.recentlyViewedProducts.length,
            itemBuilder: (context, index) {
              return _buildProductCard(
                  controller.recentlyViewedProducts[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PRODUCT_DETAILS(product.id));
      },
      child: Container(
        width: 160,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: CustomCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  product.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Text(
                product.name,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                '\Rs ${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                    color: Get.theme.colorScheme.secondary,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
