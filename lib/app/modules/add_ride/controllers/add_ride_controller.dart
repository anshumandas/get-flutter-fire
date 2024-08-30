import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:intl/intl.dart';
import '../../../../models/ride.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/firestore_service.dart';
import '../../../../private/api_keys.dart';

class AddRidesController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final AuthService _authService = Get.find<AuthService>();
  late FlutterGooglePlacesSdk places;

  final formKey = GlobalKey<FormState>();
  final dateTimeController = TextEditingController();
  final destinationController = TextEditingController();
  final pickupController = TextEditingController();
  final fareController = TextEditingController();

  final RxBool isFormVisible = false.obs;
  final Rx<Ride?> editingRide = Rx<Ride?>(null);
  final RxList<Ride> myRides = <Ride>[].obs;

  final Rx<Place?> destinationPlace = Rx<Place?>(null);
  final Rx<Place?> pickupPlace = Rx<Place?>(null);
  final Rx<LatLng?> destinationLatLng = Rx<LatLng?>(null);
  final Rx<LatLng?> pickupLatLng = Rx<LatLng?>(null);

  @override
  void onInit() {
    super.onInit();
    places = FlutterGooglePlacesSdk(MAPS_API_KEY_WEB);
    fetchMyRides();
  }

  void fetchMyRides() async {
    String? currentUserEmail = _authService.currentUser?.email;
    if (currentUserEmail != null) {
      myRides.value = await _firestoreService.getMyRides(currentUserEmail);
    }
  }

  void toggleFormVisibility({Ride? ride}) {
    isFormVisible.toggle();
    if (!isFormVisible.value) {
      editingRide.value = null;
      clearForm();
    } else if (ride != null) {
      editingRide.value = ride;
      fillForm(ride);
    }
  }

  void clearForm() {
    dateTimeController.clear();
    destinationController.clear();
    pickupController.clear();
    fareController.clear();
    destinationPlace.value = null;
    pickupPlace.value = null;
    destinationLatLng.value = null;
    pickupLatLng.value = null;
  }

  void fillForm(Ride ride) {
    dateTimeController.text = DateFormat('yyyy-MM-dd HH:mm').format(ride.departureDateTime);
    destinationController.text = ride.destination;
    pickupController.text = ride.pickupLocation;
    fareController.text = ride.fare.toString();
    destinationLatLng.value = LatLng(lat: ride.destinationLat, lng: ride.destinationLng);
    pickupLatLng.value = LatLng(lat: ride.pickupLat, lng: ride.pickupLng);
  }

  Future<void> searchPlace(TextEditingController controller, bool isDestination) async {
    final response = await places.findAutocompletePredictions(controller.text);
    if (response.predictions.isNotEmpty) {
      final prediction = response.predictions[0];
      final placeId = prediction.placeId;
      final placeResponse = await places.fetchPlace(placeId, fields: [PlaceField.Location]);
      final location = placeResponse.place?.latLng;
      if (location != null) {
        if (isDestination) {
          destinationLatLng.value = location;
          destinationPlace.value = placeResponse.place;
        } else {
          pickupLatLng.value = location;
          pickupPlace.value = placeResponse.place;
        }
        controller.text = prediction.fullText;
      }
    }
  }

  Future<void> saveRide() async {
    if (formKey.currentState!.validate()) {
      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        final dateTime = DateFormat('yyyy-MM-dd HH:mm').parse(dateTimeController.text);
        Ride ride = Ride(
          id: editingRide.value?.id ?? '',
          driverId: currentUser.email!,
          riderIds: editingRide.value?.riderIds ?? [],
          destination: destinationController.text,
          destinationLat: destinationLatLng.value?.lat ?? 0,
          destinationLng: destinationLatLng.value?.lng ?? 0,
          pickupLocation: pickupController.text,
          pickupLat: pickupLatLng.value?.lat ?? 0,
          pickupLng: pickupLatLng.value?.lng ?? 0,
          departureDateTime: dateTime,
          fare: double.parse(fareController.text),
          tripStatus: editingRide.value?.tripStatus ?? 'Pending',
        );

        if (editingRide.value != null) {
          await _firestoreService.updateRide(ride);
        } else {
          await _firestoreService.addRide(ride);
        }

        fetchMyRides();
        toggleFormVisibility();
      }
    }
  }

  Future<void> deleteRide() async {
    if (editingRide.value != null) {
      await _firestoreService.deleteRide(editingRide.value!.id);
      fetchMyRides();
      toggleFormVisibility();
    }
  }

  void editRide(Ride ride) {
    toggleFormVisibility(ride: ride);
  }

  @override
  void onClose() {
    dateTimeController.dispose();
    destinationController.dispose();
    pickupController.dispose();
    fareController.dispose();
    super.onClose();
  }
}