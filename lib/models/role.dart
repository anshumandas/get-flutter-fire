import 'package:get/get.dart';
import 'screens.dart';

enum Role {
  buyer([Screen.DASHBOARD, Screen.PRODUCTS, Screen.CART]),
  seller([Screen.DASHBOARD, Screen.PRODUCTS, Screen.MY_PRODUCTS]),
  admin([Screen.USERS, Screen.CATEGORIES, Screen.TASKS]);

  const Role(this.permissions);
  final List<Screen> permissions;

  static Role fromString(String? name) => (name != null
      ? Role.values.firstWhere((role) => role.name == name)
      : Role.buyer);
  bool hasAccess(Role role) => index >= role.index;
  bool hasAccessOf(String role) => index >= fromString(role).index;

  List<Screen> get tabs => permissions
      .where((screen) => screen.accessor_ == AccessedVia.navigator)
      .toList();

  int getCurrentIndexFromRoute(String currentRoute) {
    int index =
        tabs.indexWhere((screen) => currentRoute.startsWith(screen.route));
    return index != -1 ? index : 0; // Return 0 if no match found
  }

  void routeTo(int index, GetDelegate delegate) {
    if (index >= 0 && index < tabs.length) {
      delegate.toNamed(tabs[index].route);
    }
  }
}
