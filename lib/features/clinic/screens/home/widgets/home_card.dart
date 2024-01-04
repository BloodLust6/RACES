import 'package:flutter/material.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/device/device_utility.dart';
import 'package:races/utils/helpers/helper_functions.dart';

class SHomeCard extends StatelessWidget {
  const SHomeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace),
      child: Container(
        width: SDeviceUtils.getScreenWidth(context),
        padding: const EdgeInsets.all(SSizes.md),
        decoration: BoxDecoration(
          color: dark
              ? SColors.lightGrey.withOpacity(0.5)
              : SColors.accent.withOpacity(0.5),
          borderRadius: BorderRadius.circular(SSizes.cardRadiusLg),
          border: Border.all(color: SColors.grey),
        ),
        child: Row(
          children: [
            //animation
            const Image(
              height: 100,
              width: 100,
              image: AssetImage(SImages.medicalCard),
            ),
            const SizedBox(width: SSizes.spaceBtwItems),
            //how can i assist u + medical card
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    STexts.medicalCard,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: SSizes.defaultSpace / 2),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(STexts.getStarted),
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
