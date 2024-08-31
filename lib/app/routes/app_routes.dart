abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const WELCOME = _Paths.WELCOME;
  static const LOGIN = _Paths.LOGIN;
  static const OTP = _Paths.OTP;
  static const REGISTER = _Paths.REGISTER;
  static const ADDRESS = _Paths.ADDRESS;
  static const ROOT = _Paths.ROOT;
//profile routes
  static const ACCOUNT_DETAILS = _Paths.ACCOUNT_DETAILS;
  static const MANAGE_ADDRESS = _Paths.MANAGE_ADDRESS;
  static const ADD_ADDRESS = _Paths.ADD_ADDRESS;
  static const PAST_QUERIES = _Paths.PAST_QUERIES;
  //Cart Routes
  static const CART = _Paths.CART;

  //Order
  static const ORDER_CONFIRMED = _Paths.ORDER_CONFIRMED;
  static const ORDER_DETAILS = _Paths.ORDER_DETAILS;
}

abstract class _Paths {
  static const String SPLASH = '/';
  static const String WELCOME = '/welcome';
  static const String LOGIN = '/login';
  static const String OTP = '/otp';
  static const String REGISTER = '/register';
  static const String ADDRESS = '/address';
  static const String ROOT = '/root';
  //Profile Routes
  static const ACCOUNT_DETAILS = '/account_details';
  static const MANAGE_ADDRESS = '/manage_address';
  static const ADD_ADDRESS = '/add_address';
  static const PAST_QUERIES = '/past_queries';
  //Cart Routes
  static const CART = '/cart';

  //Order
  static const ORDER_CONFIRMED = '/order_confirmed';
  static const ORDER_DETAILS = '/order_details';
}
