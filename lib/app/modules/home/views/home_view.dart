import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../products/views/products_view.dart';
import '../../products/controllers/products_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductsController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RestQuest',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Obx(() {
        // Displaying different content based on user role
        if (controller.isAdmin) {
          return AdminHomeContent();
        } else {
          return ProductsView();
        }
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (index) {
            controller.selectedIndex.value = index;
            switch (index) {
              case 0:
                Get.offAllNamed(Routes.HOME);
                break;
              case 1:
                Get.toNamed(Routes.PROFILE);
                break;
              case 2:
                Get.toNamed(Routes.CART);
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: Colors.black,
              ),
              label: 'Wishlist',
            ),
          ],
        );
      }),
    );
  }
}

class AdminHomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => Get.toNamed(Routes.MY_PRODUCTS),
          child: Text('Manage Hotels'),
        ),
        ElevatedButton(
          onPressed: () => Get.toNamed(Routes.USERS),
          child: Text('Manage Users'),
        ),
      ],
    );
  }
}
