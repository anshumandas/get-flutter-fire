import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import '../../../widgets/screen_widget.dart';
import '../../../../services/auth_service.dart';
import '../controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/screen_widget.dart';
import '../../../../services/auth_service.dart';
import '../controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import '../../../widgets/screen_widget.dart';
import '../../../../services/auth_service.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      appBar: AppBar(
        title: Text('${AuthService.to.userName} Cart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Cart',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildCartItem('Cappuccino', 'Rich and creamy with a smooth finish.', Icons.coffee),
                  const SizedBox(height: 10),
                  _buildCartItem('Latte', 'Smooth and creamy, perfect for a relaxing afternoon.', Icons.coffee_maker),
                ],
              ),
            ),
          ],
        ),
      ),
      screen: screen!,
    );
  }

  Widget _buildCartItem(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 30,
              color: Colors.brown.shade600,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown.shade700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.brown.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
