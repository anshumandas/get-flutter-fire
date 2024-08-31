import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'auth.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('UserData').doc(Auth.getUid()).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if (!snapshot.hasData || !snapshot.data.exists) {
            return const Text("No data ");
          }
          var userDocument = snapshot.data!.data();
          String email = userDocument["email"];

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Bookings" , style: GoogleFonts.alata(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                ),
              ),
            ),
            backgroundColor : HexColor('#ffe6e6'),
            body: Center(
              child: ListView(
                shrinkWrap: true,
                reverse: true,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Your Bookings ',
                      style: GoogleFonts.alata(
                        color: HexColor('#0B4360'),
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                        height: 700,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("Booking").where("User_email" , isEqualTo: email).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Text("Loading");
                            }
                            return ListView(
                              shrinkWrap: true,
                                children: snapshot.data!.docs.map((DocumentSnapshot document){
                                Map<String, dynamic> db = document.data()! as Map<String, dynamic>;
                                String bid = db['bookingId'];
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
                                          db['Work'],
                                          style: GoogleFonts.alata(
                                            color: HexColor('#0B4360'),
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),

                                        leading: CircleAvatar(backgroundColor: Colors.white60, backgroundImage: NetworkImage(db['Worker_image']), radius: 23,),
                                        subtitle: Text(
                                            db['booking_date'] +", "+ db['booking_time'],
                                            style: GoogleFonts.alata(
                                            color: HexColor('#0B4360'),
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            ),
                                        ),
                                        onTap: (){
                                          setState(() {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (BuildContext context){
                                                  return Container(
                                                    color: HexColor('#ffe6e6'),
                                                    padding: const EdgeInsets.all(10),
                                                    child: SizedBox(
                                                      height: 300,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.all(0),
                                                            alignment: Alignment.bottomRight,
                                                            child: TextButton.icon(
                                                              onPressed: () {

                                                              },
                                                              label: Text(
                                                                db['Work_sts'],
                                                                style: GoogleFonts.alata(
                                                                  color: HexColor('#0B4360'),
                                                                  fontStyle: FontStyle.normal,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              icon: Icon(Icons.incomplete_circle , color: HexColor('#0B4360')),
                                                            ),
                                                          ),
                                                          if(db['Work_sts'] == "Not Started") ...[
                                                            Container(
                                                              padding: const EdgeInsets.all(10),
                                                              child: Text(
                                                                'Work has not started yet , status will get updated when the work starts ',
                                                                style: GoogleFonts.alata(
                                                                  color: HexColor('#0B4360'),
                                                                  fontStyle: FontStyle.normal,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          ],

                                                          Container(
                                                            padding: const EdgeInsets.all(10),
                                                            child: Text(
                                                              '${'Worker Name : '+db['Worker_name']}\nWorker Contact : '+db['Worker_contact'],
                                                              style: GoogleFonts.alata(
                                                                color: HexColor('#0B4360'),
                                                                fontStyle: FontStyle.normal,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),

                                                          if(db['Work_sts'] == 'Started') ...[
                                                            Text(
                                                              db['Worker_name'] + " has started "+db['Work']+ " work",
                                                              style: GoogleFonts.alata(
                                                                color: HexColor('#0B4360'),
                                                                fontStyle: FontStyle.normal,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            Text('After the work gets completed click the complete button below',
                                                              style: GoogleFonts.alata(
                                                                color: HexColor('#0B4360'),
                                                                fontStyle: FontStyle.normal,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            ElevatedButton(
                                                                style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: HexColor('0B4360')),
                                                                onPressed: (){
                                                                  FirebaseFirestore.instance.collection('Booking').doc(bid).update({'Work_sts': 'Completed'});
                                                                },
                                                                child: Text(
                                                                  'Complete',
                                                                  style: GoogleFonts.alata(color: Colors.white),
                                                                )
                                                            )
                                                          ],
                                                          if(db['Work_sts'] == 'Completed') ...[
                                                            Container(
                                                              padding: EdgeInsets.all(10),
                                                              child: Text(
                                                                '${'${'Please pay '+db['Worker_name']} '+db['Cost']} /-',
                                                                style: GoogleFonts.alata(
                                                                  color: HexColor('#0B4360'),
                                                                  fontStyle: FontStyle.normal,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                          if(db['Payment_sts'] == 'Done') ...[
                                                            Container(
                                                              padding : const EdgeInsets.all(10),
                                                              child : Text(
                                                                'Please rate our worker',
                                                                style: GoogleFonts.alata(
                                                                  color: HexColor('#0B4360'),
                                                                  fontStyle: FontStyle.normal,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),

                                                            Container(
                                                              padding : const EdgeInsets.all(10),
                                                              child: RatingBar.builder(
                                                                initialRating: 3,
                                                                minRating: 1,
                                                                direction: Axis.horizontal,
                                                                allowHalfRating: true,
                                                                itemCount: 5,
                                                                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                                itemBuilder : (context , _) =>
                                                                    Icon(
                                                                      Icons.star , color: HexColor('#0B4360'),),
                                                                onRatingUpdate: (rating){
                                                                  String comment = "";
                                                                  String name = db['UserFname'] + " "+ db['UserLname'];
                                                                  String email = db['Worker_email'];
                                                                  String work = db['Work_type']+', '+db['Work_opted'];
                                                                  String rate = rating.toString();

                                                                  print(rating);
                                                                  if(rating == 1){
                                                                    comment = "Bad";
                                                                    FirebaseFirestore.instance.collection("Reviews").doc(db['Booking_No']).set({'worker_name' : name , 'worker_email' : email ,'rating' : rate , 'comment' : comment , 'work' : work});
                                                                    FirebaseFirestore.instance.collection('Booking').doc(bid).delete();
                                                                  }
                                                                  if(rating == 2 ){
                                                                    comment = "Satisfactory";
                                                                    FirebaseFirestore.instance.collection("Reviews").doc(db['Booking_No']).set({'worker_name' : name , 'worker_email' : email ,'rating' : rate , 'comment' : comment , 'work' : work});
                                                                    FirebaseFirestore.instance.collection('Booking').doc(bid).delete();
                                                                  }
                                                                  if(rating == 3){
                                                                    comment = "Can do better";
                                                                    FirebaseFirestore.instance.collection("Reviews").doc(db['Booking_No']).set({'worker_name' : name , 'worker_email' : email ,'rating' : rate , 'comment' : comment , 'work' : work});
                                                                    FirebaseFirestore.instance.collection('Booking').doc(bid).delete();
                                                                  }
                                                                  if(rating == 4){
                                                                    comment = "Impressive";
                                                                    FirebaseFirestore.instance.collection("Reviews").doc(db['Booking_No']).set({'worker_name' : name , 'worker_email' : email ,'rating' : rate , 'comment' : comment , 'work' : work});
                                                                    FirebaseFirestore.instance.collection('Booking').doc(bid).delete();
                                                                  }
                                                                  if(rating == 5){
                                                                    comment = "Excellent";
                                                                    FirebaseFirestore.instance.collection("Reviews").doc(db['Booking_No']).set({'worker_name' : name , 'worker_email' : email ,'rating' : rate , 'comment' : comment , 'work' : work});
                                                                    FirebaseFirestore.instance.collection('Booking').doc(bid).delete();
                                                                  }
                                                                  Navigator.of(context).pop();
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                          if(db['Payment_sts'] == 'Incomplete') ...[
                                                            Container(
                                                              padding: EdgeInsets.all(10),
                                                              child: Text(
                                                                '${'Payment has been incomplete please pay the worker '+ db['Cost']} /-',
                                                                style: GoogleFonts.alata(
                                                                  color: HexColor('#0B4360'),
                                                                  fontStyle: FontStyle.normal,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                            );
                                          });
                                        },
                                      ),
                                    ],),
                                  );
                              } , ).toList(),
                            );
                          },
                        ),
                      )
                  ),
                ].reversed.toList(),
              ),
            ),
          );
        });
  }
}
