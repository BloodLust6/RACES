import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/features/authentication/controllers/signup/signup_contoller.dart';
import 'package:races/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/validators/validation.dart';

class SSignupForm extends StatelessWidget {
  const SSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) =>
                      SValidator.validateEmptyText('First Name', value),
                  controller: controller.firstName,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: STexts.firstName,
                    prefix: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: SSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  validator: (value) =>
                      SValidator.validateEmptyText('Last Name', value),
                  controller: controller.lastName,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: STexts.lastName,
                    prefix: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: SSizes.spaceBtwInputFields),

          //username
          TextFormField(
            validator: (value) =>
                SValidator.validateEmptyText('Username', value),
            controller: controller.username,
            expands: false,
            decoration: const InputDecoration(
              labelText: STexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: SSizes.spaceBtwInputFields),

          //email
          TextFormField(
            validator: (value) => SValidator.validateEmail(value),
            controller: controller.email,
            decoration: const InputDecoration(
              labelText: STexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: SSizes.spaceBtwInputFields),

          //phone number
          TextFormField(
            validator: (value) => SValidator.validatePhoneNumber(value),
            controller: controller.phoneNumber,
            decoration: const InputDecoration(
              labelText: STexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: SSizes.spaceBtwInputFields),

          //password
          Obx(
            () => TextFormField(
              validator: (value) => SValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: STexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(controller.hidePassword.value
                      ? Iconsax.eye_slash
                      : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: SSizes.spaceBtwSections),

          //terms and conditions
          const STermsAndConditionsCheckbox(),
          const SizedBox(height: SSizes.spaceBtwSections),

          //sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(STexts.createAccount),
            ),
          )
        ],
      ),
    );
  }
}
