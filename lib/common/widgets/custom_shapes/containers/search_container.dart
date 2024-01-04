import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/device/device_utility.dart';
import 'package:races/utils/helpers/helper_functions.dart';

class SSearchContainer extends StatelessWidget {
  const SSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace),
      child: Container(
        width: SDeviceUtils.getScreenWidth(context),
        padding: const EdgeInsets.all(SSizes.md),
        decoration: BoxDecoration(
          color: showBackground
              ? dark
                  ? SColors.dark
                  : SColors.light
              : Colors.transparent,
          borderRadius: BorderRadius.circular(SSizes.cardRadiusLg),
          border: showBorder ? Border.all(color: SColors.grey) : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: SColors.darkerGrey,
            ),
            const SizedBox(width: SSizes.spaceBtwItems),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
