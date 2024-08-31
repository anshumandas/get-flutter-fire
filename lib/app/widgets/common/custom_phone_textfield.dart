import 'package:flutter/material.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class PhoneTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool readOnly;
  const PhoneTextField(
      {super.key,
      this.controller,
      required this.hintText,
      required this.readOnly});

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.readOnly ? AppTheme.backgroundColor : Colors.transparent,
        border: widget.readOnly
            ? const Border(
                bottom: BorderSide(
                  color: AppTheme.borderColor,
                  width: 1.0,
                ),
              )
            : null,
      ),
      child: widget.readOnly ? _buildReadOnlyField() : _buildEditableField(),
    );
  }

  Widget _buildReadOnlyField() {
    final phoneNumber = widget.controller?.text ?? '';

    return Padding(
      padding: const EdgeInsets.all(AppTheme.fontSizeSmall),
      child: Row(
        children: [
          const Spacing(size: AppTheme.spacingSmall, isHorizontal: true),
          Text(
            "+91",
            style: AppTheme.fontStyleDefault.copyWith(
              color: AppTheme.colorBlack,
            ),
          ),
          const Spacing(size: AppTheme.spacingSmall, isHorizontal: true),
          Container(
            width: 1,
            height: 20,
            color: AppTheme.greyTextColor,
          ),
          const Spacing(size: AppTheme.spacingSmall, isHorizontal: true),
          Expanded(
            child: Text(
              phoneNumber.substring(3),
              style: AppTheme.fontStyleDefault,
            ),
          ),
          const SizedBox(width: 8),
          // const CustomIcon(asset: iconCheckCircle),
        ],
      ),
    );
  }

  Widget _buildEditableField() {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      style: AppTheme.fontStyleDefault,
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      cursorColor: AppTheme.colorRed,
      maxLength: 10,
      readOnly: widget.readOnly,
      onChanged: (value) {
        if (value.length == 10) {
          FocusScope.of(context).unfocus();
        }
      },
      decoration: InputDecoration(
        counterText: '',
        isDense: true,
        hintText: widget.hintText,
        hintStyle: AppTheme.fontStyleDefault.copyWith(
          color: AppTheme.greyTextColor,
        ),
        border: AppTheme.textfieldUnderlineBorder,
        focusedBorder: AppTheme.textfieldUnderlineBorder,
        enabledBorder: AppTheme.textfieldUnderlineBorder,
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacing(size: AppTheme.spacingSmall, isHorizontal: true),
            Text(
              "+91",
              style: AppTheme.fontStyleDefault.copyWith(
                color: AppTheme.colorBlack,
              ),
            ),
            const Spacing(size: AppTheme.spacingSmall, isHorizontal: true),
            Container(
              width: 1,
              height: 20,
              color: AppTheme.greyTextColor,
            ),
            const Spacing(size: AppTheme.spacingSmall, isHorizontal: true),
          ],
        ),
      ),
    );
  }
}
