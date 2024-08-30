import 'package:cloud_firestore/cloud_firestore.dart';

class Ride {
  final String id;
  final String driverId;
  final List<String> riderIds;
  final String destination;
  final String pickupLocation;
  final double destinationLat;
  final double destinationLng;
  final double pickupLat;
  final double pickupLng;
  final DateTime departureDateTime;
  final double fare;
  String tripStatus;

  Ride({
    required this.id,
    required this.driverId,
    required this.riderIds,
    required this.destination,
    required this.pickupLocation,
    required this.destinationLat,
    required this.destinationLng,
    required this.pickupLat,
    required this.pickupLng,
    required this.departureDateTime,
    required this.fare,
    required this.tripStatus,
  });

  factory Ride.fromMap(Map<String, dynamic> map, String id) {
    return Ride(
      id: id,
      driverId: map['driverId'] ?? '',
      riderIds: List<String>.from(map['riderIds'] ?? []),
      destination: map['destination'] ?? '',
      pickupLocation: map['pickupLocation'] ?? '',
      destinationLat: (map['destinationLatLng'] as Map<String, dynamic>)['lat'] ?? 0.0,
      destinationLng: (map['destinationLatLng'] as Map<String, dynamic>)['lng'] ?? 0.0,
      pickupLat: (map['pickupLatLng'] as Map<String, dynamic>)['lat'] ?? 0.0,
      pickupLng: (map['pickupLatLng'] as Map<String, dynamic>)['lng'] ?? 0.0,
      departureDateTime: (map['departureDateTime'] as Timestamp).toDate(),
      fare: (map['fare'] ?? 0.0).toDouble(),
      tripStatus: map['tripStatus'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'driverId': driverId,
      'riderIds': riderIds,
      'destination': destination,
      'pickupLocation': pickupLocation,
      'destinationLatLng': {
        'lat': destinationLat,
        'lng': destinationLng,
      },
      'pickupLatLng': {
        'lat': pickupLat,
        'lng': pickupLng,
      },
      'departureDateTime': Timestamp.fromDate(departureDateTime),
      'fare': fare,
      'tripStatus': tripStatus,
    };
  }
}