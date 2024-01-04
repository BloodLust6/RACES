import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:races/features/authentication/controllers/signup/signup_contoller.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/helpers/helper_functions.dart';

class STermsAndConditionsCheckbox extends StatelessWidget {
  const STermsAndConditionsCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = SHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: SSizes.defaultSpace,
          height: SSizes.defaultSpace,
          child: Obx(() => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) => controller.privacyPolicy.value =
                  !controller.privacyPolicy.value)),
        ),
        const SizedBox(width: SSizes.spaceBtwItems),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${STexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: STexts.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? SColors.white : SColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? SColors.white : SColors.primary,
                    ),
              ),
              TextSpan(
                text: ' ${STexts.and} ',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextSpan(
                text: STexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? SColors.white : SColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? SColors.white : SColors.primary,
                    ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
