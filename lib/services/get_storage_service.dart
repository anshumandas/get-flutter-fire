import 'package:get_storage/get_storage.dart';
import 'package:get_flutter_fire/models/user_model.dart';

class GetStorageService {
  final GetStorage _storage = GetStorage();

  // Save user data to storage
  void saveUserData(UserModel user) {
    _storage.write('user', user.toMap());
  }

  // Load user data from storage
  UserModel? getUserData() {
    final storedUser = _storage.read<Map<String, dynamic>>('user');
    if (storedUser != null) {
      return UserModel.fromMap(storedUser);
    }
    return null;
  }

  // Clear user data from storage
  void clearUserData() {
    _storage.remove('user');
  }

  // Save user role
  void saveUserRole(String role) {
    _storage.write('role', role);
  }

  // Load user role
  String? getUserRole() {
    return _storage.read<String>('role');
  }

  // Clear user role
  void clearUserRole() {
    _storage.remove('role');
  }
}
