import 'package:sharekhan_admin_panel/enums/enums.dart';

UserType parseUserType(String userType) {
  switch (userType) {
    case 'buyer':
      return UserType.buyer;
    case 'seller':
      return UserType.seller;
    default:
      return UserType.buyer;
  }
}
