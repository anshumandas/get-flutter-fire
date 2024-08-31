import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Firebase
final firestore = FirebaseFirestore.instance;
final firebaseStorage = FirebaseStorage.instance;

// Database References
final bannersRef = firestore.collection('banners');
final categoriesRef = firestore.collection('categories');
final couponsRef = firestore.collection('coupons');
final productsRef = firestore.collection('products');
final settingsRef = firestore.collection('settings');
final usersRef = firestore.collection('users');

// Development Mode
const bool development = true;
