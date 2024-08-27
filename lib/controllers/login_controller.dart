import 'package:bucketlist/screens/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {

static Future<void> loginaccount({required BuildContext context, required String email, required String Password})
  async {
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email ,password: Password);
    print("Account created sucessfully");

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
        return Mainscreen();
    }
    ),(route)
    {
      return false;
    }
    );
    }
    catch (e)
    {
      SnackBar messageSnackBar= SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);
      print(e);
    }
  }
}