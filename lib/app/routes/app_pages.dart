import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/admin/views/add_category.dart';
import 'package:get_flutter_fire/app/modules/admin/views/admin_banner_list_screen.dart';
import 'package:get_flutter_fire/app/modules/admin/views/approve_seller.dart';
import 'package:get_flutter_fire/app/modules/admin/views/categories.dart';
import 'package:get_flutter_fire/app/modules/admin/views/upload_banner.dart';
import 'package:get_flutter_fire/app/modules/auth/views/address_screen.dart';
import 'package:get_flutter_fire/app/modules/auth/views/login_screen.dart';
import 'package:get_flutter_fire/app/modules/auth/views/otp_screen.dart';
import 'package:get_flutter_fire/app/modules/auth/views/register_screen.dart';
import 'package:get_flutter_fire/app/modules/auth/views/welcome_screen.dart';
import 'package:get_flutter_fire/app/modules/cart/views/cart_root_view.dart';
import 'package:get_flutter_fire/app/modules/cart/views/order_confirmed.dart';
import 'package:get_flutter_fire/app/modules/home/view/categories/categories.dart';
import 'package:get_flutter_fire/app/modules/home/view/product_detail_screen.dart';
import 'package:get_flutter_fire/app/modules/home/view/product_listing.dart';
import 'package:get_flutter_fire/app/modules/home/view/search.dart';
import 'package:get_flutter_fire/app/modules/orders/views/order_detail_screen.dart';
import 'package:get_flutter_fire/app/modules/profile/views/account_detail.dart';
import 'package:get_flutter_fire/app/modules/profile/views/add_addresses.dart';
import 'package:get_flutter_fire/app/modules/profile/views/contact_support.dart';
import 'package:get_flutter_fire/app/modules/profile/views/manage_address.dart';
import 'package:get_flutter_fire/app/modules/profile/views/past_queries_screen.dart';
import 'package:get_flutter_fire/app/modules/root/root_view.dart';
import 'package:get_flutter_fire/app/modules/splash/splash_screen.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.WELCOME,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.OTP,
      page: () => OtpScreen(phoneNumber: Get.arguments['phoneNumber']),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterScreen(
        phoneNumber: Get.arguments['phoneNumber'],
      ),
    ),
    GetPage(
      name: Routes.ADDRESS,
      page: () => AddressScreen(),
    ),
    GetPage(
      name: Routes.ROOT,
      page: () => RootView(),
    ),

    //home screen
    GetPage(
      name: Routes.CATEGORIES,
      page: () => const CategoriesScreen(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => const SearchScreen(),
    ),

    // Profile Routes
    GetPage(
      name: Routes.ACCOUNT_DETAILS,
      page: () => const AccountDetailsScreen(),
    ),
    GetPage(
      name: Routes.MANAGE_ADDRESS,
      page: () => ManageAddressScreen(),
    ),
    GetPage(
      name: Routes.ADD_ADDRESS,
      page: () => AddAddressScreen(),
    ),
    GetPage(
      name: Routes.CONTACT,
      page: () => SupportScreen(),
    ),
    GetPage(
      name: Routes.PAST_QUERIES,
      page: () => PastQueriesScreen(),
    ),

    // Cart Routes
    GetPage(
      name: Routes.CART,
      page: () => const CartRootView(),
    ),

    // Order Routes
    GetPage(
      name: Routes.ORDER_CONFIRMED,
      page: () => const OrderConfirmedScreen(),
    ),
    GetPage(
      name: Routes.ORDER_DETAILS,
      page: () => const OrderDetailScreen(),
    ),

    // Admin Routes
    GetPage(
      name: Routes.UPLOAD_BANNERS,
      page: () => const AdminBannerUploadScreen(),
    ),
    GetPage(
      name: Routes.EDIT_BANNER,
      page: () => const AdminBannerListScreen(),
    ),
    GetPage(
      name: Routes.APPROVE_SELLERS,
      page: () => const ApproveSellerScreen(),
    ),
    GetPage(
      name: Routes.ADD_CATEGORY,
      page: () => const AddCategoryScreen(),
    ),
    GetPage(
      name: Routes.VIEW_CATEGORIES,
      page: () => CategoryListScreen(),
    ),

    // Product Detail Route
    GetPage(
      name: Routes.PRODUCT_DETAILS,
      page: () => ProductDetailScreen(productID: Get.parameters['id']!),
    ),
    GetPage(
      name: Routes.PRODUCTS_LISTING,
      page: () => const ProductsListingScreen(),
    ),
  ];
}
