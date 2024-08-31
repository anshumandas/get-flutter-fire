import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_flutter_fire/enums/enums.dart';
import 'package:get_flutter_fire/models/category_model.dart';
import 'package:get_flutter_fire/models/product_model.dart';
import 'package:get_flutter_fire/models/seller_model.dart';
import 'package:get_flutter_fire/models/user_model.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import 'package:uuid/uuid.dart';

class SellerController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;

  String get sellerId {
    final user = authService.userID;
    return "seller_$user";
  }

  Future<void> assignSellerRole(UserModel user) async {
    if (user.userType != UserType.seller) {
      return;
    }

    SellerModel seller = SellerModel(
      id: user.id,
      name: user.name,
      phoneNumber: user.phoneNumber,
      email: user.email,
      isBusiness: user.isBusiness,
      businessName: user.businessName,
      businessType: user.businessType,
      gstNumber: user.gstNumber,
      panNumber: user.panNumber,
      userType: UserType.seller,
      defaultAddressID: user.defaultAddressID,
      createdAt: user.createdAt,
      lastSeenAt: user.lastSeenAt,
      sellerId: sellerId,
      products: [],
    );

    await FirebaseFirestore.instance
        .collection('sellers')
        .doc(sellerId)
        .set(seller.toMap());
  }

  Future<void> onUserRoleChanged(UserModel user) async {
    if (user.userType == UserType.seller) {
      await assignSellerRole(user);
    }
  }

  Future<void> fetchSellerProducts() async {
    isLoading.value = true;
    try {
      FirebaseFirestore.instance
          .collection('products')
          .where('sellerId', isEqualTo: sellerId)
          .snapshots()
          .listen((event) {
        final fetchedProducts =
            event.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
        products.assignAll(fetchedProducts);
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addSellerProduct({
    required String name,
    required String description,
    required int unitPrice,
    required int remainingQuantity,
    required int unitWeight,
    required String categoryID,
    required List<String> images,
  }) async {
    isLoading.value = true;
    try {
      final productId = const Uuid().v4();
      final newProduct = ProductModel(
        id: productId,
        categoryID: categoryID,
        name: name,
        description: description,
        unitPrice: unitPrice,
        remainingQuantity: remainingQuantity,
        unitWeight: unitWeight,
        images: images,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        sellerId: sellerId,
      );

      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .set(newProduct.toMap());

      Get.snackbar('Success', 'Product added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      return querySnapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories: $e');
      return [];
    }
  }

  Future<void> updateSellerProduct({
    required String id,
    required String name,
    required String description,
    required int unitPrice,
    required int remainingQuantity,
    required int unitWeight,
    required List<String> images,
  }) async {
    isLoading.value = true;
    try {
      final updatedProduct = ProductModel(
        id: id,
        categoryID: 'default_category',
        name: name,
        description: description,
        unitPrice: unitPrice,
        remainingQuantity: remainingQuantity,
        unitWeight: unitWeight,
        images: images,
        isActive: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        sellerId: sellerId,
      );

      await FirebaseFirestore.instance
          .collection('products')
          .doc(id)
          .update(updatedProduct.toMap());

      Get.snackbar('Success', 'Product updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteSellerProduct(String productId) async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .delete();
      Get.snackbar('Success', 'Product deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete product: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
