import 'package:flutter/material.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/models/address_model.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class SelectAddressCard extends StatelessWidget {
  final AddressModel address;
  final bool isDefault;
  final Function(AddressModel) onSelect;
  final String selectedAddressID;

  const SelectAddressCard({
    super.key,
    required this.address,
    required this.onSelect,
    required this.selectedAddressID,
    required this.isDefault,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedAddressID == address.id;

    return GestureDetector(
      onTap: () => onSelect(address),
      child: Container(
        decoration: AppTheme.cardDecoration.copyWith(
          border: Border.all(
            color: isSelected ? AppTheme.colorRed : AppTheme.borderColor,
            width: 2.0,
          ),
        ),
        padding: const EdgeInsets.all(AppTheme.spacingExtraSmall),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: AppTheme.spacingTiny),
              child: Radio<String>(
                activeColor: AppTheme.colorRed,
                value: address.id,
                groupValue: selectedAddressID,
                onChanged: (value) => onSelect(address),
              ),
            ),
            const Spacing(size: AppTheme.spacingExtraLarge),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    style: AppTheme.fontStyleDefault.copyWith(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacing(size: AppTheme.spacingTiny),
                  Text(
                    "${address.line1}\n${address.line2}",
                    maxLines: 2,
                    style: AppTheme.fontStyleDefault,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacing(size: AppTheme.spacingTiny),
                  Text(
                    "${address.district}, ${address.city}",
                    maxLines: 1,
                    style: AppTheme.fontStyleDefault,
                  ),
                  const Spacing(size: AppTheme.spacingTiny),
                  Text(
                    "PhoneNumber ${address.phoneNumber}",
                    maxLines: 2,
                    style: AppTheme.fontStyleDefault,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (isDefault)
                    const Text(
                      'Default Address',
                      style: TextStyle(
                        color: AppTheme.colorRed,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
