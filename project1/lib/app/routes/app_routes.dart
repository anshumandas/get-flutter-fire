part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const CART = _Paths.CART;
  static const CHECKOUT = _Paths.CHECKOUT;
  static const PRODUCTS = _Paths.PRODUCTS;
  static const SIGNUP = _Paths.SIGNUP;
  static const CHANGEPASSWORD = _Paths.CHANGEPASSWORD;
  static const PROFILE = _Paths.PROFILE;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const CART = '/cart';
  static const CHECKOUT = '/checkout';
  static const PRODUCTS = '/product';
  static const SIGNUP = '/Signup';
  static const CHANGEPASSWORD = '/changepassword';
  static const PROFILE = '/profile';
}