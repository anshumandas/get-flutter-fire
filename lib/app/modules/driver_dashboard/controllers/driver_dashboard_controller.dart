import 'package:get/get.dart';
import '../../../../models/ride.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/firestore_service.dart';
import '../../../routes/app_pages.dart';


class DriverDashboardController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final AuthService _authService = Get.find<AuthService>();

  final RxList<Ride> activeRides = <Ride>[].obs;
  final RxList<Ride> pendingRides = <Ride>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadDriverRides();
  }

  void _loadDriverRides() async {
    isLoading.value = true;
    try {
      final driverId = _authService.currentUser!.uid;
      activeRides.value = await _firestoreService.getDriverActiveRides(driverId);
      pendingRides.value = await _firestoreService.getDriverPendingRides(driverId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load rides: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void startRide(String rideId) async {
    try {
      await _firestoreService.startRide(rideId);
      _loadDriverRides();
    } catch (e) {
      Get.snackbar('Error', 'Failed to start ride: $e');
    }
  }

  void completeRide(String rideId) async {
    try {
      await _firestoreService.completeRide(rideId);
      _loadDriverRides();
    } catch (e) {
      Get.snackbar('Error', 'Failed to complete ride: $e');
    }
  }

  @override
  void onReady() {
    super.onReady();
    ever(Get.routing.obs, (_) {
      if (Get.previousRoute == Routes.ADD_RIDE) {
        _loadDriverRides();
      }
    });
  }
}