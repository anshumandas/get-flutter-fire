import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final String productId;
  // Local product data
  final Map<String, Map<String, dynamic>> products = {
    '1': {
      'name': 'Chanel Perfume for Women',
      'price': 2000.0,
      'sellingPrice': 1800.0,
      'description': 'Luxury Chanel Perfume.',
      'productImage': [
        'https://i.ibb.co/PQW82z4/1.png',
        'https://via.placeholder.com/150x150?text=Image+1',
        'https://via.placeholder.com/150x150?text=Image+2',
      ]
    },
    '2': {
      'name': 'Men\'s Exclusive Perfume',
      'price': 4000.0,
      'sellingPrice': 3500.0,
      'description': 'Exclusive Men\'s Perfume.',
      'productImage': [
        'https://i.ibb.co/n1nG68M/4.png',
        'https://via.placeholder.com/150x150?text=Image+1',
        'https://via.placeholder.com/150x150?text=Image+2',
      ]
    },
    '3': {
      'name': 'Unisex Perfume',
      'price': 5600.0,
      'sellingPrice': 5000.0,
      'description': 'Versatile unisex fragrance.',
      'productImage': [
        'https://i.ibb.co/WgntTLS/3.png',
        
      ]
    },
    '4': {
      'name': 'Elegant Women\'s Perfume',
      'price': 7600.0,
      'sellingPrice': 7000.0,
      'description': 'Elegant fragrance for women.',
      'productImage': [
        'https://i.ibb.co/72h1Zzp/2.png',
        
      ]
    },
    '5': {
      'name': 'Luxury Night Perfume',
      'price': 3000.0,
      'sellingPrice': 2700.0,
      'description': 'Luxurious night fragrance.',
      'productImage': [
        'https://i.ibb.co/NVjdssC/5.png'
        
      ]
    },
    '6': {
      'name': 'Fresh Citrus Perfume',
      'price': 1500.0,
      'sellingPrice': 1300.0,
      'description': 'Refreshing citrus scent.',
      'productImage': [
        'https://i.ibb.co/GnphSbv/6.png'
        
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
    Get.log('ProductDetailsController created with id: $productId');
    fetchProductDetails();
  }

  // Method to fetch product details
  void fetchProductDetails() {
    isLoading.value = true;
    // Simulate a delay for fetching data
    Future.delayed(const Duration(seconds: 1), () {
      if (products.containsKey(productId)) {
        productDetails.value = products[productId]!;
      } else {
        productDetails.value = {};
      }
      isLoading.value = false;
    });
  }

  @override
  void onClose() {
    Get.log('ProductDetailsController close with id: $productId');
    super.onClose();
  }
}
