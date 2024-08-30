import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ride.dart';
import '../models/euser.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Ride-related methods
  Future<List<Ride>> getAvailableRides() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Rides')
          .where('tripStatus', isEqualTo: 'Pending')
          .get();

      return querySnapshot.docs
          .map((doc) => Ride.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching available rides: $e');
      return [];
    }
  }
  Future<void> updateRideStatus(String rideId, String newStatus) async {
    try {
      await _firestore.collection('Rides').doc(rideId).update({
        'tripStatus': newStatus,
      });
    } catch (e) {
      print('Error updating ride status: $e');
      throw e;
    }
  }



  Future<Ride> getRide(String rideId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('Rides').doc(rideId).get();
      if (doc.exists) {
        return Ride.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      throw Exception('Ride not found');
    } catch (e) {
      print('Error fetching ride: $e');
      throw e;
    }
  }

  Future<void> cancelRide(String rideId) async {
    try {
      WriteBatch batch = _firestore.batch();

      DocumentSnapshot rideDoc = await _firestore.collection('Rides').doc(rideId).get();
      if (rideDoc.exists) {
        Ride ride = Ride.fromMap(rideDoc.data() as Map<String, dynamic>, rideDoc.id);

        // Update all riders
        for (String riderId in ride.riderIds) {
          DocumentReference userRef = _firestore.collection('Users').doc(riderId);
          batch.update(userRef, {
            'rideUids': FieldValue.arrayRemove([rideId]),
            'activeRideUid': '',
          });
        }

        // Update driver
        DocumentReference driverRef = _firestore.collection('Users').doc(ride.driverId);
        batch.update(driverRef, {
          'rideUids': FieldValue.arrayRemove([rideId]),
          'activeRideUid': '',
        });

        // Delete the ride document
        batch.delete(_firestore.collection('Rides').doc(rideId));

        // Commit the batch
        await batch.commit();
      }
    } catch (e) {
      print('Error cancelling ride: $e');
      throw e;
    }
  }

  Stream<Ride?> getActiveRideStream(String userEmail) {
    print("Getting active ride stream for user email: $userEmail"); // Debug print
    return _firestore
        .collection('Rides')
        .where('tripStatus', whereIn: ['Accepted', 'InProgress'])
        .snapshots()
        .asyncMap((QuerySnapshot rideSnapshot) async {
      print("Number of documents: ${rideSnapshot.docs.length}"); // Debug print
      for (var doc in rideSnapshot.docs) {
        Ride ride = Ride.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        print("Checking ride: ${ride.id}, Driver: ${ride.driverId}, Riders: ${ride.riderIds}"); // Debug print
        if (ride.driverId == userEmail || ride.riderIds.contains(userEmail)) {
          print("Active ride found for user $userEmail"); // Debug print
          return ride;
        }
      }
      print("No active ride found for user $userEmail"); // Debug print
      return null;
    });
  }


  Future<void> addRide(Ride ride) async {
    try {
      await _firestore.collection('Rides').add(ride.toMap());
    } catch (e) {
      print('Error adding ride: $e');
      throw e;
    }
  }

  Future<void> updateRide(Ride ride) async {
    try {
      await _firestore.collection('Rides').doc(ride.id).update(ride.toMap());
    } catch (e) {
      print('Error updating ride: $e');
      throw e;
    }
  }

  Future<void> deleteRide(String rideId) async {
    try {
      await _firestore.collection('Rides').doc(rideId).delete();
    } catch (e) {
      print('Error deleting ride: $e');
      throw e;
    }
  }

  Future<List<Ride>> getMyRides(String userEmail) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Rides')
          .where('driverId', isEqualTo: userEmail)
          .where('tripStatus', whereIn: ['Pending', 'Accepted', 'InProgress'])
          .get();

      return querySnapshot.docs
          .map((doc) => Ride.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching user rides: $e');
      return [];
    }
  }


  Future<void> completeRide(String rideId) async {
    try {
      WriteBatch batch = _firestore.batch();

      DocumentReference rideRef = _firestore.collection('Rides').doc(rideId);
      DocumentSnapshot rideDoc = await rideRef.get();

      if (rideDoc.exists) {
        Ride ride = Ride.fromMap(rideDoc.data() as Map<String, dynamic>, rideDoc.id);

        // Update ride status
        batch.update(rideRef, {'tripStatus': 'Completed'});

        // Clear driver's activeRideUid
        DocumentReference driverRef = _firestore.collection('Users').doc(ride.driverId);
        batch.update(driverRef, {'activeRideUid': ''});

        // Clear riders' activeRideUid
        for (String riderId in ride.riderIds) {
          DocumentReference riderRef = _firestore.collection('Users').doc(riderId);
          batch.update(riderRef, {'activeRideUid': ''});
        }

        // Commit the batch
        await batch.commit();
        print("Ride completed: $rideId"); // Debug print
      } else {
        throw Exception('Ride not found');
      }
    } catch (e) {
      print('Error completing ride: $e');
      throw e;
    }
  }

  Future<List<Ride>> getDriverActiveRides(String driverId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Rides')
          .where('driverId', isEqualTo: driverId)
          .where('tripStatus', whereIn: ['Accepted', 'InProgress']) // Fetch rides that are either Accepted or InProgress
          .get();

      return querySnapshot.docs
          .map((doc) => Ride.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching driver active rides: $e');
      return [];
    }
  }

  Stream<List<Ride>> getAvailableRidesStream() {
    return _firestore
        .collection('Rides')
        .where('tripStatus', isEqualTo: 'Pending')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Ride.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }


  Future<List<Ride>> getDriverPendingRides(String driverId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Rides')
          .where('driverId', isEqualTo: driverId)
          .where('tripStatus', isEqualTo: 'Pending')
          .get();

      return querySnapshot.docs
          .map((doc) => Ride.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching driver pending rides: $e');
      return [];
    }
  }

  Future<void> startRide(String rideId) async {
    try {
      WriteBatch batch = _firestore.batch();

      DocumentReference rideRef = _firestore.collection('Rides').doc(rideId);
      DocumentSnapshot rideDoc = await rideRef.get();

      if (rideDoc.exists) {
        Ride ride = Ride.fromMap(rideDoc.data() as Map<String, dynamic>, rideDoc.id);

        // Update ride status
        batch.update(rideRef, {'tripStatus': 'InProgress'});

        // Update driver's activeRideUid
        DocumentReference driverRef = _firestore.collection('Users').doc(ride.driverId);
        batch.update(driverRef, {'activeRideUid': rideId});

        // Update riders' activeRideUid
        for (String riderId in ride.riderIds) {
          DocumentReference riderRef = _firestore.collection('Users').doc(riderId);
          batch.update(riderRef, {'activeRideUid': rideId});
        }

        // Commit the batch
        await batch.commit();
      } else {
        throw Exception('Ride not found');
      }
    } catch (e) {
      print('Error starting ride: $e');
      throw e;
    }
  }

  Future<List<Ride>> getPastRides(String userEmail) async {
    try {
      QuerySnapshot riderQuerySnapshot = await _firestore
          .collection('Rides')
          .where('tripStatus', isEqualTo: 'Completed')
          .where('riderIds', arrayContains: userEmail)
          .get();

      QuerySnapshot driverQuerySnapshot = await _firestore
          .collection('Rides')
          .where('tripStatus', isEqualTo: 'Completed')
          .where('driverId', isEqualTo: userEmail)
          .get();

      List<Ride> pastRides = [
        ...riderQuerySnapshot.docs.map((doc) => Ride.fromMap(doc.data() as Map<String, dynamic>, doc.id)),
        ...driverQuerySnapshot.docs.map((doc) => Ride.fromMap(doc.data() as Map<String, dynamic>, doc.id)),
      ];

      return pastRides;
    } catch (e) {
      print('Error fetching past rides: $e');
      return [];
    }
  }

  Future<bool> userHasActiveRide(String userEmail) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('Users').doc(userEmail).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        return userData['activeRideUid'] != '';
      }
      return false;
    } catch (e) {
      print('Error checking if user has active ride: $e');
      return false;
    }
  }

  Future<void> processRide(String userEmail, String rideId) async {
    try {
      WriteBatch batch = _firestore.batch();

      DocumentReference userRef = _firestore.collection('Users').doc(userEmail);
      DocumentSnapshot userDoc = await userRef.get();

      if (userDoc.exists) {
        EUser user = EUser.fromMap(userDoc.data() as Map<String, dynamic>);
        user.hasActiveRide = true;
        user.activeRideUid = rideId;
        user.rideUids.add(rideId);

        batch.update(userRef, user.toMap());

        DocumentReference rideRef = _firestore.collection('Rides').doc(rideId);
        DocumentSnapshot rideDoc = await rideRef.get();

        if (rideDoc.exists) {
          Map<String, dynamic> rideData = rideDoc.data() as Map<String, dynamic>;
          rideData['riderIds'] = FieldValue.arrayUnion([userEmail]);
          rideData['tripStatus'] = 'Accepted';

          batch.update(rideRef, rideData);

          DocumentReference driverRef = _firestore.collection('Users').doc(rideData['driverId']);
          DocumentSnapshot driverDoc = await driverRef.get();

          if (driverDoc.exists) {
            EUser driver = EUser.fromMap(driverDoc.data() as Map<String, dynamic>);
            driver.hasActiveRide = true;
            driver.activeRideUid = rideId;

            batch.update(driverRef, driver.toMap());
          }
        }

        await batch.commit();
      }
    } catch (e) {
      print('Error processing ride: $e');
      throw e;
    }
  }

  Future<void> acceptRide(String userEmail, String rideId) async {
    try {
      WriteBatch batch = _firestore.batch();

      DocumentReference rideRef = _firestore.collection('Rides').doc(rideId);
      DocumentSnapshot rideDoc = await rideRef.get();

      if (rideDoc.exists) {
        Ride ride = Ride.fromMap(rideDoc.data() as Map<String, dynamic>, rideDoc.id);

        // Update rider
        DocumentReference riderRef = _firestore.collection('Users').doc(userEmail);
        batch.update(riderRef, {
          'activeRideUid': rideId,
          'rideUids': FieldValue.arrayUnion([rideId]),
        });

        // Update ride
        batch.update(rideRef, {
          'riderIds': FieldValue.arrayUnion([userEmail]),
          'tripStatus': 'Accepted',
        });

        // Update driver
        DocumentReference driverRef = _firestore.collection('Users').doc(ride.driverId);
        batch.update(driverRef, {'activeRideUid': rideId});

        await batch.commit();
      } else {
        throw Exception('Ride not found');
      }
    } catch (e) {
      print('Error accepting ride: $e');
      throw e;
    }
  }


  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('Users').doc(userId).update(data);
    } catch (e) {
      print('Error updating user data: $e');
      throw e;
    }
  }


  //Auth shit
  Future<void> createUser(EUser user) async {
    try {
      await _firestore.collection('Users').doc(user.email).set(user.toMap());
    } catch (e) {
      print('Error creating user: $e');
      throw e;
    }
  }

  Future<EUser?> getUser(String email) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('Users').doc(email).get();
      if (doc.exists) {
        return EUser.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }



  Future<void> updateUser(EUser user) async {
    try {
      await _firestore.collection('Users').doc(user.email).update(user.toMap());
    } catch (e) {
      print('Error updating user: $e');
      throw e;
    }
  }

  Future<DocumentSnapshot> getUserByEmail(String email) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('Users').doc(email).get();
      return userDoc;
    } catch (e) {
      print('Error fetching user: $e');
      rethrow;
    }
  }



}