import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Firebase Instance
final db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final functions = FirebaseFunctions.instance;

// Database References
final usersRef = firestore.collection('users');

// Development
const bool development = !bool.fromEnvironment('dart.vm.product');
