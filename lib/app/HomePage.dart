import 'package:budget_worker/AppWorkerList.dart';
import 'package:budget_worker/QuickWorkerList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Booking.dart';
import 'CleanWorkerList.dart';
import 'auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

          return Scaffold(
            backgroundColor : HexColor('#ffe6e6'),
            body: Center(
              child: ListView(
                shrinkWrap: true,
                reverse: true,
                children: <Widget>[
                  Card(
                    color: HexColor('#ffe6e6'),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    elevation: 15,
                    margin: const EdgeInsets.all(20),
                    shadowColor: HexColor('#0B4360'),
                    child: Column(children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Hi, $fname',
                          style: GoogleFonts.alata(
                            textStyle: Theme.of(context).textTheme.headlineMedium,
                            fontSize: 25,
                            color: HexColor('#0B4360'),
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: CupertinoSearchTextField(
                      backgroundColor: Colors.white,
                      style: GoogleFonts.alata(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 18,
                        color: HexColor('#0B4360'),
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                      ),
                      placeholder: 'Search for Cleaning , Massage , Cooking etc..',
                      placeholderStyle: GoogleFonts.alata(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 18,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.normal,
                      ),
                      autocorrect: true,
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      "Cleaning & Dusting",
                      style: GoogleFonts.alata(
                        fontSize: 20,
                        color: HexColor('#0B4360'),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 290,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("Cleaning").snapshots(),
                          builder: (context , snapshot){
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context , index){
                                DocumentSnapshot db = snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                                return Container(
                                  width: 235,
                                  padding: const EdgeInsets.all(10),
                                  child: Card(
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
                                        child: Image.network(db['image']),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          db['title'],
                                          style: GoogleFonts.alata(
                                            fontSize: 15,
                                            color: HexColor('#0B4360'),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          db['desc'],
                                          style: GoogleFonts.alata(
                                            fontSize: 14,
                                            color: HexColor('#0B4360'),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(context , MaterialPageRoute(builder: (context) => CleanWorkerList(text : db['dbName'] , cost : db['cost'])));
                                          },
                                          child: Text(
                                            "View",
                                            style: GoogleFonts.alata(
                                              fontSize: 14,
                                              color: HexColor('#0B4360'),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],),
                                  ),
                                );
                              },
                            );
                          }
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      "Appliance Repair",
                      style: GoogleFonts.alata(
                        fontSize: 20,
                        color: HexColor('#0B4360'),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 290,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("ApplianceRepair").snapshots(),
                          builder: (context , snapshot){
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context , index){
                                DocumentSnapshot db = snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                                return Container(
                                  width: 235,
                                  padding: const EdgeInsets.all(10),
                                  child: Card(
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
                                        child: Image.network(db['image']),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          db['title'],
                                          style: GoogleFonts.alata(
                                            fontSize: 15,
                                            color: HexColor('#0B4360'),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          db['desc'],
                                          style: GoogleFonts.alata(
                                            fontSize: 14,
                                            color: HexColor('#0B4360'),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(context , MaterialPageRoute(builder: (context) => AppWorkerList(text : db['dbName'] , cost : db['cost'])));
                                          },
                                          child: Text(
                                            "View",
                                            style: GoogleFonts.alata(
                                              fontSize: 14,
                                              color: HexColor('#0B4360'),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],),
                                  ),
                                );
                              },
                            );
                          }
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(25),
                    child: Text(
                      "Quick Home Repair",
                      style: GoogleFonts.alata(
                        fontSize: 20,
                        color: HexColor('#0B4360'),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 290,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("QuickHomeRepair").snapshots(),
                          builder: (context , snapshot){
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context , index){
                                DocumentSnapshot db = snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                                return Container(
                                  width: 235,
                                  padding: const EdgeInsets.all(10),
                                  child: Card(
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
                                        child: Image.network(db['image']),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          db['title'],
                                          style: GoogleFonts.alata(
                                            fontSize: 15,
                                            color: HexColor('#0B4360'),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          db['desc'],
                                          style: GoogleFonts.alata(
                                            fontSize: 14,
                                            color: HexColor('#0B4360'),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(context , MaterialPageRoute(builder: (context) => QuickWorkerList(text : db['dbName'] , cost : db['cost'])));
                                          },
                                          child: Text(
                                            "View",
                                            style: GoogleFonts.alata(
                                              fontSize: 14,
                                              color: HexColor('#0B4360'),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],),
                                  ),
                                );
                              },
                            );
                          }
                      ),
                    ),
                  ),
                ].reversed.toList(),
              ),
            ),
          );});
  }
}