import 'package:budget_worker/FirebaseFunctions.dart';
import 'package:budget_worker/showSnacBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

import 'Booking.dart';
import 'auth.dart';

class AppWorkerData extends StatefulWidget {
  final String text , cost , uid ;
  AppWorkerData({Key? key, required this.text, required this.cost , required this.uid});

  @override
  State<AppWorkerData> createState() => _AppWorkerData(text , cost , uid);
}

class _AppWorkerData extends State<AppWorkerData> {
  String text , cost , uid;
  _AppWorkerData(this.text , this.cost , this.uid);
  final formKey = GlobalKey<FormState>();
  String flat  = "" , landmark = " " , state = "";
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  @override
  void initState() {
    dateInput.text = "";
    timeinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('UserData').doc(Auth.getUid()).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData || !snapshot.data.exists) {
            return const Text("No data ");
          }
          var doc = snapshot.data!.data();
          var fname = doc['FirstName'];
          var lname = doc['LastName'];
          var u_contact = doc['contact'];
          var u_email = doc['email'];
          var id = doc['uid'];

          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection(text).doc(uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData || !snapshot.data.exists) {
                  return const Text("No data ");
                }
                var userDocument = snapshot.data!.data();
                String name = userDocument["name"];
                String contact = userDocument["contact"];
                String exp = userDocument['Experience'];
                String brief = userDocument['Brief'];
                String age = userDocument["Age"];
                String gender = userDocument["gender"];
                String imgUrl = userDocument["workerImage"];
                String work = userDocument['WorkerOpted'];
                String w_email = userDocument['email'];
                String worker_uuid = userDocument['WorkerUID'];
                String work_type = userDocument['WorkType'];
                String work_opted = userDocument['WorkerOpted'];
                return Scaffold(
                  backgroundColor : HexColor('#ffe6e6'),
                  body: Center(
                    child: ListView(
                      shrinkWrap: true,
                      reverse: true,
                      children: <Widget>[
                        Form(
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(25),
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage(imgUrl),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Name : ""$name",
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
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Age : $age",
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
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Gender : $gender",
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
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Experience : $exp year(s)" ,
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
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Work : $work" ,
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
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                brief ,
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
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Cost : $cost /-" ,
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
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(10),
                              child: TextButton.icon(
                                onPressed: () {  },
                                label: Text(
                                  contact ,
                                  style: GoogleFonts.alata(
                                    color: HexColor('#0B4360'),
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                icon: Icon(Icons.call_outlined , color: HexColor('#0B4360')),
                              ),
                            ),

                            Container(
                              height: 90.0,
                              width: 380,
                              padding: const EdgeInsets.all(20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: HexColor('0B4360')),
                                onPressed: (){
                                  showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context){
                                        return Container(
                                          color: HexColor('#ffe6e6'),
                                          padding: const EdgeInsets.all(10),
                                          child: Form(
                                            key: formKey,
                                            child: ListView(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    'Enter your address *',
                                                    style: GoogleFonts.alata(
                                                      color: HexColor('#0B4360'),
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  alignment: Alignment.centerLeft,
                                                  child: TextFormField(
                                                    style: GoogleFonts.alata(),
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(Icons.home_outlined, color: HexColor('#0B4360'),),
                                                      labelText: "Eg: K/202 , Society name/Bungalow name",
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                    ),
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "Please fill out this field";
                                                      }
                                                      else{
                                                        return null;
                                                      }
                                                    },
                                                    onSaved: (value){
                                                      flat = value!;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    'Enter Landmark *',
                                                    style: GoogleFonts.alata(
                                                      color: HexColor('#0B4360'),
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  alignment: Alignment.centerLeft,
                                                  child: TextFormField(
                                                    style: GoogleFonts.alata(),
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(Icons.home_outlined, color: HexColor('#0B4360'),),
                                                      labelText: "Eg: Near Seasons mall",
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                    ),
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "Please fill out this field";
                                                      }
                                                      else{
                                                        return null;
                                                      }
                                                    },
                                                    onSaved: (value){
                                                      landmark = value!;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    'Enter City and State *',
                                                    style: GoogleFonts.alata(
                                                      color: HexColor('#0B4360'),
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  alignment: Alignment.centerLeft,
                                                  child: TextFormField(
                                                    style: GoogleFonts.alata(),
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(Icons.home_outlined, color: HexColor('#0B4360'),),
                                                      labelText: "Eg: Pune, Maharashtra",
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(width: 3, color: HexColor('#0B4360')),
                                                        borderRadius: BorderRadius.circular(30),
                                                      ),
                                                    ),
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "Please fill out this field";
                                                      }
                                                      else{
                                                        return null;
                                                      }
                                                    },
                                                    onSaved: (value){
                                                      state = value!;
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  alignment: Alignment.centerLeft,
                                                  child: TextFormField(
                                                    style: GoogleFonts.alata(),
                                                    controller: dateInput,
                                                    decoration: InputDecoration(
                                                      icon: Icon(Icons.calendar_today ,  color: HexColor('#0B4360')),
                                                      labelText: 'Choose Date',
                                                    ),
                                                    readOnly: true,
                                                    onTap: () async{
                                                      DateTime? pickedDate = await showDatePicker(
                                                          context: context,
                                                          initialDate: DateTime.now(),
                                                          firstDate: DateTime(1950),
                                                          //DateTime.now() - not to allow to choose before today.
                                                          lastDate: DateTime(2100));

                                                      if (pickedDate != null) {
                                                        print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                        setState(() {
                                                          dateInput.text = formattedDate; //set output date to TextField value.
                                                        });
                                                      } else {
                                                      }
                                                    },
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "Please choose date";
                                                      }
                                                      else{
                                                        return null;
                                                      }
                                                    },
                                                    onSaved: (value){
                                                      dateInput.text = value!;
                                                    },
                                                  ),

                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  alignment: Alignment.centerLeft,
                                                  child: TextFormField(
                                                    style: GoogleFonts.alata(),
                                                    controller: timeinput, //editing controller of this TextField
                                                    decoration: InputDecoration(
                                                        icon: Icon(Icons.timer_outlined , color: HexColor('#0B4360')), //icon of text field
                                                        labelText: "Enter Time" //label text of field
                                                    ),
                                                    readOnly: true,
                                                    onTap: () async {
                                                      TimeOfDay? pickedTime =  await showTimePicker(
                                                        initialTime: TimeOfDay.now(),
                                                        context: context,
                                                      );
                                                      if(pickedTime != null ){
                                                        print(pickedTime.format(context));   //output 10:51 PM
                                                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                                        //converting to DateTime so that we can further format on different pattern.
                                                        print(parsedTime); //output 1970-01-01 22:53:00.000
                                                        String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                                                        print(formattedTime); //output 14:59:00
                                                        //DateFormat() is from intl package, you can format the time on any pattern you need.
                                                        setState(() {
                                                          timeinput.text = formattedTime; //set the value of text field.
                                                        });
                                                      }else{
                                                        print("Time is not selected");
                                                      }
                                                    },
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "Please choose time";
                                                      }
                                                      else{
                                                        return null;
                                                      }
                                                    },
                                                    onSaved: (value){
                                                      timeinput.text = value!;
                                                    },
                                                  ),
                                                ),

                                                Container(
                                                  padding: const EdgeInsets.all(10),
                                                  alignment: Alignment.centerLeft,
                                                  child: TextButton.icon(
                                                    onPressed: () {  },
                                                    label: Text(
                                                      'Pay '+cost+" when work is completed",
                                                      style: GoogleFonts.alata(
                                                        color: HexColor('#0B4360'),
                                                        fontStyle: FontStyle.normal,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    icon: Icon(Icons.attach_money_outlined , color: HexColor('#0B4360')),
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
                                                        formKey.currentState!.save();
                                                        String w_approval = 'Not Approved' , payment_sts = 'Not Done' , work_sts = 'Not Started';
                                                        String booking_no = randomAlphaNumeric(8);

                                                        FirestoreServices2.booking(fname, lname,u_email, u_contact, flat, Auth.getUid(), landmark, state, dateInput.text.toString(), timeinput.text.toString(),imgUrl, work , name, uid, w_email ,contact, w_approval, cost, payment_sts, work_sts , text , worker_uuid , booking_no , work_type , work_opted);
                                                        Navigator.of(context).pop();
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Booking()));

                                                      }
                                                      else{
                                                        showSnacBar(context, "Error");
                                                      }
                                                    },
                                                    child: Text(
                                                      "Confirm",
                                                      style: GoogleFonts.alata(color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],),
                                          ),
                                        );
                                      }
                                  );

                                },
                                child: Text(
                                  "Book Now",
                                  style: GoogleFonts.alata(color: Colors.white),
                                ),
                              ),
                            ),
                          ],),
                        ),

                      ],
                    ),
                  ),
                );});});

  }
}
