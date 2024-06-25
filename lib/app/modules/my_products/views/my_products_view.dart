import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_products_controller.dart';

class MyProductsView extends GetView<MyProductsController> {
  const MyProductsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyProductsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MyProductsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
