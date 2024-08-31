import 'package:carousel_slider/carousel_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/models/banner_model.dart';
import 'package:get_flutter_fire/models/category_model.dart';
import 'package:get_flutter_fire/models/product_model.dart';

class HomeController extends GetxController {
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxBool isLoading = true.obs;
  RxInt currentCarouselIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    isLoading(true);
    try {
      final cartController = Get.put(CartController());
      final authController = Get.put(AuthController());
      await Future.wait([
        fetchBanners(),
        fetchCategories(),
        fetchProducts(),
        cartController.fetchCartData(authController.user!.id),
      ]);
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching data');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchBanners() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('banners')
          .where('isActive', isEqualTo: true)
          .get();

      List<BannerModel> fetchedBanners = snapshot.docs.map((doc) {
        return BannerModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      banners.value = fetchedBanners;
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching banners');
      rethrow;
    }
  }

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      List<CategoryModel> fetchedCategories = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CategoryModel.fromMap(data);
      }).toList();

      categories.value = fetchedCategories;
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching categories');
      rethrow;
    }
  }

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('products').get();

      List<ProductModel> fetchedProducts = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ProductModel.fromMap(data);
      }).toList();

      products.value = fetchedProducts;
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching products');
      rethrow;
    }
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentCarouselIndex.value = index;
  }
}
