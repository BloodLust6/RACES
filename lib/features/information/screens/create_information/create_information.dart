import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:races/common/widgets/appbar/appbar.dart';
import 'package:races/features/information/controllers/information_controller.dart';
import 'package:races/features/information/screens/create_information/widgets/create_information_form.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';

class CreateInformationScreen extends StatelessWidget {
  const CreateInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InformationController());
    return Form(
      key: controller.informationFormKey,
      child: Scaffold(
        appBar: SAppBar(
          showBackArrow: true,
          title: Text(
            STexts.clinicTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(SSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //form
                SCreateInformationForm(controller: controller),
                const SizedBox(height: SSizes.spaceBtwSections),

                //create button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.createInformation(),
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
