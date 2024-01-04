import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/common/widgets/appbar/appbar.dart';
import 'package:races/features/personalization/controllers/update_controller/update_phonenumber_controller.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/validators/validation.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneNumberController());
    return Scaffold(
      //custom appbar
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(
          'Change Phone Number',
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
              'We will only use this phone number for account-related communication and will keep it confidential. ',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: SSizes.spaceBtwSections),

            //text field and button
            Form(
              key: controller.updateUserPhoneNumberFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.phoneNumber,
                    validator: (value) =>
                        SValidator.validateEmptyText('Phone Number', value),
                    expands: false,
                    decoration: const InputDecoration(
                      hintText: '0123456789',
                      labelText: STexts.phoneNo,
                      prefixIcon: Icon(Iconsax.call),
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
                onPressed: () => controller.updateUserPhoneNumber(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
