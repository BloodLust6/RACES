import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:races/common/widgets/appbar/appbar.dart';
import 'package:races/data/repositories/dependent/dependent_repository.dart';
import 'package:races/features/appointment/controllers/appointment_controller.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({super.key});

  @override
  State<CreateAppointmentScreen> createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  bool roaHasError = false;
  bool nameHasError = false;
  bool dateHasError = false;
  bool slotHasError = false;

  List<String> nameOptions = [];
  List<String> availableTimeSlots = [];

  var roaOptions = [
    'Outpatient Treatment',
    'Medical Tests',
    'Medical Screening',
    'Health Service & Care',
    'Procedures',
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
    final controller = Get.put(AppointmentController());

    return Form(
      child: Scaffold(
        appBar: SAppBar(
          showBackArrow: true,
          title: Text(
            STexts.appointmentTitle,
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
                    // form builder
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
                                nameHasError = !(controller
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
                            name: 'roa',
                            decoration: InputDecoration(
                              labelText: 'Reason of Appointment',
                              suffix: roaHasError
                                  ? const Icon(Icons.error)
                                  : const Icon(Icons.check),
                              hintText: 'Select your reason',
                            ),
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                            items: roaOptions
                                .map((roa) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: roa,
                                      child: Text(roa),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                roaHasError = !(controller
                                        .formKey.currentState?.fields['roa']
                                        ?.validate() ??
                                    false);
                                controller.roa.text = value ?? '';
                              });
                            },
                            valueTransformer: (value) => value?.toString(),
                          ),
                          const SizedBox(height: SSizes.spaceBtwInputFields),
                          // Date Picker
                          FormBuilderDateTimePicker(
                            name: 'date',
                            inputType: InputType.date,
                            format: DateFormat('yyyy-MM-dd'),
                            decoration: const InputDecoration(
                              labelText: 'Select Date',
                            ),
                            onChanged: (DateTime? selectedDate) async {
                              List<String> fetchedSlots = await controller
                                  .fetchAvailableTimeSlots(selectedDate);

                              setState(() {
                                controller.selectedDate = selectedDate;
                                dateHasError = !(controller
                                        .formKey.currentState?.fields['date']
                                        ?.validate() ??
                                    false);
                                availableTimeSlots = fetchedSlots;
                                // Set the selected date in the controller
                                controller.date.text = DateFormat('dd-MM-yyyy')
                                    .format(selectedDate!);
                              });
                            },
                            validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required()],
                            ),
                          ),
                          const SizedBox(height: SSizes.spaceBtwInputFields),
                          // Time Slot Dropdown
                          FormBuilderDropdown<String>(
                            name: 'slot',
                            decoration: InputDecoration(
                              labelText: 'Select Time',
                              suffix: slotHasError
                                  ? const Icon(Icons.error)
                                  : const Icon(Icons.check),
                              hintText: 'Select appointment time',
                            ),
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required()]),
                            items: availableTimeSlots
                                .map(
                                  (slot) => DropdownMenuItem(
                                    alignment: AlignmentDirectional.center,
                                    value: slot,
                                    child: Text(slot),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                slotHasError = !(controller
                                        .formKey.currentState?.fields['slot']
                                        ?.validate() ??
                                    false);
                                controller.slot.text = value ?? '';
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
                    onPressed: () => controller.createAppointment(),
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
