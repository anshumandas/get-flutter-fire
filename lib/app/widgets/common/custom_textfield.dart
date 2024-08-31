
import 'package:flutter/material.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';


class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle:
            AppTheme.fontStyleDefault.copyWith(color: AppTheme.greyTextColor),
        contentPadding: const EdgeInsets.only(left: 8.0),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.borderColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.colorRed),
        ),
      ),
      style: AppTheme.fontStyleDefault,
    );
  }
}
