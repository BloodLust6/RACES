import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:races/common/widgets/login_signup/form_divider.dart';
import 'package:races/common/widgets/login_signup/social_buttons.dart';
import 'package:races/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Text(STexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: SSizes.spaceBtwSections),

              //form
              const SSignupForm(),
              const SizedBox(height: SSizes.spaceBtwSections),

              //divider
              SFormDivider(dividerText: STexts.orSignUpWith.capitalize!),
              const SizedBox(height: SSizes.spaceBtwSections),

              //social button
              const SSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
