import 'package:get_flutter_fire/Screens/splashscreen.dart';
import 'package:get_flutter_fire/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  

    runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(    
      home: const SplashScreen(),
      theme: ThemeData.light(useMaterial3: true) );

  }
}