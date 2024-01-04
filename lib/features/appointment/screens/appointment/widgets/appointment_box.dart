import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/features/appointment/controllers/appointment_controller.dart';
import 'package:races/features/appointment/model/appointment_model.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/helpers/helper_functions.dart';

class AppointmentBox extends StatelessWidget {
  const AppointmentBox({
    super.key,
    required this.appointment,
  });

  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final controller = AppointmentController.instance;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name: ${appointment.name}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: SSizes.sm,
          ),
          Text(
            'Reason of Appointment:',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            appointment.roa,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: SSizes.sm),
          Text(
            'Time Applied: ${appointment.time}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: SSizes.sm),
          Text(
            'Appointment Date: ${appointment.date}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: SSizes.sm),
          Text(
            'Time Slot: ${appointment.slot}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: SSizes.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Iconsax.note_remove),
                onPressed: () =>
                    controller.deleteAppointmentWarningPopup(appointment.id),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
