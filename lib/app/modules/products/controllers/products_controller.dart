import 'package:get/get.dart';
import '../../../../models/product.dart';

class ProductsController extends GetxController {
  final products = <Product>[].obs;
  final filteredProducts = <Product>[].obs;
  final selectedCategory = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDemoProducts();
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
      ),
      Product(
        name: 'Jeans',
        id: '2',
        productImage: 'https://i.ibb.co/ZK6vYDx/Jeans.jpg',
        price: 40.0,
        brandName: 'Brand B',
        category: 'Male',
        description: 'Stylish blue jeans for everyday wear.',
      ),
      Product(
        name: 'Women Jeans',
        id: '3',
        productImage: 'https://i.ibb.co/V3CBYKz/Jeans_F.jpg',
        price: 60.0,
        brandName: 'Brand C',
        category: 'Female',
        description: 'Stylish blue jeans for Women.',
      ),
      Product(
        name: 'Sneakers',
        id: '4',
        productImage: 'https://i.ibb.co/XkVQNJp/Sneakers.jpg',
        price: 80.0,
        brandName: 'Brand D',
        category: 'Unisex',
        description: 'Comfortable sneakers for active lifestyle.',
      ),
      Product(
        name: 'Dress',
        id: '5',
        productImage: 'https://i.ibb.co/d0gWMwX/Dress.jpg',
        price: 50.0,
        brandName: 'Brand E',
        category: 'Female',
        description: 'Elegant dress for special occasions.',
      ),
      Product(
        name: 'Sunglasses',
        id: '6',
        productImage: 'https://i.ibb.co/XttT0xh/Sunglasses.jpg',
        price: 25.0,
        brandName: 'Brand F',
        category: 'Unisex',
        description: 'Stylish sunglasses for sunny days.',
      ),
    ]);
    applyFilter();
  }

  void applyFilter() {
    if (selectedCategory.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(products.where((product) => product.category == selectedCategory.value).toList());
    }
  }

  void setCategory(String category) {
    selectedCategory.value = category;
    applyFilter();
  }
}
