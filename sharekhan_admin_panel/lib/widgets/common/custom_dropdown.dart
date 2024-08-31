import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final T? value;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  CustomDropdownState<T> createState() => CustomDropdownState<T>();
}

class CustomDropdownState<T> extends State<CustomDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.borderColor),
        borderRadius: AppTheme.borderRadius,
        color: AppTheme.colorWhite,
      ),
      child: DropdownButtonFormField<T>(
        value: widget.value,
        items: widget.items,
        isExpanded: true,
        iconEnabledColor: AppTheme.borderColor,
        iconDisabledColor: AppTheme.borderColor,
        onChanged: widget.onChanged,
        style: AppTheme.fontStyleDefault.copyWith(
          color: AppTheme.greyTextColor,
        ),
        hint: Text(
          widget.hintText,
          style: AppTheme.fontStyleDefault.copyWith(
            color: AppTheme.greyTextColor,
          ),
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.only(
            top: AppTheme.spacingExtraSmall,
            left: AppTheme.spacingTiny,
            bottom: AppTheme.spacingExtraSmall,
          ),
          hintStyle: AppTheme.fontStyleDefault.copyWith(
            color: AppTheme.greyTextColor,
          ),
          border: AppTheme.textfieldBorder,
          enabledBorder: AppTheme.textfieldBorder,
          focusedBorder: AppTheme.textfieldBorder,
        ),
      ),
    );
  }
}
