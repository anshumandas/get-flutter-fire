import 'screens.dart';

// Adding Persona Enum
enum Persona {
  Adult,
  Kids,
  Teen,
}

// First tab for all except Admin is Home/Dashboard which is different for each role
enum Role {
  Guest,
  Buyer(Persona persona), // Added Persona for Buyer role
  Seller,
  Admin,
}

// Role-based screens
final Map<Role, List<Screens>> roleScreens = {
  Role.Guest: [Screens.Home, Screens.Categories, Screens.Cart],
  Role.Buyer: [Screens.Home, Screens.Categories, Screens.Cart, Screens.MyOrders], // Buyer role screens
  Role.Seller: [Screens.Home, Screens.Products, Screens.Sales],
  Role.Admin: [Screens.Users, Screens.Categories, Screens.Orders],
};

// Function to get screens based on role and persona
List<Screens> getScreensForRole(Role role) {
  switch (role) {
    case Role.Buyer:
      if (role.persona == Persona.Kids) {
        return [Screens.KidsHome, Screens.KidsCategories, Screens.Cart, Screens.MyOrders];
      } else if (role.persona == Persona.Teen) {
        return [Screens.TeenHome, Screens.TeenCategories, Screens.Cart, Screens.MyOrders];
      }
      return roleScreens[Role.Buyer];
    default:
      return roleScreens[role];
  }
}
