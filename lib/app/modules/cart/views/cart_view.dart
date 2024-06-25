import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_flutter_fire/services/auth_service.dart';

import '../../../routes/screens.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${AuthService.to.userName} Cart'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.rootDelegate.toNamed(Screen.CHECKOUT.route),
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.check_outlined,
          color: Colors.white,
        ),
      ),
      body: const Center(
        child: Text(
          'CartView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
