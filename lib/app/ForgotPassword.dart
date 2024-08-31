import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

import 'auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();

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
              padding: const EdgeInsets.all(20),
              child: Text(
                'Forgot Password ?',
                style: GoogleFonts.alata(
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                  fontSize: 30,
                  color: HexColor('#0B4360'),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              height: 120,
              width: 160,
              child: Text(
                'We understand that forgetting your password can be frustrating. Let us help you reset it so you can continue using our service hassle-free',
                style: GoogleFonts.alata(
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                  fontSize: 15,
                  color: HexColor('#0B4360'),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Lottie.asset(
                'assets/JSON/bwFP.json',
                height: 270.0,
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.alata(),
                decoration: InputDecoration(
                  prefixIcon:  Icon(Icons.alternate_email_rounded , color: HexColor('#0B4360'),),
                  labelText: "Enter Registered Email",
                  enabledBorder: OutlineInputBorder(
                    borderSide:  BorderSide(width: 3, color: HexColor('#0B4360')),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                controller: email,
              ),
            ),
            Container(
              height: 90.0,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: HexColor('0B4360')),
                onPressed: (){
                  Auth.resetPassword(email.text.toString() , context);
                },
                child: Text(
                  "Send Verification Link",
                  style: GoogleFonts.alata(color: Colors.white),
                ),
              ),
            ),
          ].reversed.toList(),
        ),
      ),
    );
  }
}
