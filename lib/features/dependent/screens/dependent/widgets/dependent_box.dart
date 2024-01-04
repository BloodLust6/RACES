import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/features/dependent/controllers/dependent_controller.dart';
import 'package:races/features/dependent/model/dependent_model.dart';
import 'package:races/features/dependent/screens/update_dependent/update_dependent.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/helpers/helper_functions.dart';

class DependentBox extends StatelessWidget {
  const DependentBox({
    super.key,
    required this.dependent,
  });

  final DependentModel dependent;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final controller = DependentController.instance;
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
            'Name: ${dependent.name}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: SSizes.sm,
          ),
          Text(
            'Gender: ${dependent.gender}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: SSizes.sm),
          Text(
            'Date of Birth: ${dependent.dob}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: SSizes.sm),
          Text(
            'Relation: ${dependent.relation}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: SSizes.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Iconsax.edit),
                onPressed: () => Get.to(
                  () => UpdateDependentScreen(
                    id: dependent.id,
                    dependent: dependent,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Iconsax.note_remove),
                onPressed: () =>
                    controller.deleteDependentWarningPopup(dependent.id),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
