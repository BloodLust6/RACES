import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/features/medication/controllers/medication_controller.dart';
import 'package:races/features/medication/model/medication_model.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/helpers/helper_functions.dart';

class MedicationBox extends StatelessWidget {
  const MedicationBox({
    super.key,
    required this.medication,
  });

  final MedicationModel medication;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final controller = MedicationController.instance;

    // Set text color based on status
    Color statusColor = Colors.black;

    if (medication.status == 'InProgress') {
      statusColor = Colors.blue;
    } else if (medication.status == 'Rejected') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.green;
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: dark ? SColors.darkerGrey : Colors.white,
        borderRadius: BorderRadius.circular(SSizes.cardRadiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Vertical Text
          RotatedBox(
            quarterTurns: -1,
            child: Text(
              medication.status,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: statusColor, // Set text color based on status
                  ),
            ),
          ),
          const SizedBox(width: SSizes.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${medication.name}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: SSizes.sm,
              ),
              Text(
                'Reason of Medication:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                medication.rom,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: SSizes.sm),
              Text(
                'Note: ${medication.note}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: SSizes.sm),
              Text(
                'Time Applied: ${medication.time}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: SSizes.sm),
              Text(
                'Message:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                medication.message,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: SSizes.sm),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Iconsax.note_remove),
                    onPressed: () =>
                        controller.deleteMedicationWarningPopup(medication.id),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
