import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_flutter_fire/enums/enums.dart';
import 'package:get_flutter_fire/models/contact_enquiry_model.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';

class ContactController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final CollectionReference supportRef =
      FirebaseFirestore.instance.collection('support');

  var enquiries = <ContactEnquiryModel>[].obs;
  var filteredEnquiries = <ContactEnquiryModel>[].obs;
  var isLoading = false.obs;
  var selectedTab = 'Completed'.obs;

  @override
  void onInit() {
    super.onInit();
    getEnquiries();
  }

  Future<void> getEnquiries() async {
    if (authController.user == null) return;

    isLoading(true);
    try {
      final snapshot = await supportRef
          .where('userID', isEqualTo: authController.user!.id)
          .orderBy('timestamp', descending: true)
          .get();

      enquiries.assignAll(snapshot.docs
          .map((doc) =>
              ContactEnquiryModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList());

      filterEnquiries();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch enquiries');
    } finally {
      isLoading(false);
    }
  }

  void filterEnquiries() {
    EnquiryStatus status;
    switch (selectedTab.value) {
      case 'Pending':
        status = EnquiryStatus.pending;
        break;
      case 'In-Progress':
        status = EnquiryStatus.inProgress;
        break;
      default:
        status = EnquiryStatus.completed;
    }

    filteredEnquiries.value =
        enquiries.where((enquiry) => enquiry.status == status).toList();
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
    filterEnquiries();
  }

  Future<void> addEnquiry(ContactEnquiryModel enquiry) async {
    try {
      await supportRef.doc(enquiry.id).set(enquiry.toMap());
      enquiries.insert(0, enquiry);
      filterEnquiries();
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit enquiry');
    }
  }
}
