import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/settings/controllers/settings_controller.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../models/product.dart'; // Ensure this path matches your project structure
// import '../../../../controllers/settings_controller.dart'; // Import SettingsController

class ProductsController extends GetxController {
  final products = <Product>[].obs;
  final filteredProducts = <Product>[].obs;
  final selectedCategory = ''.obs;
  final cartItems = <CartItem>[].obs;
  final trendingProducts = <Product>[].obs;
  final box = GetStorage(); // Initialize GetStorage for saving cart items
  final filters = ['All', 'Male', 'Female', 'Unisex'].obs;

  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  void onInit() {
    super.onInit();
    loadDemoProducts();
    applyFilter();
  }

  // Method to load demo products
  void loadDemoProducts() {
    products.assignAll([
      Product(
        name: 'Chanel Perfume for Women',
        id: '1',
        productImage: 'https://i.ibb.co/PQW82z4/1.png',
        price: 2000.0,
        description: 'Luxury Chanel Perfume.',
        category: 'Women',
      ),
      Product(
        name: 'Men\'s Exclusive Perfume',
        id: '2',
        productImage: 'https://i.ibb.co/n1nG68M/4.png',
        price: 4000.0,
        description: 'Exclusive Men\'s Perfume.',
        category: 'Men',
      ),
      Product(
        name: 'Unisex Perfume',
        id: '3',
        productImage: 'https://i.ibb.co/WgntTLS/3.png',
        price: 5600.0,
        description: 'Versatile unisex fragrance.',
        category: 'Unisex',
      ),
      Product(
        name: 'Elegant Women\'s Perfume',
        id: '4',
        productImage: 'https://i.ibb.co/72h1Zzp/2.png',
        price: 7600.0,
        description: 'Elegant fragrance for women.',
        category: 'Women',
      ),
      Product(
        name: 'Luxury Night Perfume',
        id: '5',
        productImage: 'https://i.ibb.co/NVjdssC/5.png',
        price: 3000.0,
        description: 'Luxurious night fragrance.',
        category: 'Unisex',
      ),
      Product(
        name: 'Fresh Citrus Perfume',
        id: '6',
        productImage: 'https://i.ibb.co/GnphSbv/6.png',
        price: 1500.0,
        description: 'Refreshing citrus scent.',
        category: 'Unisex',
      ),
    ]);
    applyFilter();
  }

  // Method to apply filters based on selected category and persona
  void applyFilter() {
    // Get selected persona from SettingsController
    final persona = settingsController.selectedPersona.value;

    if (persona == null) {
      // No persona selected, show all products
      if (selectedCategory.isEmpty || selectedCategory.value == 'All') {
        filteredProducts.assignAll(products);
      } else {
        filteredProducts.assignAll(products.where((product) => product.category == selectedCategory.value).toList());
      }
    } else {
      // Persona selected, filter products based on persona
      final isFemalePersona = persona.name == 'Solitaire Female';
      final filteredByPersona = products.where((product) {
        if (isFemalePersona) {
          return product.category == 'Women' || product.category == 'Unisex';
        } else {
          return product.category == 'Men' || product.category == 'Unisex';
        }
      }).toList();

      // Apply category filter if not 'All'
      if (selectedCategory.isEmpty || selectedCategory.value == 'All') {
        filteredProducts.assignAll(filteredByPersona);
      } else {
        filteredProducts.assignAll(filteredByPersona.where((product) => product.category == selectedCategory.value).toList());
      }
    }
  }

  @override
  void onClose() {
    Get.printInfo(info: 'Products: onClose');
    super.onClose();
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    applyFilter();
  }
  // Method to load demo products from somewhere
  void loadDemoProductsFromSomeWhere() {
    loadDemoProducts(); // Call the actual method to load products
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
