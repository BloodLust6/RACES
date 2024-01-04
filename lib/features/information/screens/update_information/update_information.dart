import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:races/common/widgets/appbar/appbar.dart';
import 'package:races/features/information/controllers/update_information_controller.dart';
import 'package:races/features/information/model/information_model.dart';
import 'package:races/features/information/screens/update_information/widgets/update_information_form.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';

class UpdateInformationScreen extends StatelessWidget {
  final String id;

  // Receive the InformationModel as a parameter
  final InformationModel information;

  // Add the information parameter to the constructor
  const UpdateInformationScreen({
    super.key,
    required this.id,
    required this.information,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateInformationController());
    // Set the text field controllers with the information details
    controller.informant.text = information.informant;
    controller.title.text = information.title;
    controller.detail.text = information.detail;
    controller.link.text = information.link;
    return Form(
      key: controller.updateInformationFormKey,
      child: Scaffold(
        appBar: SAppBar(
          showBackArrow: true,
          title: Text(
            STexts.updateClinic,
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
                SUpdateInformationForm(controller: controller),
                const SizedBox(height: SSizes.spaceBtwSections),
                //update button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        controller.updateInformation(information.id),
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
