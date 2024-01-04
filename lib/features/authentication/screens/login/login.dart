import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:races/common/styles/spacing_styles.dart';
import 'package:races/common/widgets/login_signup/form_divider.dart';
import 'package:races/common/widgets/login_signup/social_buttons.dart';
import 'package:races/features/authentication/screens/login/widgets/login_form.dart';
import 'package:races/features/authentication/screens/login/widgets/login_header.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              //logo, title & sub title
              SLoginHeader(dark: dark),

              //form
              const SLoginForm(),

              //divider
              SFormDivider(dividerText: STexts.orSignInWith.capitalize!),
              const SizedBox(height: SSizes.spaceBtwSections),

              //footer
              const SSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
