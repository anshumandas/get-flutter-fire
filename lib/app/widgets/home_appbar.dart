import 'package:flutter/material.dart';
import 'package:streakzy/app/widgets/products/cart/cart_menu_icon.dart';
import 'package:streakzy/utils/constants/colors.dart';
import 'package:streakzy/utils/constants/text_strings.dart';

import 'appbar/appbar.dart';

class SHomeAppBar extends StatelessWidget {
  const SHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(STexts.homeAppbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: SColors.grey)),
          Text(STexts.homeAppbarSubTitle,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: SColors.white)),
        ],
      ),
      actions: [
        SCartCounterIcon(
          onPressed: () {},
          iconColor: SColors.white,
        )
      ],
    );
  }
}