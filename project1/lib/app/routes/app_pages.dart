import 'package:get/get.dart';
import 'package:project1/app/modules/product/bindings/product_binding.dart';
import 'package:project1/app/modules/profile/view/profile_view.dart';
import '../modules/Signup/controller/singup_controller.dart';
import '../modules/Signup/view/signup_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/view/cart_view.dart';
import '../modules/changepassword/controller/changepassword_controller.dart';
import '../modules/changepassword/view/changepassword_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/view/checkout_view.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/product/views/product_list_view.dart';
import '../modules/profile/controller/profile_controller.dart';
import '../modules/profileimage/profileimage_controller.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
        Get.put(ProfileImageController());
      }),
    ),
    GetPage(
      name: _Paths.LOGIN, 
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => ProductListView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => SignupController())),
    ),
    GetPage(
      name: _Paths.CHANGEPASSWORD,
      page: () => ChangePasswordView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
      }),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfileController>(() => ProfileController());
      }),
    ),
  ];
}