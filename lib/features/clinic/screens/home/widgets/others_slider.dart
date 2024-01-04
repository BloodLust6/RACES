import 'package:flutter/material.dart';
import 'package:races/features/clinic/screens/home/widgets/category_card.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';

class SOthersSlider extends StatelessWidget {
  const SOthersSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: SSizes.defaultSpace),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Others',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: SSizes.spaceBtwItems),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              SCategoryCard(
                websiteUri: 'https://poliklinikabi.com/#about-us',
                iconImagePath: SImages.aboutUs,
                categoryName: STexts.aboutUs,
              ),
              SCategoryCard(
                websiteUri:
                    'https://www.google.com.my/maps/place/POLIKLINIK+ABI+PEKAN/@3.5327195,103.4396285,15z/data=!4m6!3m5!1s0x31cf51ed7dbd2fdb:0xc5d6a0242f4572ad!8m2!3d3.5532139!4d103.3793823!16s%2Fg%2F11hcfq9cl6?entry=ttu',
                iconImagePath: SImages.location,
                categoryName: STexts.location,
              ),
              SCategoryCard(
                websiteUri: 'https://poliklinikabi.com/#contact-us',
                iconImagePath: SImages.feedback,
                categoryName: STexts.feedback,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
