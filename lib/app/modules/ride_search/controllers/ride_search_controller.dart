import 'package:get/get.dart';
import '../../../../models/ride.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/firestore_service.dart';
import 'dart:async';

class RideSearchController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final AuthService _authService = Get.find<AuthService>();

  final RxList<Ride> availableRides = <Ride>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool userHasActiveRide = false.obs;

  late StreamSubscription<List<Ride>> _rideSubscription;

  @override
  void onInit() {
    super.onInit();
    _subscribeToAvailableRides();
    checkUserActiveRide();
  }

  void _subscribeToAvailableRides() {
    _rideSubscription = _firestoreService.getAvailableRidesStream().listen(
          (rides) {
        availableRides.value = rides;
        isLoading.value = false;
      },
      onError: (error) {
        Get.snackbar('Error', 'Failed to fetch rides: $error');
        isLoading.value = false;
      },
    );
  }

  void checkUserActiveRide() async {
    String? currentUserEmail = _authService.currentUser?.email;
    if (currentUserEmail != null) {
      userHasActiveRide.value = await _firestoreService.userHasActiveRide(currentUserEmail);
    }
  }

  Future<void> acceptRide(String rideId) async {
    try {
      String? currentUserEmail = _authService.currentUser?.email;
      if (currentUserEmail == null) {
        throw Exception('User not logged in');
      }

      Ride ride = await _firestoreService.getRide(rideId);

      if (ride.driverId == currentUserEmail) {
        throw Exception('You cannot accept your own ride');
      }

      await _firestoreService.acceptRide(currentUserEmail, rideId);
      userHasActiveRide.value = true;
      Get.snackbar('Success', 'Ride accepted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to accept ride: $e');
    }
  }

  bool isUserRide(String driverId) {
    return driverId == _authService.currentUser?.email;
  }

  @override
  void onClose() {
    _rideSubscription.cancel();
    super.onClose();
  }
}