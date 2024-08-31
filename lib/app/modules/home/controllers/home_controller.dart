import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/main.dart';
import 'package:get_flutter_fire/models/banner_model.dart';
import 'package:get_flutter_fire/models/category_model.dart';
import 'package:get_flutter_fire/models/offer_model.dart';
import 'package:get_flutter_fire/models/address_model.dart';
import 'package:get_flutter_fire/models/product_model.dart';

class HomeController extends GetxController {
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<OfferModel> offers = <OfferModel>[].obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxBool isLoading = true.obs;
  RxInt currentCarouselIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchAllData();
    FirebaseMessaging.instance.getInitialMessage().then(
          (value) async {},
        );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage message) async {});

    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('launch_background'),
      ),
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        debugPrint('Notification Received : $notificationResponse');
      },
    );
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  Future<void> _fetchAllData() async {
    isLoading(true);
    try {
      final cartController = Get.put(CartController());
      final authController = Get.put(AuthController());
      await Future.wait([
        fetchBanners(),
        fetchCategories(),
        fetchOffersForUserLocation(),
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

  Future<void> fetchOffersForUserLocation() async {
    try {
      final authController = Get.find<AuthController>();
      final addressSnapshot = await FirebaseFirestore.instance
          .collection('addresses')
          .doc(authController.user!.defaultAddressID)
          .get();

      if (addressSnapshot.exists) {
        final address = AddressModel.fromMap(addressSnapshot.data()!);
        QuerySnapshot offerSnapshot = await FirebaseFirestore.instance
            .collection('offers')
            .where('city', isEqualTo: address.city)
            .get();

        List<OfferModel> fetchedOffers = offerSnapshot.docs.map((doc) {
          return OfferModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        offers.value = fetchedOffers;
      } else {
        Get.snackbar('Error', 'No address found for this user');
        throw 'No address found';
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching offers');
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

      products.value = fetchedProducts +
          fetchedProducts +
          fetchedProducts +
          fetchedProducts +
          fetchedProducts +
          fetchedProducts +
          fetchedProducts +
          fetchedProducts;
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching products');
      rethrow;
    }
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentCarouselIndex.value = index;
  }
}
