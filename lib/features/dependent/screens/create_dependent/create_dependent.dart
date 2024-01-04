import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:races/common/widgets/appbar/appbar.dart';
import 'package:races/features/dependent/controllers/dependent_controller.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/validators/validation.dart';

class CreateDependentScreen extends StatefulWidget {
  const CreateDependentScreen({super.key});

  @override
  State<CreateDependentScreen> createState() => _CreateDependentScreenState();
}

class _CreateDependentScreenState extends State<CreateDependentScreen> {
  bool relationHasError = false;

  var relationOptions = [
    'Spouse',
    'Child',
    'Siblings',
    'Parents/ Parents-in-law',
    'Grandparents',
    'Guardian',
    'Others',
  ];

  void onChanged(dynamic value) {
    final controller = Get.find<DependentController>();
    controller.gender.value = value;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DependentController());

    return Form(
      key: controller.dependentFormKey,
      child: Scaffold(
        appBar: SAppBar(
          showBackArrow: true,
          title: Text(
            STexts.dependentTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(SSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Form
                Column(
                  children: [
                    // Name
                    TextFormField(
                      validator: (value) =>
                          SValidator.validateEmptyText('Name', value),
                      controller: controller.name,
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: STexts.name,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    const SizedBox(height: SSizes.spaceBtwInputFields),

                    // Date of Birth
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
                    const SizedBox(height: SSizes.spaceBtwInputFields),

                    // Gender Radio Buttons
                    FormBuilder(
                      key: controller.formKey,
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
                          const SizedBox(height: SSizes.spaceBtwInputFields),
                          //relation
                          FormBuilderDropdown<String>(
                            name: 'relation',
                            decoration: InputDecoration(
                              labelText: 'Relation',
                              suffix: relationHasError
                                  ? const Icon(Icons.error)
                                  : const Icon(Icons.check),
                              hintText: 'Select Relation',
                            ),
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                            items: relationOptions
                                .map((relation) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: relation,
                                      child: Text(relation),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                relationHasError = !(controller.formKey
                                        .currentState?.fields['relation']
                                        ?.validate() ??
                                    false);
                                controller.relation.text = value ?? '';
                              });
                            },
                            valueTransformer: (value) => value?.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwSections),
                // Create Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.createDependent(),
                    child: const Text(STexts.sConfirm),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
