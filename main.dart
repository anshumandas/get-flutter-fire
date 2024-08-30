import 'package:e_book_marketplace/Config/Themes.dart';
import 'package:e_book_marketplace/Pages/SplacePage/SplacePage.dart';
import 'package:e_book_marketplace/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E Book',
      theme: lightTheme,
      //home: const Welcomepage(),
      home: SplacePage(),
    );
  }
}
