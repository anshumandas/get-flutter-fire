import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.colorWhite,
      body: Center(
        child: CircularProgressIndicator(
          color: AppTheme.colorRed,
        ),
      ),
    );
  }
}
