import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/common/widgets/appbar/appbarpage_doctor.dart';
import 'package:races/features/medication/controllers/medication_controller.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/validators/validation.dart';

class MedicationScreenDoctor extends StatefulWidget {
  const MedicationScreenDoctor({super.key});

  @override
  State<MedicationScreenDoctor> createState() => _MedicationScreenDoctorState();
}

class _MedicationScreenDoctorState extends State<MedicationScreenDoctor> {
  bool romHasError = false;

  var romOptions = [
    'Pain Relief',
    'Allergy',
    'Digestive Health',
    'Skin Care',
    'Eye Care',
    'Oral Health',
    'First Aid',
    'Vitamins and Supplements',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MedicationController());

    return Form(
      key: controller.medicationFormKey,
      child: Scaffold(
        appBar: SAppBarDoctorPage(
          showBackArrow: true,
          title: Text(
            STexts.medicationTitle,
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

                    // rom builder
                    FormBuilder(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          //rom
                          FormBuilderDropdown<String>(
                            name: 'rom',
                            decoration: InputDecoration(
                              labelText: 'Reason of Medication',
                              suffix: romHasError
                                  ? const Icon(Icons.error)
                                  : const Icon(Icons.check),
                              hintText: 'Select your reason',
                            ),
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                            items: romOptions
                                .map((rom) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: rom,
                                      child: Text(rom),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                romHasError = !(controller
                                        .formKey.currentState?.fields['rom']
                                        ?.validate() ??
                                    false);
                                controller.rom.text = value ?? '';
                              });
                            },
                            valueTransformer: (value) => value?.toString(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: SSizes.spaceBtwInputFields),
                    // Notes
                    TextFormField(
                      controller: controller.note,
                      expands: false,
                      decoration: const InputDecoration(
                        hintText: 'Anything to inform ?',
                        labelText: STexts.note,
                        prefixIcon: Icon(Iconsax.note),
                      ),
                    ),
                    const SizedBox(height: SSizes.spaceBtwInputFields),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwSections),

                // Create Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.assignMedication(),
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
