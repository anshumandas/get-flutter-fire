import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductsController extends GetxController {
  final products = <Product>[].obs;
  final cartItems = <CartItem>[].obs;
  final box = GetStorage();

  late TextEditingController searchController;

   final currentIndex = 0.obs;
  final CarouselController carouselController = CarouselController();

  final List<Map<String, dynamic>> imageList = [
    {"id": 1, "image_path": 'assets/images/firstbanner.jpg'},
    {"id": 2, "image_path": 'assets/images/secondbanner.jpg'},
    {"id": 3, "image_path": 'assets/images/thirdbanner.jpg'},
  ];

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }


  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    loadDemoProducts();
    loadCartItems();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void onSearchPressed() {
    final String searchQuery = searchController.text;
  }

  void loadDemoProducts() {
    products.value = [
      Product(
        id: '1',
        name: 'Cargo Pants',
        price: 900,
        rating: 4.8,
        imageAsset: 'assets/images/cargos.jpg',
      ),
      Product(
        id: '2',
        name: 'Sundress',
        price: 999.99,
        rating: 4.7,
        imageAsset: 'assets/images/sundress.jpg',
      ),
      Product(
        id: '3',
        name: 'Basic Shirt',
        price: 700,
        rating: 4.6,
        imageAsset: 'assets/images/shirt.jpg',
      ),
      Product(
        id: '4',
        name: 'Jeans',
        price: 1500,
        rating: 4.9,
        imageAsset: 'assets/images/jeans.jpg',
      ),
      Product(
        id: '5',
        name: 'Playsuit',
        price: 1100,
        rating: 4.5,
        imageAsset: 'assets/images/playsuit.jpg',
      ),
      Product(
        id: '6',
        name: 'Jacket',
        price: 800,
        rating: 4.5,
        imageAsset: 'assets/images/jacket.jpg',
      ),
    ];
  }

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
    backgroundColor: Color.fromARGB(255, 232, 252, 243), 
    colorText: Color.fromARGB(255, 15, 43, 16), 
  );
}


  void loadCartItems() {
    var savedItems = box.read<List>('cartItems') ?? [];
    cartItems.value = savedItems.map((item) => CartItem.fromJson(item)).toList();
  }

  void saveCartItems() {
    box.write('cartItems', cartItems.map((item) => item.toJson()).toList());
  }
}

class Product {
  final String id;
  final String name;
  final double price;
  final double rating;
  final String imageAsset;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.imageAsset,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'rating': rating,
      'imageAsset': imageAsset,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      rating: json['rating'],
      imageAsset: json['imageAsset'],
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