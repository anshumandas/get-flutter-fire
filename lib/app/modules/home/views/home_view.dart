// lib/app/modules/home/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the instance of the controller
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Obx(
              () => Text(
            'Welcome ${controller.userName.value}!',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example of action, you can replace it with your functionality
          Get.snackbar('Action', 'Floating action button pressed');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
