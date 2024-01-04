import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:races/common/widgets/appbar/appbar.dart';
import 'package:races/features/personalization/controllers/update_controller/update_dob_controller.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/validators/validation.dart';

class ChangeDateOfBirth extends StatefulWidget {
  const ChangeDateOfBirth({super.key});

  @override
  State<ChangeDateOfBirth> createState() => _ChangeDateOfBirthState();
}

class _ChangeDateOfBirthState extends State<ChangeDateOfBirth> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateDateOfBirthController());
    return Scaffold(
      //custom appbar
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(
          'Change Date of Birth',
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
              'This information is required for your date of birth and will be kept confidential.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: SSizes.spaceBtwSections),

            //text field and button
            Form(
              key: controller.updateUserDateOfBirthFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.dob,
                    validator: (value) =>
                        SValidator.validateEmptyText('Date of Birth', value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: STexts.dob,
                      prefixIcon: Icon(Iconsax.calendar),
                    ),
                    onTap: () async {
                      DateTime? dateTime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1923),
                        lastDate: DateTime(2024),
                      );
                      if (dateTime != null) {
                        setState(
                          () {
                            controller.dob.text =
                                DateFormat('dd-MM-yyy').format(dateTime);
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwSections),

            //save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserDateOfBirth(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
