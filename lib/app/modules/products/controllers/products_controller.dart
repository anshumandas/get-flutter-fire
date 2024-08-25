import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../models/product.dart';  // Update the import path if needed

class ProductsController extends GetxController {
  final products = <Product>[].obs;
  final filteredProducts = <Product>[].obs;
  final selectedCategory = ''.obs;
  final cartItems = <CartItem>[].obs;
  final trendingProducts = <Product>[].obs;  // Add this line for trending products
  final box = GetStorage();  // Initialize GetStorage for saving cart items

  final filters = ['All', 'Male', 'Female', 'Unisex'].obs;

  @override
  void onInit() {
    super.onInit();
    loadDemoProducts();
    loadCartItems();  // Load saved cart items
    applyFilter();
  }

  void loadDemoProducts() {
    products.assignAll([
      Product(
        name: 'T-Shirt',
        id: '1',
        productImage: 'https://i.ibb.co/9wh4mFv/t-shirt.jpg',
        price: 20.0,
        brandName: 'Brand A',
        category: 'Male',
        description: 'A comfortable cotton T-Shirt.',
        size: 'M',  
      ),
      Product(
        name: 'Jeans',
        id: '2',
        productImage: 'https://i.ibb.co/ZK6vYDx/Jeans.jpg',
        price: 40.0,
        brandName: 'Brand B',
        category: 'Male',
        description: 'Stylish blue jeans for everyday wear.',
        size: '30',  
      ),
      Product(
        name: 'Women Jeans',
        id: '3',
        productImage: 'https://i.ibb.co/V3CBYKz/Jeans_F.jpg',
        price: 60.0,
        brandName: 'Brand C',
        category: 'Female',
        description: 'Stylish blue jeans for Women.',
        size: '28',  
      ),
      Product(
        name: 'Sneakers',
        id: '4',
        productImage: 'https://i.ibb.co/XkVQNJp/Sneakers.jpg',
        price: 80.0,
        brandName: 'Brand D',
        category: 'Unisex',
        description: 'Comfortable sneakers for active lifestyle.',
        size: '8',  
      ),
      Product(
        name: 'Dress',
        id: '5',
        productImage: 'https://i.ibb.co/d0gWMwX/Dress.jpg',
        price: 50.0,
        brandName: 'Brand E',
        category: 'Female',
        description: 'Elegant dress for special occasions.',
        size: 'M',  
      ),
      Product(
        name: 'Sunglasses',
        id: '6',
        productImage: 'https://i.ibb.co/XttT0xh/Sunglasses.jpg',
        price: 25.0,
        brandName: 'Brand F',
        category: 'Unisex',
        description: 'Stylish sunglasses for sunny days.',
        size: 'One Size',  
      ),
    ]);

    // Assign some products as trending
    trendingProducts.assignAll([
      products[0],  // Example: T-Shirt
      products[3],  // Example: Sneakers
    ]);

    applyFilter();
  }

  void applyFilter() {
    filteredProducts.assignAll(
      products.where((product) {
        if (selectedCategory.value.isEmpty || selectedCategory.value == 'All') {
          return true;
        }
        return product.category == selectedCategory.value;
      }).toList(),
    );
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    applyFilter();
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
