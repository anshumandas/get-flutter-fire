import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/order_controller.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/product_controller.dart';
import 'package:get_flutter_fire/app/modules/profile/controllers/address_controller.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import 'package:get_flutter_fire/constants.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/theme/assets.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupFlutterNotifications() async {
  channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupFlutterNotifications();
  if (development) {
    functions.useFunctionsEmulator('localhost', 5001);
    auth.useAuthEmulator('localhost', 9099);
    db.useFirestoreEmulator('localhost', 8080);
  }

  _configLoading();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sheru',
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
      initialBinding: BindingsBuilder(
        () {
          // TODO: Handle binding later
          Get.put(AuthService());
          Get.put(AuthController());
          Get.put(AddressController());
          Get.put(CartController());
          Get.put(OrderController());
          Get.put(ProductController());
        },
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.colorWhite),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
    ),
  );
}

_configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorWidget = Image.asset(rhombusLoader, height: 150)
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = AppTheme.colorBlack.withOpacity(0.7)
    ..backgroundColor = Colors.transparent
    ..textColor = AppTheme.colorWhite
    ..indicatorColor = AppTheme.colorWhite
    ..userInteractions = false
    ..boxShadow = [];
}
