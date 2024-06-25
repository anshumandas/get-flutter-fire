// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/role.dart';
import '../middleware/auth_middleware.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/categories/bindings/categories_binding.dart';
import '../modules/categories/views/categories_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/my_products/bindings/my_products_binding.dart';
import '../modules/my_products/views/my_products_view.dart';
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
import '../modules/task_details/bindings/task_details_binding.dart';
import '../modules/task_details/views/task_details_view.dart';
import '../modules/tasks/bindings/tasks_binding.dart';
import '../modules/tasks/views/tasks_view.dart';
import '../modules/users/bindings/users_binding.dart';
import '../modules/users/views/users_view.dart';
import 'screens.dart';

// ignore_for_file: inference_failure_on_instance_creation

part 'app_routes.dart';
part 'screen_extension.dart';

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
        Screen.LOGIN.getPage(
          middlewares: [
            //only enter this route when not authed. This is override of role mentioned
            EnsureNotAuthedOrGuestMiddleware(),
          ],
          page: () => const LoginView(),
          binding: LoginBinding(),
        ),
        Screen.REGISTER.getPage(
          // Not required anymore
          // middlewares: [
          //   //only enter this route when authed
          //   EnsureAuthedAndNotGuestMiddleware(),
          // ],
          page: () => const RegisterView(),
          binding: RegisterBinding(),
        ),
        Screen.PROFILE.getPage(
          // middlewares: [
          //   //only enter this route when authed
          //   EnsureAuthedAndNotGuestMiddleware(),
          // ],
          page: () => const ProfileView(),
          binding: ProfileBinding(),
        ),
        Screen.SETTINGS.getPage(
          page: () => const SettingsView(),
          binding: SettingsBinding(),
        ),
        Screen.HOME.getPage(
          page: () => const HomeView(),
          preventDuplicates: true,
          bindings: [
            HomeBinding(),
          ],
          children: [
            Screen.DASHBOARD.getPage(
              page: () => const DashboardView(),
              binding: DashboardBinding(),
            ),
            Screen.USERS.getPage(
              // middlewares: [
              //   //only enter this route when admin
              //   EnsureRoleMiddleware(Role.admin),
              // ],
              role: Role.admin,
              page: () => const UsersView(),
              binding: UsersBinding(),
              children: [
                Screen.USER_PROFILE.getPage(
                  page: () => const ProfileView(),
                  binding: ProfileBinding(),
                )
              ],
            ),
            Screen.PRODUCTS.getPage(
              page: () => const ProductsView(),
              binding: ProductsBinding(),
              children: [
                Screen.PRODUCT_DETAILS.getPage(
                  page: () => const ProductDetailsView(),
                  binding: ProductDetailsBinding(),
                ),
              ],
            ),
            Screen.CATEGORIES.getPage(
              role: Role.admin,
              page: () => const CategoriesView(),
              binding: CategoriesBinding(),
            ),
            Screen.CART.getPage(
              // middlewares: [
              //   //if not logged in then enter as guest
              //   EnsureAuthOrGuestMiddleware(),
              // ],
              page: () => const CartView(),
              binding: CartBinding(),
              children: [
                Screen.CART_DETAILS.getPage(
                  page: () => const ProductDetailsView(),
                  binding: ProductDetailsBinding(),
                ),
                Screen.CHECKOUT.getPage(
                  // middlewares: [
                  //   //only enter this route when authed
                  //   EnsureAuthedAndNotGuestMiddleware(),
                  // ],
                  page: () => const CheckoutView(),
                  binding: CheckoutBinding(),
                ),
              ],
            ),
            Screen.MY_PRODUCTS.getPage(
              page: () => const MyProductsView(),
              binding: MyProductsBinding(),
              role: Role.seller,
              children: [
                Screen.MY_PRODUCT_DETAILS.getPage(
                  page: () => const ProductDetailsView(),
                  binding: ProductDetailsBinding(),
                ),
              ],
            ),
            Screen.TASKS.getPage(
              role: Role.admin,
              page: () => const TasksView(),
              binding: TasksBinding(),
              children: [
                Screen.TASK_DETAILS.getPage(
                  page: () => const TaskDetailsView(),
                  binding: TaskDetailsBinding(),
                  // middlewares: [
                  //   //only enter this route when authed
                  //   EnsureRoleMiddleware(Role.admin),
                  // ],
                ),
              ],
            ),
          ],
        )
      ],
    ),
  ];
}
