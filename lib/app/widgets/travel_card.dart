import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/ride.dart';

class TravelCard extends StatelessWidget {
  final Ride ride;
  final VoidCallback onPressed;
  final bool isEditable;
  final bool isUserRide;

  const TravelCard({
    Key? key,
    required this.ride,
    required this.onPressed,
    this.isEditable = false,
    this.isUserRide = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDateTime = DateFormat('HH:mm a').format(ride.departureDateTime);
    final formattedTime = formattedDateTime.split(' ')[0];
    final period = formattedDateTime.split(' ')[1];

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.blueGrey.shade300,
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedTime,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(period,
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      ride.destination,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      ride.pickupLocation,
                      style: const TextStyle(fontSize: 17, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "\$${ride.fare.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text("Fare",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}