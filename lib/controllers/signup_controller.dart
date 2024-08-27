
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_flutter_fire/Screens/mainscreen.dart';

class SignupController {

static Future<void> createaccount({required BuildContext context, required String email, required String Password})
  async {
    try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email ,password: Password);
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