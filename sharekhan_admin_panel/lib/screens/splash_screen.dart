import 'package:sharekhan_admin_panel/constants/asset_constants.dart';
import 'package:sharekhan_admin_panel/navigation/go_router.dart';
import 'package:sharekhan_admin_panel/navigation/routes.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      router.go(Routes.banners);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorRed,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Designed for the Serious',
                style: AppTheme.fontStyleLarge.copyWith(
                  color: AppTheme.colorWhite,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                )),
            const Spacing(size: AppTheme.spacingLarge),
            Image.asset(imageSplashBanner, width: 500),
            // const Spacing(size: AppTheme.spacingExtraLarge),
            // Image.asset(imageLogoTagline, width: 300),
          ],
        ),
      ),
    );
  }
}
