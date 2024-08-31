import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          controller.userName.value.isNotEmpty ? 'Welcome, ${controller.userName.value}' : 'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        centerTitle: true,
        actions: [
          Obx(() => PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'profile') {
                Get.toNamed(Routes.PROFILE);
              } else if (value == 'changePassword') {
                Get.toNamed(Routes.CHANGEPASSWORD);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('Profile'),
              ),
              const PopupMenuItem<String>(
                value: 'changePassword',
                child: Text('Change Password'),
              ),
            ],
            child: controller.profileImageUrl.value != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(controller.profileImageUrl.value!),
                    radius: 18,
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                    radius: 18,
                  ),
                ),
          )),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.signOut,
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.PRODUCTS),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Go to Product List',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.toNamed(Routes.CART),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Go to Cart',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}