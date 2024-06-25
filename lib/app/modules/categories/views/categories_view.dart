import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CategoriesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CategoriesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
