import 'package:sharekhan_admin_panel/models/banner_model.dart';
import 'package:sharekhan_admin_panel/models/category_model.dart';
import 'package:sharekhan_admin_panel/models/coupon_model.dart';
import 'package:sharekhan_admin_panel/models/product_model.dart';
import 'package:sharekhan_admin_panel/navigation/routes.dart';
import 'package:sharekhan_admin_panel/screens/banners/add_banner_screen.dart';
import 'package:sharekhan_admin_panel/screens/banners/banners_screen.dart';
import 'package:sharekhan_admin_panel/screens/banners/edit_banner_screen.dart';
import 'package:sharekhan_admin_panel/screens/categories/add_category_screen.dart';
import 'package:sharekhan_admin_panel/screens/categories/categories_screen.dart';
import 'package:sharekhan_admin_panel/screens/categories/edit_category_screen.dart';
import 'package:sharekhan_admin_panel/screens/coupons/add_coupon.dart';
import 'package:sharekhan_admin_panel/screens/coupons/coupons_screen.dart';
import 'package:sharekhan_admin_panel/screens/coupons/edit_coupon.dart';
import 'package:sharekhan_admin_panel/screens/main_screen.dart';
import 'package:sharekhan_admin_panel/screens/products/add_product_screen.dart';
import 'package:sharekhan_admin_panel/screens/products/edit_product_screen.dart';
import 'package:sharekhan_admin_panel/screens/products/products_screen.dart';
import 'package:sharekhan_admin_panel/screens/sellerPoducts/products_screen.dart';
import 'package:sharekhan_admin_panel/screens/settings/edit_settings_screen.dart';
import 'package:sharekhan_admin_panel/screens/settings/settings_screen.dart';
import 'package:sharekhan_admin_panel/screens/splash_screen.dart';
import 'package:sharekhan_admin_panel/screens/users/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.splash,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          const NoTransitionPage(child: SplashScreen()),
    ),

    // Main App Routes
    ShellRoute(
      builder: (context, state, child) {
        return MainScreen(
          child: child,
        );
      },
      routes: [
        // Banners
        GoRoute(
          path: Routes.banners,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: BannersScreen()),
        ),
        GoRoute(
          path: Routes.bannerAdd,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: AddBannerScreen()),
        ),
        GoRoute(
            path: Routes.bannerEdit,
            pageBuilder: (BuildContext context, GoRouterState state) {
              final BannerModel banner = state.extra! as BannerModel;
              return NoTransitionPage(
                child: EditBannerScreen(banner: banner),
              );
            }),

        // Categories
        GoRoute(
          path: Routes.categories,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: CategoriesScreen()),
        ),
        GoRoute(
          path: Routes.categoryAdd,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: AddCategoryScreen()),
        ),
        GoRoute(
            path: Routes.categoryEdit,
            pageBuilder: (BuildContext context, GoRouterState state) {
              final CategoryModel category = state.extra! as CategoryModel;
              return NoTransitionPage(
                child: EditCategoryScreen(category: category),
              );
            }),
        // Coupons
        GoRoute(
          path: Routes.coupons,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: CouponsScreen()),
        ),
        GoRoute(
          path: Routes.couponAdd,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: AddCouponScreen()),
        ),
        GoRoute(
            path: Routes.couponEdit,
            pageBuilder: (BuildContext context, GoRouterState state) {
              final CouponModel coupon = state.extra! as CouponModel;
              return NoTransitionPage(
                child: EditCouponScreen(coupon: coupon),
              );
            }),
        // Products
        GoRoute(
          path: Routes.sellerProducts,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: SellerProductsScreen()),
        ),
        GoRoute(
          path: Routes.sheruProducts,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: ProductsScreen()),
        ),
        GoRoute(
          path: Routes.productAdd,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: AddProductScreen()),
        ),
        GoRoute(
            path: Routes.productEdit,
            pageBuilder: (BuildContext context, GoRouterState state) {
              final ProductModel product = state.extra! as ProductModel;
              return NoTransitionPage(
                child: EditProductScreen(product: product),
              );
            }),
        // Settings
        GoRoute(
          path: Routes.settings,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: SettingsScreen()),
        ),
        GoRoute(
          path: Routes.settingsEdit,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: EditSettingsScreen()),
        ),
        // Users
        GoRoute(
          path: Routes.users,
          pageBuilder: (BuildContext context, GoRouterState state) =>
              const NoTransitionPage(child: UsersScreen()),
        ),
      ],
    ),
  ],
);
