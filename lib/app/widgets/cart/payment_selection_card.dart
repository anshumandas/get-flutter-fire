import 'package:flutter/material.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class PaymentMethodSelectionCard extends StatelessWidget {
  final String paymentMethod;
  final String selectedPaymentMethod;
  final String? label;
  final ValueChanged<String> onChanged;
  final String displayText;

  const PaymentMethodSelectionCard({
    super.key,
    required this.paymentMethod,
    required this.selectedPaymentMethod,
    required this.onChanged,
    required this.displayText,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(paymentMethod);
      },
      child: Container(
        decoration: AppTheme.cardDecoration.copyWith(
          border: Border.all(
            color: AppTheme.borderColor,
            width: 2.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio<String>(
                  value: paymentMethod,
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    if (value != null) {
                      onChanged(value);
                    }
                  },
                  fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppTheme.colorRed;
                    }
                    return Colors.grey;
                  }),
                ),
                Text(
                  displayText,
                  style: AppTheme.fontStyleDefaultBold,
                ),
                const Spacing(
                  size: AppTheme.spacingTiny,
                  isHorizontal: true,
                ),
                Text(
                  label ?? '',
                  style: AppTheme.fontStyleDefaultBold
                      .copyWith(color: AppTheme.colorYellow),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
