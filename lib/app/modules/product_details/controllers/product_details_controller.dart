import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final String productId;

  // Local product data
  final Map<String, Map<String, dynamic>> products = {
    '1': {
      'name': 'T-Shirt',
      'price': 20.0,
      'sellingPrice': 18.0,
      'description': 'A comfortable cotton T-Shirt.',
      'productImage': [
        'https://i.ibb.co/9wh4mFv/t-shirt.jpg',
        'https://via.placeholder.com/150x150?text=Image+1',
        'https://via.placeholder.com/150x150?text=Image+2',
      ]
    },
    '2': {
      'name': 'Jeans',
      'price': 40.0,
      'sellingPrice': 35.0,
      'description': 'Stylish denim jeans.',
      'productImage': [
        'https://i.ibb.co/ZK6vYDx/Jeans.jpg',
        'https://via.placeholder.com/150x150?text=Image+1',
        'https://via.placeholder.com/150x150?text=Image+2',
      ]
    },
    '3': {
      'name': 'Jeans',
      'price': 60.0,
      'sellingPrice': 50.0,
      'description': 'Stylish denim jeans for Women.',
      'productImage': [
        'https://i.ibb.co/V3CBYKz/Jeans_F.jpg',
        'https://via.placeholder.com/150x150?text=Image+1',
        'https://via.placeholder.com/150x150?text=Image+2',
      ]
    },
    '4': {
      'name': 'Sneakers',
      'price': 80.0,
      'sellingPrice': 70.0,
      'description': 'Comfortable and durable sneakers.',
      'productImage': [
        'https://i.ibb.co/XkVQNJp/Sneakers.jpg',
        'https://via.placeholder.com/150x150?text=Image+1',
        'https://via.placeholder.com/150x150?text=Image+2',
      ]
    },
    '5': {
      'name': 'Dress',
      'price': 50.0,
      'sellingPrice': 45.0,
      'description': 'Elegant dress for any occasion.',
      'productImage': [
        'https://i.ibb.co/d0gWMwX/Dress.jpg',
        'https://via.placeholder.com/150x150?text=Image+1',
        'https://via.placeholder.com/150x150?text=Image+2',
      ]
    },
    '6': {
      'name': 'Sunglasses',
      'price': 25.0,
      'sellingPrice': 20.0,
      'description': 'Stylish sunglasses for sunny days.',
      'productImage': [
        'https://i.ibb.co/XttT0xh/Sunglasses.jpg',
        'https://via.placeholder.com/150x150?text=Image+1',
        'https://via.placeholder.com/150x150?text=Image+2',
      ]
    },
  };

  // Observable product details and loading status
  var productDetails = {}.obs;
  var isLoading = true.obs;

  ProductDetailsController(this.productId);

  @override
  void onInit() {
    super.onInit();
    fetchProductDetails();
  }

  void fetchProductDetails() {
    // Simulate a delay for fetching data
    Future.delayed(Duration(seconds: 1), () {
      final product = products[productId];
      if (product != null) {
        productDetails.value = product;
      } else {
        Get.snackbar('Error', 'Product not found');
      }
      isLoading.value = false;
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
