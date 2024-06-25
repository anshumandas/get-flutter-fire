import 'package:get/get.dart';

import '../app/routes/screens.dart';

enum AccessLevel {
  public, //available without any login
  guest, //available with guest login
  authenticated, //available on login
  roleBased, //available on login and with allowed roles
  masked, //available in a partly masked manner based on role
  secret //never visible
}

// First tab for all except Admin is Home/Dashboard which is diferrent for each role
// Admin is User List By Roles with slide to Change Role or Disable
// Second tab for
// Guest & Buyer is Public Product List by Category with Slide to Add to Cart
// Seller is Product List by Category with Add Product FAB leading to Product Form
// Admin is Category List with Add Category FAB
// Third tab for
// Guest is Cart with Guest Auth
// Buyer is Cart with own Auth
// Seller is MyProducts
// Admin is Tasks/Approvals
// Profile and Settings is in Drawer

enum Role {
  buyer([Screen.DASHBOARD, Screen.PRODUCTS, Screen.CART]),
  seller([Screen.DASHBOARD, Screen.PRODUCTS, Screen.MY_PRODUCTS]),
  admin([Screen.USERS, Screen.CATEGORIES, Screen.TASKS]);

  const Role(this.permissions);
  final List<Screen>
      permissions; //list of screen in order of navigator for that role

  static Role fromString(String? name) => (name != null
      ? Role.values.firstWhere((role) => role.name == name)
      : Role.buyer);
  bool hasAccess(Role role) => index >= role.index;
  bool hasAccessOf(String role) => index >= fromString(role).index;

  List<Screen> get tabs => permissions
      .where((screen) => screen.accessor == AccessedBy.navigator)
      .toList(); //the ones in tab

  int getCurrentIndexFromRoute(GetNavConfig? currentRoute) {
    final String? currentLocation = currentRoute?.location;
    int currentIndex = 0;
    if (currentLocation != null) {
      currentIndex =
          tabs.indexWhere((tab) => currentLocation.startsWith(tab.path));
    }
    return (currentIndex > 0) ? currentIndex : 0;
  }

  void routeTo(int value, GetDelegate delegate) {
    delegate.toNamed(tabs[value].route);
  }
}
