import 'package:flutter/material.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class CartBottomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final String input;
  final bool disabled;

  const CartBottomButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.input,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: AppTheme.paddingDefault,
          decoration: BoxDecoration(
            color: AppTheme.colorWhite,
            boxShadow: AppTheme.cardBoxShadow,
          ),
          child: Material(
            color: disabled ? AppTheme.backgroundColor : AppTheme.colorMain,
            borderRadius: AppTheme.borderRadius,
            child: InkWell(
              onTap: disabled ? null : onPressed,
              child: Container(
                padding: AppTheme.paddingTiny,
                height: AppTheme.spacingExtraLarge,
                decoration: BoxDecoration(
                  borderRadius: AppTheme.borderRadius,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        label,
                        style: AppTheme.fontStyleHeadingDefault.copyWith(
                          color: AppTheme.colorWhite,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppTheme.colorMain,
                        ),
                        padding: AppTheme.paddingTiny,
                        child: Text(
                          input,
                          style: AppTheme.fontStyleHeadingDefault
                              .copyWith(color: AppTheme.colorWhite),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
