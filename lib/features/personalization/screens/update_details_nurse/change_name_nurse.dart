import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/common/widgets/appbar/appbar.dart';
import 'package:races/features/personalization/controllers/update_controller_nurse/update_name_controller_nurse.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/validators/validation.dart';

class ChangeNameNurse extends StatelessWidget {
  const ChangeNameNurse({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameControllerNurse());
    return Scaffold(
      //custom appbar
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(SSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Headings
            Text(
              'Use real name for easy verification. This name will appear on several pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: SSizes.spaceBtwSections),

            //text field and button
            Form(
              key: controller.updateUserNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        SValidator.validateEmptyText('First Name', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: STexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: SSizes.spaceBtwInputFields),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        SValidator.validateEmptyText('Last Name', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: STexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwSections),

            //save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserNameNurse(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
