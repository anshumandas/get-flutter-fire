import 'package:get/get.dart';
// import 'package:cloud_functions/cloud_functions.dart';

class RoleService extends GetxService {
  final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('setUserRole');

  Future<void> setUserRole(String uid, String role) async {
    try {
      final result = await callable.call({'uid': uid, 'role': role});
      print(result.data);
    } catch (e) {
      print('Failed to set user role: $e');
    }
  }
}

class FirebaseFunctions {
  static var instance;
}

class HttpsCallable {
  call(Map<String, String> map) {}
}
