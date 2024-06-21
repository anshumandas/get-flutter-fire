import 'package:get/get.dart';

import '../middleware/auth_middleware.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/product_details/bindings/product_details_binding.dart';
import '../modules/product_details/views/product_details_view.dart';
import '../modules/products/bindings/products_binding.dart';
import '../modules/products/views/products_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

// ignore_for_file: inference_failure_on_instance_creation

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: '/',
      page: () => const RootView(),
      binding: RootBinding(),
      participatesInRootNavigator: true,
      preventDuplicates: true,
      children: [
        GetPage(
          middlewares: [
            //only enter this route when not authed
            EnsureNotAuthedOrGuestMiddleware(),
          ],
          name: _Paths.LOGIN,
          page: () => const LoginView(),
          binding: LoginBinding(),
        ),
        GetPage(
          middlewares: [
            //only enter this route when authed
            EnsureAuthedAndNotGuestMiddleware(),
          ],
          name: _Paths.REGISTER,
          page: () => const RegisterView(),
          binding: RegisterBinding(),
        ),
        GetPage(
          preventDuplicates: true,
          name: _Paths.HOME,
          page: () => const HomeView(),
          bindings: [
            HomeBinding(),
          ],
          title: null,
          children: [
            GetPage(
              name: _Paths.DASHBOARD,
              page: () => const DashboardView(),
              binding: DashboardBinding(),
            ),
            GetPage(
              middlewares: [
                //only enter this route when authed
                EnsureAuthedAndNotGuestMiddleware(),
              ],
              name: _Paths.PROFILE,
              page: () => const ProfileView(),
              title: 'Profile',
              transition: Transition.size,
              binding: ProfileBinding(),
            ),
            GetPage(
              middlewares: [
                //if not logged in then enter as guest
                EnsureGuestMiddleware(),
              ],
              name: _Paths.CART,
              page: () => const CartView(),
              title: 'Cart',
              transition: Transition.fade,
              binding: CartBinding(),
              children: [
                GetPage(
                  name: _Paths.CART_DETAILS,
                  page: () => const ProductDetailsView(),
                  binding: ProductDetailsBinding(),
                  middlewares: [
                    //only enter this route when authed
                    EnsureAuthMiddleware(),
                  ],
                )
              ],
            ),
            GetPage(
              middlewares: [
                //only enter this route when authed
                EnsureAuthedAndNotGuestMiddleware(),
              ],
              name: _Paths.CHECKOUT,
              page: () => const CheckoutView(),
              binding: CheckoutBinding(),
            ),
            GetPage(
              middlewares: [
                //only enter this route when admin
                EnsureAdminMiddleware(),
              ],
              name: _Paths.PRODUCTS,
              page: () => const ProductsView(),
              title: 'Products',
              transition: Transition.zoom,
              binding: ProductsBinding(),
              children: [
                GetPage(
                  name: _Paths.PRODUCT_DETAILS,
                  page: () => const ProductDetailsView(),
                  binding: ProductDetailsBinding(),
                  middlewares: [
                    //only enter this route when authed
                    EnsureAuthMiddleware(),
                  ],
                ),
              ],
            ),
          ],
        ),
        GetPage(
          name: _Paths.SETTINGS,
          page: () => SettingsView(),
          binding: SettingsBinding(),
        ),
      ],
    ),
  ];
}
