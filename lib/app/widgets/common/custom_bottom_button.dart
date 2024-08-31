import 'package:flutter/material.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class CustomBottomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool isDisabled;

  const CustomBottomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: isDisabled ? AppTheme.colorDisabled : AppTheme.colorMain,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              label,
              style: AppTheme.fontStyleDefaultBold.copyWith(
                color: AppTheme.colorWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
