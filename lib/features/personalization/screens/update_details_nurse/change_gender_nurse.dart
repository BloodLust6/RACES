import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:races/common/widgets/appbar/appbar.dart';
import 'package:races/features/personalization/controllers/update_controller_nurse/update_gender_controller_nurse.dart';
import 'package:races/utils/constants/sizes.dart';

enum GenderTypeEnum { male, female }

class ChangeGenderNurse extends StatefulWidget {
  const ChangeGenderNurse({super.key});

  @override
  State<ChangeGenderNurse> createState() => _ChangeGenderNurseState();
}

class _ChangeGenderNurseState extends State<ChangeGenderNurse> {
  void onChanged(dynamic value) {
    final controller = Get.find<UpdateGenderControllerNurse>();
    controller.gender.value = value;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateGenderControllerNurse());
    return Scaffold(
      //custom appbar
      appBar: SAppBar(
        showBackArrow: true,
        title: Text(
          'Change Gender',
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
              'Please select your gender with the given options below:',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: SSizes.spaceBtwSections),

            //text field and button
            FormBuilder(
              key: controller.updateGenderFormKey,
              child: Column(
                children: [
                  FormBuilderRadioGroup<String>(
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                    ),
                    initialValue: null,
                    name: 'gender',
                    onChanged: onChanged,
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    options: [
                      'Male',
                      'Female',
                    ]
                        .map(
                          (gender) => FormBuilderFieldOption(
                            value: gender,
                          ),
                        )
                        .toList(growable: false),
                    controlAffinity: ControlAffinity.leading,
                  ),
                ],
              ),
            ),

            const SizedBox(height: SSizes.spaceBtwSections),

            //save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserGender(),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
