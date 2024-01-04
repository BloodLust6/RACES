import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/features/authentication/controllers/login/login_controller.dart';
import 'package:races/routes/routes.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/validators/validation.dart';

class SLoginForm extends StatelessWidget {
  const SLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SSizes.spaceBtwSections),
        child: Column(
          children: [
            //email
            TextFormField(
              controller: controller.email,
              validator: (value) => SValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: STexts.email,
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
            const SizedBox(height: SSizes.spaceBtwInputFields / 2),

            //remember me & forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //remember me
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value),
                    ),
                    const Text(STexts.rememberMe),
                  ],
                ),

                //forget password
                TextButton(
                  onPressed: () => Get.toNamed(SRoutes.frgetpass),
                  child: const Text(STexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: SSizes.spaceBtwSections),

            //sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignIn(),
                child: const Text(STexts.signIn),
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwItems),

            //create account button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.toNamed(SRoutes.signup),
                child: const Text(STexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
