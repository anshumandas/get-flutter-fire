import 'package:get/get.dart';
import 'package:get_flutter_fire/models/products_admin.dart';

class ProductsAdminController extends GetxController {
  // List to store products
  final RxList<Product> products = <Product>[].obs;

  // Method to fetch all products (for now, we will simulate with a list of sample data)
  void fetchProducts() {
    // Simulated fetching of products, replace this with actual API calls
    List<Product> fetchedProducts = [
      Product(
        id: '1',
        name: 'Laptop',
        description: 'A high-performance laptop',
        price: 1200.0,
        imageUrl: 'https://example.com/laptop.png',
      ),
      Product(
        id: '2',
        name: 'Smartphone',
        description: 'A latest-gen smartphone',
        price: 800.0,
        imageUrl: 'https://example.com/smartphone.png',
      ),
    ];

    // Update the products list
    products.assignAll(fetchedProducts);
  }

  // Method to add a new product
  void addProduct(Product product) {
    // Add the new product to the list
    products.add(product);
  }

  // Method to update an existing product
  void updateProduct(String productId, Product updatedProduct) {
    int index = products.indexWhere((product) => product.id == productId);
    if (index != -1) {
      products[index] = updatedProduct;
    }
  }

  // Method to delete a product by ID
  void deleteProduct(String productId) {
    products.removeWhere((product) => product.id == productId);
  }

  // Optional: Method to find a product by ID
  Product? findProductById(String productId) {
    return products.firstWhereOrNull((product) => product.id == productId);
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch products when the controller is initialized
    fetchProducts();
  }
}
