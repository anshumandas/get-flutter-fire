import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductsController extends GetxController {
  final products = <Product>[].obs;
  final selectedCategory = 'All'.obs;
  final cartItems = <CartItem>[].obs;
  final box = GetStorage();

  final currentIndex = 0.obs;
  final CarouselController carouselController = CarouselController();
  final List<Map<String, dynamic>> imageList = [
    {"id": 1, "image_path": 'assets/images/banner1.png'},
    {"id": 2, "image_path": 'assets/images/banner2.png'},
    {"id": 3, "image_path": 'assets/images/banner3.png'},
  ];

  @override
  void onInit() {
    super.onInit();
    loadDemoProducts();
    loadCartItems();
  }

  void loadDemoProducts() {
    products.value = [
      Product(
        id: '1',
        name: 'AirPods Pro',
        price: 249.99,
        rating: 4.8,
        imageUrl: 'https://www.rollingstone.com/wp-content/uploads/2022/09/Apple-AirPods-Pro-2nd-gen-hero-220907.jpg',
        category: 'AirPods',
      ),
      Product(
        id: '2',
        name: 'MacBook Air',
        price: 999.99,
        rating: 4.7,
        imageUrl: 'https://www.buyitdirect.ie/Images/A2MPXR2BA_3_Supersize.jpg?v=4',
        category: 'Laptop',
      ),
      Product(
        id: '3',
        name: 'Sony WH-1000XM4',
        price: 349.99,
        rating: 4.6,
        imageUrl: 'https://i5.walmartimages.com/seo/Sony-WH-CH520-Wireless-Bluetooth-Headphones-with-Microphone-Black_7fc77b5b-a396-41f0-977c-a37b803215aa.6d6b6c556145d4bf17a77cd10b3e9473.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF',
        category: 'Headphones',
      ),
      Product(
        id: '4',
        name: 'iPhone 13 Pro',
        price: 999.99,
        rating: 4.9,
        imageUrl: 'https://www.aptronixindia.com/media/catalog/product/i/p/iphone_13_green_pdp_image_position-1a_avail__en-in-2_3.jpg',
        category: 'Phones',
      ),
      Product(
        id: '5',
        name: 'iPad Air',
        price: 599.99,
        rating: 4.5,
        imageUrl: 'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/ipad-10th-gen-finish-select-202212-blue-wifi_FMT_WHH?wid=1280&hei=720&fmt=p-jpg&qlt=95&.v=1670856032314',
        category: 'Tablets',
      ),
    ];
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

  void addDemoProduct() {
    products.add(
      Product(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'Product added on: ${DateTime.now().toString()}',
        price: 0.0,
        rating: 0.0,
        imageUrl: '',
        category: 'New',
      ),
    );
  }

  void addToCart(Product product) {
    var existingItem = cartItems.firstWhereOrNull((item) => item.product.id == product.id);
    if (existingItem != null) {
      existingItem.quantity.value++;
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }
    saveCartItems();
    Get.snackbar('Added to Cart', '${product.name} has been added to your cart.');
  }

  void loadCartItems() {
    var savedItems = box.read<List>('cartItems') ?? [];
    cartItems.value = savedItems.map((item) => CartItem.fromJson(item)).toList();
  }

  void saveCartItems() {
    box.write('cartItems', cartItems.map((item) => item.toJson()).toList());
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }

}

class Product {
  final String id;
  final String name;
  final double price;
  final double rating;
  final String imageUrl;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.category,
  });

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
      id: json['id'],
      name: json['name'],
      price: json['price'],
      rating: json['rating'],
      imageUrl: json['imageUrl'],
      category: json['category'],
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