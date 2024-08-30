import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import '../../../../models/ride.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/firestore_service.dart';
import '../../../../private/api_keys.dart';

class ActiveRideController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  final Rx<Ride?> activeRide = Rx<Ride?>(null);
  final RxBool isDriver = false.obs;
  final RxBool mapRendered = false.obs;
  final Rx<LocationData?> currentLocation = Rx<LocationData?>(null);
  final RxSet<Marker> markers = RxSet<Marker>();
  final RxBool isLoading = true.obs;
  final RxBool hasLocationPermission = false.obs;

  GoogleMapController? mapController;
  Location location = Location();

  @override
  void onInit() {
    super.onInit();
    _subscribeToActiveRide();
    _initializeLocationAndMap();
  }

  void _subscribeToActiveRide() {
    final user = _authService.currentUser;
    if (user != null && user.email != null) {
      print("Current user email: ${user.email}"); // Debug print
      final rideStream = _firestoreService.getActiveRideStream(user.email!);
      ever(activeRide, (_) => _updateMapData());
      rideStream.listen((ride) {
        print("Received ride: ${ride?.id}"); // Debug print
        activeRide.value = ride;
        if (ride != null) {
          print("Ride status: ${ride.tripStatus}"); // Debug print
          isDriver.value = ride.driverId == user.email;
          print("Is driver: ${isDriver.value}"); // Debug print
        } else {
          print("No active ride found"); // Debug print
        }
      });
    } else {
      print("No current user or email is null"); // Debug print
    }
  }

  Future<void> _initializeLocationAndMap() async {
    try {
      bool serviceEnabled;
      PermissionStatus permissionGranted;

      if (!kIsWeb) {
        serviceEnabled = await location.serviceEnabled();
        if (!serviceEnabled) {
          serviceEnabled = await location.requestService();
          if (!serviceEnabled) {
            isLoading.value = false;
            return;
          }
        }

        permissionGranted = await location.hasPermission();
        if (permissionGranted == PermissionStatus.denied) {
          permissionGranted = await location.requestPermission();
          if (permissionGranted != PermissionStatus.granted) {
            isLoading.value = false;
            return;
          }
        }
      }

      hasLocationPermission.value = true;
      currentLocation.value = await location.getLocation();
      location.onLocationChanged.listen((LocationData locationData) {
        currentLocation.value = locationData;
        _updateMapData();
      });
    } catch (e) {
      print('Error initializing location: $e');
      hasLocationPermission.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _updateMapData();
  }

  void _updateMapData() {
    if (activeRide.value != null && currentLocation.value != null && mapController != null) {
      markers.clear();

      markers.add(Marker(
        markerId: MarkerId('currentLocation'),
        position: LatLng(currentLocation.value!.latitude!, currentLocation.value!.longitude!),
        infoWindow: InfoWindow(title: 'Your Location'),
      ));

      markers.add(Marker(
        markerId: MarkerId('pickup'),
        position: LatLng(activeRide.value!.pickupLat, activeRide.value!.pickupLng),
        infoWindow: InfoWindow(title: 'Pickup Location'),
      ));

      markers.add(Marker(
        markerId: MarkerId('destination'),
        position: LatLng(activeRide.value!.destinationLat, activeRide.value!.destinationLng),
        infoWindow: InfoWindow(title: 'Destination'),
      ));

      mapController!.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(currentLocation.value!.latitude!, currentLocation.value!.longitude!),
        14.0,
      ));

      mapRendered.value = true;
    }
  }

  Future<void> navigateToGoogleMaps() async {
    if (activeRide.value != null && currentLocation.value != null) {
      double destLat, destLng;
      if (activeRide.value!.tripStatus == 'Accepted') {
        destLat = activeRide.value!.pickupLat;
        destLng = activeRide.value!.pickupLng;
      } else {
        destLat = activeRide.value!.destinationLat;
        destLng = activeRide.value!.destinationLng;
      }

      final Uri url = Uri.parse(
          'https://www.google.com/maps/dir/?api=1&origin=${currentLocation.value!.latitude},${currentLocation.value!.longitude}&destination=$destLat,$destLng&travelmode=driving'
      );

      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  void startRide() async {
    if (activeRide.value != null && isDriver.value) {
      await _firestoreService.updateRideStatus(activeRide.value!.id, 'InProgress');
      print("Ride started"); // Debug print
    }
  }

  void completeRide() async {
    if (activeRide.value != null && isDriver.value) {
      await _firestoreService.completeRide(activeRide.value!.id);
      print("Ride completed"); // Debug print
      // You might want to navigate the user away from the active ride screen here
    }
  }

  void cancelRide() async {
    if (activeRide.value != null) {
      await _firestoreService.cancelRide(activeRide.value!.id);
      print("Ride cancelled"); // Debug print
    }
  }

  @override
  void onClose() {
    mapController?.dispose();
    super.onClose();
  }
}