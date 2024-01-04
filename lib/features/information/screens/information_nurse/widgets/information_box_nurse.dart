import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/features/information/controllers/information_controller.dart';
import 'package:races/features/information/model/information_model.dart';
import 'package:races/features/information/screens/update_information/update_information.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/helpers/helper_functions.dart';
import 'package:url_launcher/link.dart';

class InformationNurseBox extends StatelessWidget {
  const InformationNurseBox({
    super.key,
    required this.information,
  });

  final InformationModel information;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    final controller = InformationController.instance;
    final websiteUri = Uri.parse(information.link);
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
            information.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: SSizes.xs,
          ),
          Text(
            'by ${information.informant}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: SSizes.sm),
          Text(
            'Detail: ${information.detail}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: SSizes.xs),
          Text(
            'For more information: ',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Link(
            uri: websiteUri,
            target: LinkTarget.defaultTarget,
            builder: (context, openLink) => TextButton(
              onPressed: openLink,
              child: Text(websiteUri.toString()),
            ),
          ),
          const SizedBox(height: SSizes.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Iconsax.edit),
                onPressed: () => Get.to(
                  () => UpdateInformationScreen(
                    id: information.id,
                    information: information,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Iconsax.note_remove),
                onPressed: () =>
                    controller.deleteInformationWarningPopup(information.id),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
