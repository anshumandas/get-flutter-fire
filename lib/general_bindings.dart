import 'package:get/get.dart';
import 'package:streakzy/utils/helpers/network_manager.dart';

/// A class responsible for injecting dependencies
/// required for the application using GetX bindings.
class GeneralBindings extends Bindings {
  /// Overrides the `dependencies` method to specify
  /// the dependencies that need to be injected.
  @override
  void dependencies() {
    // Registers an instance of `NetworkManager` as a
    // dependency to be available globally via GetX.
    Get.put(NetworkManager());
  }
}
