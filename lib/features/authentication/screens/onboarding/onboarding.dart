import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:races/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:races/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:races/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:races/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:races/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          //horizontal scrollable pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: SImages.onBoardingImage1,
                title: STexts.onBoardingTitle1,
                subTitle: STexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: SImages.onBoardingImage2,
                title: STexts.onBoardingTitle2,
                subTitle: STexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: SImages.onBoardingImage3,
                title: STexts.onBoardingTitle3,
                subTitle: STexts.onBoardingSubTitle3,
              ),
            ],
          ),

          //skip button
          const OnBoardingSkip(),

          //dot navigation smoothpage indicator
          const OnBoardingDotNavigation(),

          //circular button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
