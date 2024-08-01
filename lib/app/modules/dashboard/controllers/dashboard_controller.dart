import 'dart:async';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {
  final now = DateTime.now().obs;
  final currentIndex = 0.obs;
  final CarouselController carouselController = CarouselController();
  final List<Map<String, dynamic>> imageList = [
    {"id": 1, "image_path": 'assets/images/banner1.png'},
    {"id": 2, "image_path": 'assets/images/banner2.png'},
    {"id": 3, "image_path": 'assets/images/banner3.png'},
  ];
  final TextEditingController textEditingController = TextEditingController();
  var selectedCategory = 'All'.obs;
  var products = <Product>[].obs;
  var cartItems = <CartItem>[].obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    products.value = [
      Product('1', 'AirPods Pro', 249.99, 4.8, 'https://www.uxcrush.com/wp-content/uploads/2019/08/Dark-ecommerce-Figma-app-template-1014x487.jpg', 'AirPods'),
      Product('2', 'MacBook Air', 999.99, 4.7, 'https://www.uxcrush.com/wp-content/uploads/2019/08/Dark-ecommerce-Figma-app-template-1014x487.jpg', 'Laptop'),
      Product('3', 'Sony WH-1000XM4', 349.99, 4.6, 'https://www.uxcrush.com/wp-content/uploads/2019/08/Dark-ecommerce-Figma-app-template-1014x487.jpg', 'Headphones'),
      Product('4', 'iPhone 13 Pro', 999.99, 4.9, 'https://www.uxcrush.com/wp-content/uploads/2019/08/Dark-ecommerce-Figma-app-template-1014x487.jpg', 'Phones'),
      Product('5', 'iPad Air', 599.99, 4.5, 'https://www.uxcrush.com/wp-content/uploads/2019/08/Dark-ecommerce-Figma-app-template-1014x487.jpg', 'Tablets'),
    ];
    loadCartItems();
  }

  @override
  void onReady() {
    super.onReady();
    Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        now.value = DateTime.now();
      },
    );
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }

  void onSearchPressed() {
    String searchQuery = textEditingController.text;
    print('Searching for: $searchQuery');
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
  }

  List<Product> getFilteredProducts() {
    if (selectedCategory.value == 'All') {
      return products;
    } else {
      return products.where((product) => product.category == selectedCategory.value).toList();
    }
  }

  // void addToCart(Product product) {
  //   var existingItem = cartItems.firstWhereOrNull((item) => item.product.id == product.id);
  //   if (existingItem != null) {
  //     existingItem.quantity.value++;
  //   } else {
  //     cartItems.add(CartItem(product: product, quantity: 1));
  //   }
  //   saveCartItems();
  //   Get.snackbar('Added to Cart', '${product.name} has been added to your cart.');
  // }

  void addToCart(Product product) {
  var existingItem = cartItems.firstWhereOrNull((item) => item.product.id == product.id);
  if (existingItem != null) {
    existingItem.quantity.value++;
  } else {
    cartItems.add(CartItem(product: product, quantity: 1));
  }
  saveCartItems();
  
  // Show SnackBar with custom background color
  Get.snackbar(
    'Added to Cart',
    '${product.name} has been added to your cart.',
    backgroundColor: Colors.green, // Change this to your preferred color
    colorText: Colors.white, // Optionally, set text color
  );
}


  void loadCartItems() {
    var savedItems = box.read<List>('cartItems') ?? [];
    cartItems.value = savedItems.map((item) => CartItem.fromJson(item)).toList();
  }

  void saveCartItems() {
    box.write('cartItems', cartItems.map((item) => item.toJson()).toList());
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
    saveCartItems();
  }

  void updateQuantity(CartItem item, int quantity) {
    if (quantity > 0) {
      item.quantity.value = quantity;
    } else {
      removeFromCart(item);
    }
    saveCartItems();
  }

  double get total => cartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity.value));

  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity.value);
}

class Product {
  final String id;
  final String name;
  final double price;
  final double rating;
  final String imageUrl;
  final String category;

  Product(this.id, this.name, this.price, this.rating, this.imageUrl, this.category);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'rating': rating,
      'imageUrl': imageUrl,
      'category': category,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['id'],
      json['name'],
      json['price'],
      json['rating'],
      json['imageUrl'],
      json['category'],
    );
  }
}

class CartItem {
  final Product product;
  RxInt quantity;

  CartItem({required this.product, required int quantity})
      : quantity = quantity.obs;

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity.value,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}