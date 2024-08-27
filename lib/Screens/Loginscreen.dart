import 'package:bucketlist/controllers/login_controller.dart';
import 'package:bucketlist/screens/signupscreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<LoginScreen> {

  var userForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController Password = TextEditingController();

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar( title:const Text("Login")),
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
              decoration: const InputDecoration(label: Text("E-mail"))),
            const SizedBox(height: 20,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: Password,
              validator: (value) {
                if(value== null || value.isEmpty)
                {
                  return("Password is required");
                }
              },
              obscureText:true, decoration: const InputDecoration(label: Text("Password")),),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              if (userForm.currentState!.validate()){
                LoginController.loginaccount(context: context, email: email.text, Password: Password.text);
              }
            }, child: const Text("Login")),
            const SizedBox(height: 20),
            Row(
              children: [const Text("Dont have an account?"),
              const SizedBox(width: 20),
              InkWell
              (
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return const Signupscreen();}));
                },
                child: const Text("Signup here",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
              ],
            )
          ],
        ),
      ),
    ),
    
    );
  }
}