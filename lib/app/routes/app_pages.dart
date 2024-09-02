import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/admin/controllers/roleupgrade_controller.dart';
import 'package:get_flutter_fire/app/modules/admin/views/roleupgrade_view.dart';
import 'package:get_flutter_fire/app/modules/auth/email_link_auth.dart';
import 'package:get_flutter_fire/app/modules/phone/controllers/phone_verification_controller.dart';
import 'package:get_flutter_fire/app/modules/phone/views/phone_verification_view.dart';
import 'package:get_flutter_fire/app/modules/security/two_factor_auth.dart';
import 'package:get_flutter_fire/app/widgets/password_reset.dart';

import '../../models/access_level.dart';
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
import '../../models/screens.dart';
import '../widgets/screen_widget.dart';

part 'app_routes.dart';
part 'screen_extension.dart';

class AppPages {
  AppPages._();

  static final INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: '/',
      page: () => const RootView(),
      binding: RootBinding(),
      participatesInRootNavigator: true,
      preventDuplicates: true,
      children: [
        GetPage(
          name: Screen.LOGIN.path,
          page: () => ScreenWidget(
            screen: Screen.LOGIN,
            body: const LoginView(),
          ),
          binding: LoginBinding(),
        ),
        GetPage(
          name: Screen.REGISTER.path,
          page: () => ScreenWidget(
            screen: Screen.REGISTER,
            body: RegisterView(),
          ),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: Screen.PROFILE.path,
          page: () => ScreenWidget(
            screen: Screen.PROFILE,
            body: const ProfileView(),
          ),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: Screen.SETTINGS.path,
          page: () => ScreenWidget(
            screen: Screen.SETTINGS,
            body: const SettingsView(),
          ),
          binding: SettingsBinding(),
        ),
        GetPage(
          name: Screen.HOME.path,
          page: () => ScreenWidget(
            screen: Screen.HOME,
            body: const HomeView(),
          ),
          binding: HomeBinding(),
          children: [
            GetPage(
              name: Screen.DASHBOARD.path,
              page: () => ScreenWidget(
                screen: Screen.DASHBOARD,
                body: const DashboardView(),
              ),
              binding: DashboardBinding(),
            ),
            GetPage(
              name: Screen.USERS.path,
              page: () => ScreenWidget(
                screen: Screen.USERS,
                body: const UsersView(),
                role: Role.admin,
              ),
              binding: UsersBinding(),
              children: [
                GetPage(
                  name: Screen.USER_PROFILE.path,
                  page: () => ScreenWidget(
                    screen: Screen.USER_PROFILE,
                    body: const ProfileView(),
                  ),
                  binding: ProfileBinding(),
                ),
              ],
            ),
            GetPage(
              name: Screen.PRODUCTS.path,
              page: () => ScreenWidget(
                screen: Screen.PRODUCTS,
                body: const ProductsView(),
              ),
              binding: ProductsBinding(),
              children: [
                GetPage(
                  name: Screen.PRODUCT_DETAILS.path,
                  page: () => ScreenWidget(
                    screen: Screen.PRODUCT_DETAILS,
                    body: const ProductDetailsView(),
                  ),
                  binding: ProductDetailsBinding(),
                ),
              ],
            ),
            GetPage(
              name: Screen.CATEGORIES.path,
              page: () => ScreenWidget(
                screen: Screen.CATEGORIES,
                body: const CategoriesView(),
                role: Role.admin,
              ),
              binding: CategoriesBinding(),
            ),
            GetPage(
              name: Screen.CART.path,
              page: () => ScreenWidget(
                screen: Screen.CART,
                body: const CartView(),
                role: Role.buyer,
              ),
              binding: CartBinding(),
              children: [
                GetPage(
                  name: Screen.CHECKOUT.path,
                  page: () => ScreenWidget(
                    screen: Screen.CHECKOUT,
                    body: const CheckoutView(),
                  ),
                  binding: CheckoutBinding(),
                ),
                GetPage(
                  name: Screen.CART_DETAILS.path,
                  page: () => ScreenWidget(
                    screen: Screen.CART_DETAILS,
                    body: const ProductDetailsView(),
                  ),
                  binding: ProductDetailsBinding(),
                ),
              ],
            ),
            GetPage(
              name: Screen.MY_PRODUCTS.path,
              page: () => ScreenWidget(
                screen: Screen.MY_PRODUCTS,
                body: const MyProductsView(),
                role: Role.seller,
              ),
              binding: MyProductsBinding(),
              children: [
                GetPage(
                  name: Screen.MY_PRODUCT_DETAILS.path,
                  page: () => ScreenWidget(
                    screen: Screen.MY_PRODUCT_DETAILS,
                    body: const ProductDetailsView(),
                  ),
                  binding: ProductDetailsBinding(),
                ),
              ],
            ),
            GetPage(
              name: Screen.TASKS.path,
              page: () => ScreenWidget(
                screen: Screen.TASKS,
                body: const TasksView(),
                role: Role.admin,
              ),
              binding: TasksBinding(),
              children: [
                GetPage(
                  name: Screen.TASK_DETAILS.path,
                  page: () => ScreenWidget(
                    screen: Screen.TASK_DETAILS,
                    body: const TaskDetailsView(),
                  ),
                  binding: TaskDetailsBinding(),
                ),
              ],
            ),
            GetPage(
              name: '/reset-password',
              page: () => PasswordResetView(),
              binding: BindingsBuilder(() {
                Get.lazyPut<PasswordResetController>(
                    () => PasswordResetController());
              }),
            ),
            GetPage(
              name: '/phone-verification',
              page: () => PhoneVerificationView(),
              binding: BindingsBuilder(() {
                Get.lazyPut<PhoneVerificationController>(
                    () => PhoneVerificationController());
              }),
            ),
            GetPage(
              name: Screen.PHONE_VERIFICATION.route,
              page: () => PhoneVerificationView(),
              binding: BindingsBuilder(() {
                Get.lazyPut<PhoneVerificationController>(
                    () => PhoneVerificationController());
              }),
            ),
            GetPage(
              name: '/two-factor-auth',
              page: () => TwoFactorAuthView(),
              binding: BindingsBuilder(() {
                Get.lazyPut<TwoFactorAuthController>(
                    () => TwoFactorAuthController());
              }),
            ),
            GetPage(
              name: '/email-link-auth',
              page: () => EmailLinkAuthView(),
              binding: BindingsBuilder(() {
                Get.lazyPut<EmailLinkAuthController>(
                    () => EmailLinkAuthController());
              }),
            ),
            GetPage(
              name: '/role-upgrade-request',
              page: () => RoleUpgradeRequestView(),
              binding: BindingsBuilder(() {
                Get.lazyPut<RoleUpgradeController>(
                    () => RoleUpgradeController());
              }),
            ),
            GetPage(
              name: '/role-upgrade-management',
              page: () => RoleUpgradeManagementView(),
              binding: BindingsBuilder(() {
                Get.lazyPut<RoleUpgradeController>(
                    () => RoleUpgradeController());
              }),
            ),
            GetPage(
              name: Screen.PRODUCTS.path,
              page: () => const ProductsView(),
              binding: ProductsBinding(),
            ),
          ],
        ),
      ],
    ),
  ];
}
