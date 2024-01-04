import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/common/widgets/appbar/appbar.dart';
import 'package:races/data/repositories/dependent/dependent_repository.dart';
import 'package:races/features/medication/controllers/medication_controller.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';

class CreateMedicationScreen extends StatefulWidget {
  const CreateMedicationScreen({super.key});

  @override
  State<CreateMedicationScreen> createState() => _CreateMedicationScreenState();
}

class _CreateMedicationScreenState extends State<CreateMedicationScreen> {
  bool romHasError = false;
  bool nameHasError = false;

  List<String> nameOptions = [];

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
  void initState() {
    super.initState();
    fetchUserAndDependentNames();
  }

  // Function to fetch user and dependent names
  void fetchUserAndDependentNames() async {
    try {
      final userAndDependentNames =
          await DependentRepository.instance.getUserAndDependentNames();
      setState(() {
        nameOptions = userAndDependentNames;
      });
    } catch (e) {
      print('Error fetching user and dependent names: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MedicationController());

    return Form(
      key: controller.medicationFormKey,
      child: Scaffold(
        appBar: SAppBar(
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
                    // rom builder
                    FormBuilder(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          //name
                          FormBuilderDropdown<String>(
                            name: 'name',
                            decoration: InputDecoration(
                              labelText: 'Name',
                              suffix: nameHasError
                                  ? const Icon(Icons.error)
                                  : const Icon(Icons.check),
                              hintText: 'Select your patient',
                            ),
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                            items: nameOptions
                                .map((name) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: name,
                                      child: Text(name),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                romHasError = !(controller
                                        .formKey.currentState?.fields['name']
                                        ?.validate() ??
                                    false);
                                controller.name.text = value ?? '';
                              });
                            },
                            valueTransformer: (value) => value?.toString(),
                          ),
                          const SizedBox(height: SSizes.spaceBtwInputFields),
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
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwSections),

                // Create Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.createMedication(),
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
