import 'package:budget_worker/showSnacBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'auth.dart';

class UserAcc extends StatefulWidget {
  const UserAcc({Key? key}) : super(key: key);

  @override
  State<UserAcc> createState() => _UserAccState();
}

class _UserAccState extends State<UserAcc> {
  final formKey = GlobalKey<FormState>();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController w_contact = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('UserData').doc(Auth.getUid()).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData || !snapshot.data.exists) {
            return const Text("No data ");
          }
          var userDocument = snapshot.data!.data();
          String fname = userDocument["FirstName"];
          String lname = userDocument["LastName"];
          String contact = userDocument["contact"];
          String email = userDocument["email"];
          first_name.text = fname;
          last_name.text = lname;
          w_contact.text = contact;


          return Scaffold(
            backgroundColor : HexColor('#ffe6e6'),
            body: Center(
              child: ListView(
                shrinkWrap: true,
                reverse: true,
                children: <Widget>[
                  Form(
                    key: formKey,
                    child: Column(children:  [
                      Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Your Account",
                          // focusNode: myFocusNode,
                          style: GoogleFonts.alata(
                            color: HexColor('#0B4360'),
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: HexColor('#0B4360'),
                          child: Text(
                            fname.substring(0 , 1).toUpperCase(),
                            style: GoogleFonts.alata(color: Colors.white , fontSize: 28 , fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Card(
                        color: HexColor('#ffe6e6'),
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        elevation: 8,
                        margin: const EdgeInsets.all(10),
                        shadowColor: HexColor('#0B4360'),
                        child: Column(children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              style: GoogleFonts.alata(),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_add_alt_1_outlined , color: HexColor('#0B4360'),),
                                labelText: "First Name",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              controller: first_name,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              style: GoogleFonts.alata(),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_add_alt_1_outlined , color: HexColor('#0B4360'),),
                                labelText: "Last Name",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              controller: last_name,
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.alata(),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_add_alt_1_outlined , color: HexColor('#0B4360'),),
                                labelText: "Conatact",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              controller: w_contact,
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Email : $email",
                              // focusNode: myFocusNode,
                              style: GoogleFonts.alata(
                                color: HexColor('#0B4360'),
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            height: 90.0,
                            width: 380,
                            padding: const EdgeInsets.all(20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: HexColor('#0B4360')),
                              onPressed: (){
                                FirebaseFirestore.instance.collection('UserData').doc(Auth.getUid()).update({
                                  'FirstName' : first_name.text.toString(),
                                  'LastName' : last_name.text.toString(),
                                  'contact' : w_contact.text.toString(),
                                });
                                showSnacBar(context, "Updated Successfully !");
                              },
                              child: Text(
                                "Update",
                                style: GoogleFonts.alata(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            height: 90.0,
                            width: 380,
                            padding: const EdgeInsets.all(20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: HexColor('#0B4360')),
                              onPressed: (){
                                FirebaseAuth.instance.signOut();
                              },
                              child: Text(
                                "Sign out",
                                style: GoogleFonts.alata(color: Colors.white),
                              ),
                            ),
                          ),
                        ],),
                      ),
                    ],),
                  ),
                ].reversed.toList(),
              ),
            ),
          );});
  }
}
