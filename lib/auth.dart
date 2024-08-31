import 'package:budget_worker/Dashboard.dart';
import 'package:budget_worker/showSnacBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'FirebaseFunctions.dart';
import 'LoginScreen.dart';

class Auth{
  static signupUser(String email , String password , String name, String lastname, String contact ,BuildContext context) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirestoreServices.saveUser(name,lastname, email, contact , userCredential.user!.uid);
      showSnacBar(context, "Registration Successfull !");
    }on FirebaseAuthException catch (e){
      if(e.code == 'weak-password'){
        showSnacBar(context, "Password provided is too weak");
      }
      else if(e.code == 'email-already-in-use'){
        showSnacBar(context, "Email provided already exists");
      }
    }catch (e){
      showSnacBar(context, e.toString());
    }
  }

  static signinUser(String email , String password , BuildContext context) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      showSnacBar(context, "Login Successfull !");
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
    }on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found'){
        showSnacBar(context, "No user found with this email");
      }
      else if(e.code == 'wrong-password'){
        showSnacBar(context, "Password did not match");
      }
    }
  }
  static resetPassword(String email , BuildContext context) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email);
    showSnacBar(context, "Password request email has been sent to your account ");
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
  static String? getUid() {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid.toString();
    return uid;
  }
}