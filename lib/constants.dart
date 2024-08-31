import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Firebase Instance
final db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
final functions = FirebaseFunctions.instance;
final firebaseStorage = FirebaseStorage.instance;

// Database References
final usersRef = db.collection('users');

// Development
const development = true;
