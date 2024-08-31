import 'screens.dart';

// updated the roles to guest, registeredUser and admin
// guest can access Home, Search and Profile Screens
//admin has access to all screens, including managing hotels and users

enum Role {
  guest([Screen.HOME, Screen.PRODUCTS, Screen.LOGIN, Screen.REGISTER, Screen.PROFILE]),
  registeredUser([Screen.HOME, Screen.PRODUCTS, Screen.CHECKOUT, Screen.PROFILE, Screen.CART]),
  admin([Screen.USERS, Screen.HOME,Screen.MY_PRODUCTS,Screen.CHECKOUT, Screen.PROFILE, Screen.CATEGORIES,Screen.TASKS]);

  const Role(this.permissions);
  final List<Screen>
      permissions; //list of screens, with accessLevel = roleBased, visible for the role

  static Role fromString(String? name) => (name != null
      ? Role.values.firstWhere((role) => role.name == name)
      : Role.guest);
  bool hasAccess(Role role) => index >= role.index;
  bool hasAccessOf(String role) => index >= fromString(role).index;

  List<Screen> get tabs => permissions
      .where((screen) => screen.accessor_ == AccessedVia.navigator)
      .toList(); //the ones in tab
}
