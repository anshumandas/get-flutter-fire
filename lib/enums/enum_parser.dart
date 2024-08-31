import 'package:get_flutter_fire/enums/enums.dart';

UserType parseUserType(String userType) {
  switch (userType) {
    case 'buyer':
      return UserType.buyer;
    case 'seller':
      return UserType.seller;
    case 'admin':
      return UserType.admin;
    case 'guest':
      return UserType.guest;
    default:
      return UserType.buyer;
  }
}

QueryType parseQueryType(String queryType) {
  switch (queryType) {
    case 'product':
      return QueryType.product;
    case 'delivery':
      return QueryType.delivery;
    case 'general':
      return QueryType.general;
    case 'payment':
      return QueryType.payment;
    case 'app':
      return QueryType.app;
    default:
      return QueryType.general;
  }
}

EnquiryStatus parseQueryStatus(String queryStatus) {
  switch (queryStatus) {
    case 'pending':
      return EnquiryStatus.pending;
    case 'in-progress':
      return EnquiryStatus.inProgress;
    case 'completed':
      return EnquiryStatus.completed;
    default:
      return EnquiryStatus.pending;
  }
}

OrderStatus parseOrderStatus(String orderStatus) {
  switch (orderStatus) {
    case 'placed':
      return OrderStatus.placed;
    case 'processed':
      return OrderStatus.processed;
    case 'shipped':
      return OrderStatus.shipped;
    case 'delivered':
      return OrderStatus.delivered;
    case 'cancelled':
      return OrderStatus.cancelled;
    default:
      return OrderStatus.placed;
  }
}
