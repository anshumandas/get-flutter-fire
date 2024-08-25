import 'package:get/get.dart';
import '../../../../models/product.dart'; // Ensure this path matches your project structure

class ProductsController extends GetxController {
  final products = <Product>[].obs;
  final filteredProducts = <Product>[].obs;
  final selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDemoProductsFromSomeWhere();
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
        sellingPrice: 1800.0,
        description: 'Luxury Chanel Perfume.',
        category: 'Women',
      ),
      Product(
        name: 'Men\'s Exclusive Perfume',
        id: '2',
        productImage: 'https://i.ibb.co/n1nG68M/4.png',
        price: 4000.0,
        sellingPrice: 3500.0,
        description: 'Exclusive Men\'s Perfume.',
        category: 'Men',
      ),
      Product(
        name: 'Unisex Perfume',
        id: '3',
        productImage: 'https://i.ibb.co/WgntTLS/3.png',
        price: 5600.0,
        sellingPrice: 5000.0,
        description: 'Versatile unisex fragrance.',
        category: 'Unisex',
      ),
      Product(
        name: 'Elegant Women\'s Perfume',
        id: '4',
        productImage: 'https://i.ibb.co/72h1Zzp/2.png',
        price: 7600.0,
        sellingPrice: 7000.0,
        description: 'Elegant fragrance for women.',
        category: 'Women',
      ),
      Product(
        name: 'Luxury Night Perfume',
        id: '5',
        productImage: 'https://i.ibb.co/NVjdssC/5.png',
        price: 3000.0,
        sellingPrice: 2700.0,
        description: 'Luxurious night fragrance.',
        category: 'Unisex',
      ),
      Product(
        name: 'Fresh Citrus Perfume',
        id: '6',
        productImage: 'https://i.ibb.co/GnphSbv/6.png',
        price: 1500.0,
        sellingPrice: 1300.0,
        description: 'Refreshing citrus scent.',
        category: 'Unisex',
      ),
    ]);
    applyFilter();
  }

  // Method to load demo products from somewhere
  void loadDemoProductsFromSomeWhere() {
    loadDemoProducts(); // Call the actual method to load products
  }

  @override
  void onReady() {
    super.onReady();
    loadDemoProductsFromSomeWhere();
  }

  // Method to filter products based on selected category
  void applyFilter() {
    if (selectedCategory.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(products.where((product) => product.category == selectedCategory.value).toList());
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
}
