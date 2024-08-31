//Accommodation Details Controller

import 'package:get/get.dart';
import '../../../../models/product_details.dart';
import '../../../routes/app_pages.dart';
import '../../cart/controllers/cart_controller.dart';

class ProductDetailsController extends GetxController {
  final RxString productId = ''.obs;
  final RxString accommodationName = ''.obs;
  final RxString accommodationLocation = ''.obs;
  final RxDouble accommodationPrice = 0.0.obs;
  final RxString accommodationDescription = ''.obs;
  final RxList<String> additionalImages = <String>[].obs;

  final List<Product> products = [
    Product(
        id: '1',
        name: 'Fiona Apartment',
        location: 'Powai Mumbai',
        price: 2200,
        imageAsset: 'assets/Fiona/F1.jpeg',
        description: 'This is a Graceful, Vivid and Luxurious apartment located in Hiranandani Regent Hill, Powai. It is in an upscale neighborhood close to various offices, supermarkets , trendy cafes and restaurants. Conveniently located at just a 25 min drive from the International Airport.',
        additionalImages:['assets/Fiona/F1.jpeg','assets/Fiona/F2.jpeg','assets/Fiona/F3.jpeg','assets/Fiona/F4.png']
    ),
    Product(
        id: '2',
        name: 'Historia Apartment',
        location: 'Goa',
        price: 4300,
        imageAsset: 'assets/Historia/H1.jpeg',
        description: 'Studio 109 comes with exquisitely set living room, kitchen and bathrooms in the heart of Goa. Situated in Arpora which is right in centre of Anjuna and BAGA .The place has all the amenities specifically the pool . Located in one of the most plush and urban areas of North Goa, the home offers beautiful experience of urban and country side living.',
        additionalImages: ['assets/Historia/H1.jpeg','assets/Historia/H2.jpeg','assets/Historia/H3.jpeg']
    ),
    Product(
        id: '3' ,
        name: 'Plush Stays' ,
        location: 'Khar,Mumbai' ,
        price: 3800,
        imageAsset: 'assets/Plush/P1.jpeg',
        description: 'Welcome to Milo B from The Bombay Home Company, this is one listing from over 40 different options available with us.All our apartments come with the same standard amenities.Enjoy a stylish design experience with us, we have taken this up as a passion project and done up the place from scratch, taking special care to provide a comfy abode that matches international standards and expectations of the discerning traveler.',
        additionalImages: ['assets/Plush/P1.jpeg','assets/Plush/P2.jpeg','assets/Plush/P3.jpeg','assets/Plush/P4.jpeg']
    ),
    Product(
        id: '4',
        name: 'Flora Inn',
        location: 'Lonavala',
        price: 5000,
        imageAsset: 'assets/Flora/FL1.jpeg',
        description: 'The Cottage is made out of total wood which give a very rustic vibe. It has smart TV with Netflix prime video hotstar any other streaming channels for your late night binges . We have a huge private balcony for your evening teas and early mornings. The cottage has a mini fridge to store your drinks . A kettle and tea/coffee supply if you would like to make your own tea/coffee. Our place is more for nature lovers who want to immersed into total silence and surrounded by forest area',
        additionalImages: ['assets/Flora/FL1.jpeg','assets/Flora/FL2.jpeg','assets/Flora/FL3.jpeg']
    ),
    Product(
        id: '5',
        name: 'Stay Vista',
        location: 'Thane',
        price: 2200,
        imageAsset: 'assets/Stay/S1.jpeg',
        description: 'Welcome to our stunning AirBnB, where the carefully chosen decor exudes a sense of calmness, allowing you to unwind and escape from your daily routine.Step outside to find a picturesque creek vista, lush greenery and an exquisite sky, reminding that you have indeed found your blissful escape.If you\'re seeking a romantic getaway, an earned break from the daily grind, or simply a beautiful escape for some introspection, our AirBnB promises to be the perfect sanctuary',
        additionalImages: ['assets/Stay/S1.jpeg','assets/Stay/S2.jpeg']
    ),
    Product(
        id: '6',
        name: 'Eva Studios',
        location: 'Mumbai',
        price: 1200,
        imageAsset: 'assets/Eva/E1.jpeg',
        description: 'Experience comfort and convenience at our fully equipped studio with excellent views. Perfectly situated near Nanavati Hospital, Mithibai/NM Colleges, and Vile Parle Station, the place is also just half an hour away from Mumbai International Airport. Our apartment is located just off the main SV Road. Whether you\'re here for a short stay or a long-term visit, you\'ll find everything you need for a relaxing and productive time.',
        additionalImages: ['assets/Eva/E1.jpeg','assets/Eva/E2.jpg'])

  ];

  ProductDetailsController(String id) {
    productId.value = id;
  }


  @override
  void onInit() {
    super.onInit();
    // Load the accommodation details using the productId
    loadAccommodationDetails(productId.value);
  }

  void loadAccommodationDetails(String id) {
    // Find the product by id
    final product = products.firstWhere((product) => product.id == id, orElse: () => throw Exception('Product not found'));

    // Set the details into the reactive variables
    accommodationName.value = product.name;
    accommodationLocation.value = product.location;
    accommodationPrice.value = product.price;
    accommodationDescription.value = product.description;
    additionalImages.value = product.additionalImages;
  }

  // Method to add the product to the cart
  void addToCart() {
    final cartController = Get.find<CartController>();

    // Find the current product based on the ID
    final product = products.firstWhere((product) => product.id == productId.value);

    // Add the product to the cart
    cartController.addProductToCart(product);
  }
  }




