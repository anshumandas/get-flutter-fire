import 'package:flutter/material.dart';
import 'package:streakzy/utils/constants/image_strings.dart';
import 'package:streakzy/utils/constants/sizes.dart';
import '../../../widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../widgets/custom_shapes/containers/search_container.dart';
import '../../../widgets/home_appbar.dart';
import '../../../widgets/home_categories.dart';
import '../../../widgets/layouts/grid_layout.dart';
import '../../../widgets/products/product_cards/product_card_vertical.dart';
import '../../../widgets/promo_slider.dart';
import '../../../widgets/texts/section_heading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SPrimaryHeaderContainer(
              child: Column(
                children: [
                  SHomeAppBar(),
                  SizedBox(height: SSizes.spaceBtwSections),
                  SSearchContainer(text: 'Search in store'),
                  SizedBox(height: SSizes.spaceBtwSections),
                  Padding(
                    padding: EdgeInsets.only(left: SSizes.defaultSpace),
                    child: Column(
                      children: [
                        //heading
                        SSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: SSizes.spaceBtwItems),

                        //Categories
                        SHomeCategories(),
                      ],
                    ),
                  ),
                  SizedBox(height: SSizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(SSizes.defaultSpace),
              child: Column(
                children: [
                  //promo slider
                  const SPromoSlider(
                    banners: [
                      SImages.promoBanner1,
                      SImages.promoBanner2,
                      SImages.promoBanner3
                    ],
                  ),
                  const SizedBox(height: SSizes.spaceBtwSections),

                  // const SProductCardVertical(),

                  //Popular products
                  SGridLayout(itemCount: 2, itemBuilder: (_, index) => const SProductCardVertical()),
                ],
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}


