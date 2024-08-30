import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/euser.dart';
import '../../models/ride.dart';


class PastRideCard extends StatelessWidget {
  final Ride ride;

  PastRideCard({required this.ride});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Users').doc(ride.driverId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null || snapshot.data!.data() == null) {
          return const CircularProgressIndicator();
        }

        Map<String, dynamic> data = snapshot.data!.data()! as Map<String, dynamic>;
        EUser driver = EUser.fromMap(data);

        return FutureBuilder<List<String>>(
          future: getRiderNames(ride.riderIds),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return Card(
              color: Colors.blueGrey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    rowBuilder('Pickup: ${ride.pickupLocation}', Icons.location_on),
                    SizedBox(height: 8.0),
                    rowBuilder('Destination: ${ride.destination}', Icons.location_on),
                    SizedBox(height: 8.0),
                    rowBuilder('Driver: ${driver.name}', Icons.directions_car),
                    SizedBox(height: 8.0),
                    Column(
                      children: snapshot.data!.map<Widget>((rider) {
                        return rowBuilder(rider, Icons.person);
                      }).toList(),
                    ),
                    SizedBox(height: 8.0),
                    rowBuilder('Fare: \$${ride.fare.toStringAsFixed(2)}', Icons.attach_money),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget rowBuilder(String text, IconData icon) {
    List<String> parts = text.split(':');

    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(width: 8),
        Flexible(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: parts[0] + ':',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black),
                ),
                TextSpan(
                  text: parts.length > 1 ? parts[1] : '',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<List<String>> getRiderNames(List<String> riderIds) async {
    List<String> riderNames = [];
    for (var riderId in riderIds) {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('Users').doc(riderId).get();
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      EUser rider = EUser.fromMap(data);
      riderNames.add('Rider: ${rider.name}');
    }
    return riderNames;
  }
}