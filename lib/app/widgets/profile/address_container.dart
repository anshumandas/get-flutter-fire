import 'package:flutter/material.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/models/address_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class AddressContainer extends StatelessWidget {
  final AddressModel address;

  final bool isDefault;
  final Function(String) onDelete;
  final Function(String) onSetAsDefault;

  const AddressContainer({
    super.key,
    required this.address,
    required this.isDefault,
    required this.onDelete,
    required this.onSetAsDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppTheme.paddingTiny,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                address.name,
                style: AppTheme.fontStyleDefaultBold.copyWith(
                  color: AppTheme.colorBlack,
                ),
              ),
              if (isDefault)
                Text(
                  ' (Default)',
                  style: AppTheme.fontStyleDefaultBold.copyWith(
                    color: AppTheme.colorRed,
                  ),
                ),
            ],
          ),
          Text(
            '${address.line1}, ${address.line2}',
            style: AppTheme.fontStyleDefault.copyWith(
              color: AppTheme.greyTextColor,
            ),
          ),
          const Spacing(size: AppTheme.spacingTiny),
          Text(
            '${address.district}, ${address.city}',
            style: AppTheme.fontStyleDefault.copyWith(
              color: AppTheme.greyTextColor,
            ),
          ),
          Text.rich(
            TextSpan(
              text: 'Phone Number: ',
              style: AppTheme.fontStyleMedium,
              children: [
                TextSpan(
                  text: address.phoneNumber,
                  style: AppTheme.fontStyleDefaultBold,
                ),
              ],
            ),
          ),
          const Spacing(size: AppTheme.spacingSmall),
          if (!isDefault)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    onSetAsDefault(address.id);
                  },
                  child: Text(
                    'Set as default address',
                    style: AppTheme.fontStyleDefault.copyWith(
                      color: AppTheme.colorRed,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    onDelete(address.id);
                  },
                  child: const Text('Delete', style: AppTheme.fontStyleDefault),
                ),
              ],
            ),
          const Spacing(size: AppTheme.spacingTiny),
        ],
      ),
    );
  }
}
