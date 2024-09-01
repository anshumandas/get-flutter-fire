// ignore_for_file: inference_failure_on_instance_creation

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import '../home_screen.dart';
import '../login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

  class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PlanBuddy",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.indigo,
      ),
      home: _auth.currentUser != null ? HomeScreen( ) : LoginScreen(),

    );
  }
}
 
