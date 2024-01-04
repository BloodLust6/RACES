import 'package:flutter/material.dart';
import 'package:races/features/information/model/information_model.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/helpers/helper_functions.dart';
import 'package:url_launcher/link.dart';

class InformationBox extends StatelessWidget {
  const InformationBox({
    super.key,
    required this.information,
  });

  final InformationModel information;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
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
        ],
      ),
    );
  }
}
