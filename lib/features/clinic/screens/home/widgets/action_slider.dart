import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:races/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:races/common/widgets/images/s_rounded_image.dart';
import 'package:races/features/clinic/controllers/home_controller.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/constants/sizes.dart';

class SActionSlider extends StatelessWidget {
  const SActionSlider({
    super.key,
    required this.banners,
    required this.pages,
  });

  final List<String> banners;
  final List<String> pages;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
          items: banners.asMap().entries.map((entry) {
            final int index = entry.key;
            final String banner = entry.value;
            final String destination = pages[index];

            return GestureDetector(
              onTap: () {
                Get.toNamed(destination);
              },
              child: SRoundedImage(imageUrl: banner),
            );
          }).toList(),
        ),
        const SizedBox(height: SSizes.spaceBtwItems),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banners.length; i++)
                  SCircularContainer(
                    width: 20,
                    height: 4,
                    margin: const EdgeInsets.only(right: 10),
                    backgroundColor: controller.carouselCurrentIndex.value == i
                        ? SColors.darkerGrey
                        : SColors.grey,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
