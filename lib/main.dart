import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:streakzy/utils/constants/colors.dart';
import 'package:streakzy/utils/theme/theme.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/middleware/authentication_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  //widgetbinding
  // var widgetsFlutterBinding;
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  //Getx Local Storage
  await GetStorage.init();

  //Splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

//initialize firebase
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform).then(
  (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );
  runApp(const App());
}
