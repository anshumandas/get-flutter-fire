import 'package:flutter/material.dart';
import 'package:streakzy/utils/constants/image_strings.dart';

import 'image_text_widgets/vertical_image_text.dart';
class SHomeCategories extends StatelessWidget {
  const SHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return SVerticalImageText(image: SImages.shoeIcon, title: 'Shoes', onTap: (){},);
        },
      ),
    );
  }
}