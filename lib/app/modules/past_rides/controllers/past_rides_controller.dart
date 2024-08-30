import 'package:get/get.dart';
import '../../../../models/ride.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/firestore_service.dart';

class PastRidesController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final AuthService _authService = Get.find<AuthService>();

  final RxList<Ride> pastRides = <Ride>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPastRides();
  }

  void loadPastRides() async {
    isLoading.value = true;
    try {
      final userEmail = _authService.currentUser!.email;
      if (userEmail != null) {
        pastRides.value = await _firestoreService.getPastRides(userEmail);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load past rides: $e');
    } finally {
      isLoading.value = false;
    }
  }
}