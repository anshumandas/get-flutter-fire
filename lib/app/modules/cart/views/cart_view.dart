import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/screen_widget.dart';
import '../../../../services/auth_service.dart';
import '../controllers/cart_controller.dart';
import '../../../../models/screens.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      screen: Screen.CART,
      appBar: AppBar(
        title: Text('${AuthService.to.userName}\'s Cart'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (!AuthService.to.isLoggedIn) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    'Please log in or continue as a guest to view your cart.'),
                ElevatedButton(
                  onPressed: () async {
                    bool success = await AuthService.to.signInAnonymously();
                    if (success) {
                      Get.snackbar('Success', 'Signed in as guest');
                    }
                  },
                  child: const Text('Continue as Guest'),
                ),
                ElevatedButton(
                  onPressed: () => Get.rootDelegate.toNamed(Screen.LOGIN.route),
                  child: const Text('Log In'),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: Text(
            'CartView is working',
            style: TextStyle(fontSize: 20),
          ),
        );
      }),
    );
  }
}
