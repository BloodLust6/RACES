import 'package:flutter/material.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/helpers/helper_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class SCategoryCard extends StatelessWidget {
  final String iconImagePath;
  final String categoryName;
  final String websiteUri;

  const SCategoryCard({
    super.key,
    required this.iconImagePath,
    required this.categoryName,
    required this.websiteUri,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: GestureDetector(
        onTap: () {
          launchUrl(
            Uri.parse(websiteUri),
            mode: LaunchMode.inAppWebView,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: dark ? SColors.grey : SColors.accent,
          ),
          child: Row(
            children: [
              Image.asset(
                iconImagePath,
                height: 30,
              ),
              const SizedBox(width: 10),
              Text(categoryName)
            ],
          ),
        ),
      ),
    );
  }
}
