import 'package:budget_worker/HomePage.dart';
import 'package:budget_worker/ForgotPassword.dart';
import 'package:budget_worker/SignUp.dart';
import 'package:budget_worker/showSnacBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:hexcolor/hexcolor.dart';

import 'auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen ({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String email = "" , password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : HexColor('#ffe6e6'),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          reverse: true,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(35),
              height: 155,
              width: 160,
              child: Text(
                'Welcome, you have been missed !',
                style: GoogleFonts.alata(
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                  fontSize: 30,
                  color: HexColor('#0B4360'),
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Lottie.asset(
                'assets/JSON/bwLogin2.json',
                height: 270.0,
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),
            Form(
              key: formKey,
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.alata(),
                    decoration: InputDecoration(
                      prefixIcon:  Icon(Icons.alternate_email_rounded , color: HexColor('#0B4360'),),
                      labelText: "Enter Email",
                      enabledBorder: OutlineInputBorder(
                        borderSide:  BorderSide(width: 3, color: HexColor('#0B4360')),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                        return "Enter Correct Email Address";
                      }else{
                        return null;
                      }
                    },
                    onSaved: (value){
                      setState(() {
                        email = value!;
                      });
                    },
                    // controller: controller,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    obscureText: true,
                    style: GoogleFonts.alata(),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.key_outlined , color: HexColor('#0B4360'),),
                        labelText: "Enter Password",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                        )
                    ),
                    onSaved: (value){
                      setState(() {
                        password = value!;
                      });
                    },
                    // controller: controller2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      setState((){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
                      });
                    },
                    label: Text(
                      'Forgot Password ? ',
                      style: GoogleFonts.alata(
                        color: HexColor('#0B4360'),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    icon: Icon(Icons.email_outlined , color: HexColor('#0B4360'),),
                  ),
                ),
                Container(
                  height: 90.0,
                  width: 380,
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: HexColor('0B4360')),
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        //check if form data are valid,
                        // your process task ahed if all data are valid
                        formKey.currentState!.save();
                        Auth.signinUser(email, password, context);
                      }
                      else{
                        showSnacBar(context, "Error");
                      }
                      // loginUser();
                    },
                    child: Text(
                      "Verify",
                      style: GoogleFonts.alata(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(1),
                  child: const Divider(
                    color: Colors.grey,
                    height: 1,
                    thickness: 1,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(1),
                  child: TextButton(
                    onPressed: () {
                      setState((){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
                      });
                    },
                    child: Text(
                      "Don't have an account yet ? Click here",
                      style: GoogleFonts.alata(
                        color: HexColor('#0B4360'),
                      ),
                    ),
                  ),
                ),
              ],),
            ),
          ].reversed.toList(),
        ),
      ),
    );
  }
}
