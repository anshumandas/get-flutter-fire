import 'package:sharekhan_admin_panel/constants/asset_constants.dart';
import 'package:sharekhan_admin_panel/enums/enums.dart';
import 'package:sharekhan_admin_panel/navigation/routes.dart';
import 'package:sharekhan_admin_panel/providers/banner_provider.dart';
import 'package:sharekhan_admin_panel/providers/category_provider.dart';
import 'package:sharekhan_admin_panel/providers/coupon_provider.dart';
import 'package:sharekhan_admin_panel/providers/product_provider.dart';
import 'package:sharekhan_admin_panel/providers/setting_provider.dart';
import 'package:sharekhan_admin_panel/providers/user_provider.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_icon.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_loading.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isLoading = true;
  ScreenType _selectedScreen = ScreenType.banners;

  void _onTabSelected(ScreenType screen) {
    setState(() {
      _selectedScreen = screen;
    });
    switch (screen) {
      case ScreenType.banners:
        context.go(Routes.banners);
        break;
      case ScreenType.sheruProducts:
        context.go(Routes.sheruProducts);
        break;
      case ScreenType.sellerProducts:
        context.go(Routes.sellerProducts);
        break;
      case ScreenType.categories:
        context.go(Routes.categories);
        break;
      case ScreenType.coupons:
        context.go(Routes.coupons);
        break;
      case ScreenType.settings:
        context.go(Routes.settings);
        break;
      case ScreenType.users:
        context.go(Routes.users);
        break;
    }
  }

  init() async {
    final bannerProvider = context.read<BannerProvider>();
    final categoryProvider = context.read<CategoryProvider>();
    final couponProvider = context.read<CouponProvider>();
    final productProvider = context.read<ProductProvider>();
    final settingProvider = context.read<SettingProvider>();
    final userProvider = context.read<UserProvider>();
    await userProvider.fetchUsers();
    await settingProvider.fetchSettings();
    await productProvider.fetchProducts();
    await couponProvider.fetchCoupons();
    await bannerProvider.fetchBanners();
    await categoryProvider.fetchCategories();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Scaffold(
            body: Row(
              children: [
                Container(
                  width: 200,
                  height: double.infinity,
                  color: AppTheme.colorWhite,
                  padding: AppTheme.paddingSmall,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          imageLogoMain,
                          width: 100,
                        ),
                        const Spacing(size: AppTheme.spacingSmall),
                        InkWell(
                          onTap: () {
                            _onTabSelected(ScreenType.banners);
                          },
                          child: Container(
                            decoration: _selectedScreen == ScreenType.banners
                                ? BoxDecoration(
                                    color: AppTheme.colorRed,
                                    borderRadius: AppTheme.borderRadiusSmall,
                                  )
                                : null,
                            padding: AppTheme.paddingTiny,
                            child: Row(
                              children: [
                                CustomIcon(
                                  asset: iconTrial,
                                  color: _selectedScreen == ScreenType.banners
                                      ? AppTheme.colorWhite
                                      : AppTheme.colorGrey,
                                ),
                                const Spacing(
                                    size: AppTheme.spacingTiny,
                                    isHorizontal: true),
                                Text('Banners',
                                    style: AppTheme.fontStyleDefault.copyWith(
                                      color:
                                          _selectedScreen == ScreenType.banners
                                              ? AppTheme.colorWhite
                                              : AppTheme.colorGrey,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const Spacing(size: AppTheme.spacingSmall),
                        InkWell(
                          onTap: () {
                            _onTabSelected(ScreenType.sheruProducts);
                          },
                          child: Container(
                            decoration: _selectedScreen ==
                                    ScreenType.sheruProducts
                                ? BoxDecoration(
                                    color: AppTheme.colorRed,
                                    borderRadius: AppTheme.borderRadiusSmall,
                                  )
                                : null,
                            padding: AppTheme.paddingTiny,
                            child: Row(
                              children: [
                                CustomIcon(
                                  asset: iconTrial,
                                  color: _selectedScreen ==
                                          ScreenType.sheruProducts
                                      ? AppTheme.colorWhite
                                      : AppTheme.colorGrey,
                                ),
                                const Spacing(
                                    size: AppTheme.spacingTiny,
                                    isHorizontal: true),
                                Text('Sheru Products',
                                    style: AppTheme.fontStyleDefault.copyWith(
                                      color: _selectedScreen ==
                                              ScreenType.sheruProducts
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorGrey,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const Spacing(size: AppTheme.spacingSmall),
                        InkWell(
                          onTap: () {
                            _onTabSelected(ScreenType.sellerProducts);
                          },
                          child: Container(
                            decoration: _selectedScreen ==
                                    ScreenType.sellerProducts
                                ? BoxDecoration(
                                    color: AppTheme.colorRed,
                                    borderRadius: AppTheme.borderRadiusSmall,
                                  )
                                : null,
                            padding: AppTheme.paddingTiny,
                            child: Row(
                              children: [
                                CustomIcon(
                                  asset: iconTrial,
                                  color: _selectedScreen ==
                                          ScreenType.sellerProducts
                                      ? AppTheme.colorWhite
                                      : AppTheme.colorGrey,
                                ),
                                const Spacing(
                                    size: AppTheme.spacingTiny,
                                    isHorizontal: true),
                                Text('Seller Products',
                                    style: AppTheme.fontStyleDefault.copyWith(
                                      color: _selectedScreen ==
                                              ScreenType.sellerProducts
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorGrey,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const Spacing(size: AppTheme.spacingSmall),
                        InkWell(
                          onTap: () {
                            _onTabSelected(ScreenType.users);
                          },
                          child: Container(
                            decoration: _selectedScreen == ScreenType.users
                                ? BoxDecoration(
                                    color: AppTheme.colorRed,
                                    borderRadius: AppTheme.borderRadiusSmall,
                                  )
                                : null,
                            padding: AppTheme.paddingTiny,
                            child: Row(
                              children: [
                                CustomIcon(
                                  asset: iconTrial,
                                  color: _selectedScreen == ScreenType.users
                                      ? AppTheme.colorWhite
                                      : AppTheme.colorGrey,
                                ),
                                const Spacing(
                                    size: AppTheme.spacingTiny,
                                    isHorizontal: true),
                                Text('Users',
                                    style: AppTheme.fontStyleDefault.copyWith(
                                      color: _selectedScreen == ScreenType.users
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorGrey,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const Spacing(size: AppTheme.spacingSmall),
                        InkWell(
                          onTap: () {
                            _onTabSelected(ScreenType.categories);
                          },
                          child: Container(
                            decoration: _selectedScreen == ScreenType.categories
                                ? BoxDecoration(
                                    color: AppTheme.colorRed,
                                    borderRadius: AppTheme.borderRadiusSmall,
                                  )
                                : null,
                            padding: AppTheme.paddingTiny,
                            child: Row(
                              children: [
                                CustomIcon(
                                  asset: iconTrial,
                                  color:
                                      _selectedScreen == ScreenType.categories
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorGrey,
                                ),
                                const Spacing(
                                    size: AppTheme.spacingTiny,
                                    isHorizontal: true),
                                Text('Categories',
                                    style: AppTheme.fontStyleDefault.copyWith(
                                      color: _selectedScreen ==
                                              ScreenType.categories
                                          ? AppTheme.colorWhite
                                          : AppTheme.colorGrey,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const Spacing(size: AppTheme.spacingSmall),
                        InkWell(
                          onTap: () {
                            _onTabSelected(ScreenType.coupons);
                          },
                          child: Container(
                            decoration: _selectedScreen == ScreenType.coupons
                                ? BoxDecoration(
                                    color: AppTheme.colorRed,
                                    borderRadius: AppTheme.borderRadiusSmall,
                                  )
                                : null,
                            padding: AppTheme.paddingTiny,
                            child: Row(
                              children: [
                                CustomIcon(
                                  asset: iconTrial,
                                  color: _selectedScreen == ScreenType.coupons
                                      ? AppTheme.colorWhite
                                      : AppTheme.colorGrey,
                                ),
                                const Spacing(
                                    size: AppTheme.spacingTiny,
                                    isHorizontal: true),
                                Text('Coupons',
                                    style: AppTheme.fontStyleDefault.copyWith(
                                      color:
                                          _selectedScreen == ScreenType.coupons
                                              ? AppTheme.colorWhite
                                              : AppTheme.colorGrey,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const Spacing(size: AppTheme.spacingSmall),
                        InkWell(
                          onTap: () {
                            _onTabSelected(ScreenType.settings);
                          },
                          child: Container(
                            decoration: _selectedScreen == ScreenType.settings
                                ? BoxDecoration(
                                    color: AppTheme.colorRed,
                                    borderRadius: AppTheme.borderRadiusSmall,
                                  )
                                : null,
                            padding: AppTheme.paddingTiny,
                            child: Row(
                              children: [
                                CustomIcon(
                                  asset: iconTrial,
                                  color: _selectedScreen == ScreenType.settings
                                      ? AppTheme.colorWhite
                                      : AppTheme.colorGrey,
                                ),
                                const Spacing(
                                    size: AppTheme.spacingTiny,
                                    isHorizontal: true),
                                Text('Settings',
                                    style: AppTheme.fontStyleDefault.copyWith(
                                      color:
                                          _selectedScreen == ScreenType.settings
                                              ? AppTheme.colorWhite
                                              : AppTheme.colorGrey,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacing(size: AppTheme.spacingSmall, isHorizontal: true),
                Expanded(
                  child: widget.child,
                ),
              ],
            ),
          )
        : const CustomLoading();
  }
}
