import 'package:budget_worker/showSnacBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

import 'LoginScreen.dart';
import 'auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  String email = "" , password = "" , firstname = "" , contact = "" , lastname = "" , imgUrl = "" , age = "";

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
              padding: const EdgeInsets.all(30),
              child: Text(
                'Sign Up',
                style: GoogleFonts.alata(
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                  fontSize: 40,
                  color: HexColor('#0B4360'),
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Lottie.asset(
                'assets/JSON/bwSignUp2.json',
                height: 270.0,
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),
            Card(
              color: HexColor('#ffe6e6'),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 15,
              margin: const EdgeInsets.all(30),
              shadowColor: HexColor('#0B4360'),
              child: Form(
                  key: formKey,
                  child : Column(children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        // focusNode: myFocusNode,
                          style: GoogleFonts.alata(),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_add_alt_1_outlined, color: HexColor('#0B4360'),),
                            labelText: "Enter First Name",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          validator: (value){
                            if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                              //allow upper and lower case alphabets and space
                              return "Enter Correct Name";
                            }else{
                              return null;
                            }
                          },
                        onSaved: (value){
                          setState(() {
                            firstname = value!;
                          });
                        },
                        // controller: controller,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        // focusNode: myFocusNode,
                        style: GoogleFonts.alata(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_add_alt_1_outlined, color: HexColor('#0B4360'),),
                          labelText: "Enter Last Name",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                            //allow upper and lower case alphabets and space
                            return "Enter Correct Name";
                          }else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          setState(() {
                            lastname = value!;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.alata(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email_rounded , color: HexColor('#0B4360'),),
                          labelText: "Enter Email Id",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
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
                        // controller: controller2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        // focusNode: myFocusNode,
                        style: GoogleFonts.alata(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: HexColor('#0B4360'),),
                          labelText: "Enter Contact Number",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty || !RegExp(r'^(?:[+0][1-9])?[0-9]{10}$').hasMatch(value)){
                            return "Enter Correct Phone Number";
                          }else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          setState(() {
                            contact = value!;
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
                          prefixIcon: Icon(Icons.password , color: HexColor('#0B4360'),),
                          labelText: "Set a Password",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onSaved: (value){
                          setState(() {
                            password = value!;
                          });
                        },
                        // controller: controller3,
                      ),
                    ),
                    Container(
                      height: 90.0,
                      width: 200.0,
                      padding: const EdgeInsets.all(25),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: HexColor('0B4360')),
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            //check if form data are valid,
                            // your process task ahed if all data are valid
                            formKey.currentState!.save();
                            Auth.signupUser(email, password, firstname, lastname, contact, context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                          }
                          else{
                            showSnacBar(context, "Error");
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.alata(),
                        ),
                      ),
                    ),
                  ],)
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  });
                },
                child: Text(
                  "Already have an account ? Login",
                  style: GoogleFonts.alata(
                    color: HexColor('#0B4360'),
                  ),
                ),
              ),
            ),
          ].reversed.toList(),
        ),
      ),
    );
  }
}
