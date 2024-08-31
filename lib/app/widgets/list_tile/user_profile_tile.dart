import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:streakzy/utils/constants/colors.dart';
import 'package:streakzy/utils/constants/image_strings.dart';

import '../custom_shapes/containers/circular_container.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key, required  this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: TCircularImage,
      leading: const SCircularContainer(
        image: SImages.user,
        width: 50,
        height: 50,
        padding: 0 ,
      ),
      title: Text('Kenneth Rebello', style: Theme.of(context).textTheme.headlineSmall!.apply(color: SColors.white)),
      subtitle: Text('kenneth.rebello@mitwpu.edu.in', style: Theme.of(context).textTheme.bodyMedium!.apply(color: SColors.white)),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit, color: SColors.white)),
    );
  }
}