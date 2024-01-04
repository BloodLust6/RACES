import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/common/widgets/appbar/appbar.dart';
import 'package:races/features/personalization/controllers/update_controller/update_username_controller.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/validators/validation.dart';

class ChangeUsername extends StatelessWidget {
  const ChangeUsername({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUsernameController());
    return Scaffold(
      //custom appbar
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(
          'Change Userame',
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
              'Use unique username for easy identification. This username must easy to be remember.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: SSizes.spaceBtwSections),

            //text field and button
            Form(
              key: controller.updateUserUsernameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.username,
                    validator: (value) =>
                        SValidator.validateEmptyText('Username', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: STexts.username,
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
                onPressed: () => controller.updateUserUsername(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
