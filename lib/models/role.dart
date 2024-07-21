import 'screens.dart';

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
  buyer([Screen.DASHBOARD, Screen.PRODUCTS, Screen.CART, Screen.BECOME_SELLER]),
  seller([Screen.DASHBOARD, Screen.PRODUCTS, Screen.MY_PRODUCTS]),
  admin([Screen.USERS, Screen.CATEGORIES, Screen.TASKS]);
//higher role can assume a lower role

  const Role(this.permissions);
  final List<Screen>
      permissions; //list of screens, with accessLevel = roleBased, visible for the role

  static Role fromString(String? name) => (name != null
      ? Role.values.firstWhere((role) => role.name == name)
      : Role.buyer);
  bool hasAccess(Role role) => index >= role.index;
  bool hasAccessOf(String role) => index >= fromString(role).index;

  List<Screen> get tabs => permissions
      .where((screen) => screen.accessor_ == AccessedVia.navigator)
      .toList(); //the ones in tab
}
