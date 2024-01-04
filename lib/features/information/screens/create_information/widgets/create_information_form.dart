import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/features/information/controllers/information_controller.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/validators/validation.dart';

class SCreateInformationForm extends StatelessWidget {
  const SCreateInformationForm({
    super.key,
    required this.controller,
  });

  final InformationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //informant
        TextFormField(
          validator: (value) =>
              SValidator.validateEmptyText('Informant', value),
          controller: controller.informant,
          expands: false,
          decoration: const InputDecoration(
            labelText: STexts.informant,
            prefixIcon: Icon(Iconsax.user),
          ),
        ),
        const SizedBox(height: SSizes.spaceBtwInputFields),
        //title
        TextFormField(
          validator: (value) => SValidator.validateEmptyText('Title', value),
          controller: controller.title,
          expands: false,
          decoration: const InputDecoration(
            labelText: STexts.title,
            prefixIcon: Icon(Iconsax.info_circle),
          ),
        ),
        const SizedBox(height: SSizes.spaceBtwInputFields),
        //details
        TextFormField(
          validator: (value) => SValidator.validateEmptyText('Detail', value),
          controller: controller.detail,
          expands: false,
          decoration: const InputDecoration(
            labelText: STexts.detail,
            prefixIcon: Icon(Iconsax.document_text),
          ),
        ),
        const SizedBox(height: SSizes.spaceBtwInputFields),
        //link
        TextFormField(
          validator: (value) => SValidator.validateEmptyText('Link', value),
          controller: controller.link,
          expands: false,
          decoration: const InputDecoration(
            labelText: STexts.link,
            prefixIcon: Icon(Iconsax.link),
          ),
        ),
      ],
    );
  }
}
