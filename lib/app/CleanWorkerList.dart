import 'package:budget_worker/showSnacBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'CleanWorkerData.dart';

class CleanWorkerList extends StatelessWidget {
  final String text , cost;
  const CleanWorkerList({Key? key, required this.text, required this.cost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
      ),
      backgroundColor : HexColor('#ffe6e6'),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          reverse: true,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(30),
              child: Text(
                'Workers for $text',
                style: GoogleFonts.alata(
                  textStyle: Theme.of(context).textTheme.headlineMedium,
                  fontSize: 22,
                  color: HexColor('#0B4360'),
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Expanded(
                child: SizedBox(
                  height: 700,
                  child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection(text).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }

                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((DocumentSnapshot document){
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        return Card(
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
                          ListTile(
                          title: Text(
                            data['name'],
                            style: GoogleFonts.alata(
                              color: HexColor('#0B4360'),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          onTap: (){
                            Navigator.push(context , MaterialPageRoute(builder: (context) => CleanWorkerData(text : text , cost : cost , uid : data['uid'])));

                          },
                          leading: CircleAvatar(backgroundColor: Colors.white60, backgroundImage: NetworkImage(data['workerImage']),radius: 30,),
                            subtitle: Text(
                              "${'Experience of '+data['Experience']} year(s)",
                              style: GoogleFonts.alata(
                                color: HexColor('#0B4360'),
                                fontStyle: FontStyle.normal,
                                fontSize: 15,
                              ),
                            ),
                           ),
                            Container(
                                padding: const EdgeInsets.all(0),
                                alignment: Alignment.bottomRight,
                                child: TextButton.icon(
                                  onPressed: () {  },
                                  label: Text(
                                    data['rating'],
                                    style: GoogleFonts.alata(
                                      color: HexColor('#0B4360'),
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15,
                                    ),
                                  ),
                                  icon: Icon(Icons.star , color: HexColor('#0B4360')),
                                )
                            ),

                          ],),
                        );
                    }).toList(),
                    );
                  }),
                ),
            ),
          ].reversed.toList(),
        ),
      ),
    );
  }
}
