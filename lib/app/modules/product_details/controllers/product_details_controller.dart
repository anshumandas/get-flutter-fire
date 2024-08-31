import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_flutter_fire/models/product.dart';
import '../../cart/controllers/cart_item.dart';
import '../../cart/controllers/cart_controller.dart';

class ProductDetailsController extends GetxController {
  // Observable product details
  var product = Rx<Product>(
    Product(
      name: 'Sample Product',
      id: '0',
      icon: Icons.shopping_cart, // Default icon
      price: 0.0,
      date: DateTime.now(),
      description: 'Sample description', // Provide a default description
    ),
  );

  // Observable for selected size
  var selectedSize = ''.obs;

  final String productId;
  final CartController cartController = Get.find<CartController>(); // Locate the CartController

  ProductDetailsController(this.productId);

  @override
  void onInit() {
    super.onInit();
    Get.log('ProductDetailsController created with id: $productId');
  }

  @override
  void onReady() {
    super.onReady();
    fetchProductDetails();
  }

  @override
  void onClose() {
    Get.log('ProductDetailsController closed with id: $productId');
    super.onClose();
  }

  void fetchProductDetails() {
    // Example logic to fetch product details based on productId
    final products = {
      '1': Product(
        name: 'T-shirt',
        id: '1',
        icon: Icons.checkroom,
        price: 19.99,
        date: DateTime.now().subtract(const Duration(days: 10)),
        description: 'Comfortable cotton t-shirt', // Provide description
      ),
      '2': Product(
        name: 'Pages',
        id: '2',
        icon: Icons.pages,
        price: 39.99,
        date: DateTime.now().subtract(const Duration(days: 20)),
        description: 'Pages notebook for writing', // Provide description
      ),
      '3': Product(
        name: 'Sports',
        id: '3',
        icon: Icons.sports_basketball,
        price: 29.99,
        date: DateTime.now().subtract(const Duration(days: 30)),
        description: 'Various sports equipment', // Provide description
      ),
      '4': Product(
        name: 'Jacket',
        id: '4',
        icon: Icons.watch,
        price: 59.99,
        date: DateTime.now().subtract(const Duration(days: 40)),
        description: 'Warm winter jacket', // Provide description
      ),
      '5': Product(
        name: 'Handwash',
        id: '5',
        icon: Icons.cleaning_services,
        price: 4.99,
        date: DateTime.now().subtract(const Duration(days: 50)),
        description: 'Antibacterial hand wash', // Provide description
      ),
    };

    product.value = products[productId] ?? Product(
      name: 'Unknown Product',
      id: productId,
      icon: Icons.help,
      price: 0.0,
      date: DateTime.now(),
      description: 'No description available', // Provide description
    );
  }

  void addToCart() {
    final selectedProduct = product.value;

    final cartItem = CartItem(
      id: selectedProduct.id,
      name: selectedProduct.name,
      price: selectedProduct.price,
      icon: selectedProduct.icon, // Ensure icon is provided
      size: selectedSize.value.isNotEmpty ? selectedSize.value : null,
      product: selectedProduct,
    );

    cartController.addToCart(cartItem);
  }
}
