import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/common/widgets/appbar/appbar.dart';
import 'package:races/features/medication/controllers/update_medication_controller.dart';
import 'package:races/features/medication/model/medication_model.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/validators/validation.dart';

class UpdateMedicationScreen extends StatefulWidget {
  final String uid;
  final String id;

  // Receive the InformationModel as a parameter
  final MedicationModel medication;

  // update the medication parameter to the constructor
  const UpdateMedicationScreen({
    super.key,
    required this.uid,
    required this.id,
    required this.medication,
  });

  @override
  State<UpdateMedicationScreen> createState() => _UpdateMedicationScreenState();
}

class _UpdateMedicationScreenState extends State<UpdateMedicationScreen> {
  bool statusHasError = false;

  var statusOptions = [
    'Approved',
    'Rejected',
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateMedicationController());

    return Form(
      key: controller.updateMedicationFormKey,
      child: Scaffold(
        appBar: SAppBar(
          showBackArrow: true,
          title: Text(
            STexts.updateMedic,
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
                    // status builder
                    FormBuilder(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          FormBuilderDropdown<String>(
                            name: 'status',
                            decoration: InputDecoration(
                              labelText: 'Status',
                              suffix: statusHasError
                                  ? const Icon(Icons.error)
                                  : const Icon(Icons.check),
                              hintText: 'Select your status',
                            ),
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                            items: statusOptions
                                .map((status) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: status,
                                      child: Text(status),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                statusHasError = !(controller
                                        .formKey.currentState?.fields['status']
                                        ?.validate() ??
                                    false);
                                controller.status.text = value ?? '';
                              });
                            },
                            valueTransformer: (value) => value?.toString(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: SSizes.spaceBtwInputFields),
                    TextFormField(
                      validator: (value) =>
                          SValidator.validateEmptyText('Message', value),
                      controller: controller.message,
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: STexts.message,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.updateMedication(
                        widget.medication.uid, widget.medication.id),
                    child: const Text(STexts.update),
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
