import 'package:bucketlist/controllers/signup_controller.dart';
import 'package:flutter/material.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Signupscreen> {

  var userForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController Password = TextEditingController();

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar( title:Text("signup screen")),
    body: Form(
      key: userForm,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: email,
              validator: (value) {
                if(value== null || value.isEmpty)
                {
                  return("Email is required");
                }
              },
              decoration: InputDecoration(label: Text("E-mail"))),
            SizedBox(height: 20,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: Password,
              validator: (value) {
                if(value== null || value.isEmpty)
                {
                  return("Password is required");
                }
              },
              obscureText:true, decoration: InputDecoration(label: Text("Password")),),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              if (userForm.currentState!.validate()){
                SignupController.createaccount(context: context, email: email.text, Password: Password.text);
              }
            }, child: Text("Create Account"))
          ],
        ),
      ),
    ),
    );
  }
}