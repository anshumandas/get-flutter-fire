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
      body: Center(
        child: Column(
          children: [
            // const Text(
            //   'CartView is working',
            //   style: TextStyle(fontSize: 20),
            // ),
            for (final i in controller.getProducts()) Text(i.name),
          ],
        ),
      ),
      screen: screen!,
    );
  }
}
