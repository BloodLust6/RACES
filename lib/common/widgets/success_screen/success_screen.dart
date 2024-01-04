// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:races/common/styles/spacing_styles.dart';
import 'package:races/features/authentication/screens/login/login.dart';
import 'package:races/routes/routes.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              //image
              Lottie.asset(image,
                  width: MediaQuery.of(context).size.width * 0.6),
              const SizedBox(height: SSizes.spaceBtwSections),

              //title
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SSizes.spaceBtwItems),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: SSizes.spaceBtwSections),

              //button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(SRoutes.login),
                  child: const Text(STexts.sContinue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
