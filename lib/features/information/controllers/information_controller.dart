import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:races/data/repositories/information/information_repository.dart';
import 'package:races/features/information/model/information_model.dart';
import 'package:races/routes/routes.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/helpers/network_manager.dart';
import 'package:races/utils/popups/full_screen_loader.dart';
import 'package:races/utils/popups/loaders.dart';

class InformationController extends GetxController {
  static InformationController get instance => Get.find();

  // Variables
  Rx<InformationModel> information = InformationModel.empty().obs;
  final informant = TextEditingController();
  final title = TextEditingController();
  final detail = TextEditingController();
  final link = TextEditingController();
  final informationRepository = Get.put(InformationRepository());
  GlobalKey<FormState> informationFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Initialize the information observable
    information.value = InformationModel.empty();
  }

  // Add information
  void createInformation() async {
    try {
      // Start loading
      SFullScreenLoader.openLoadingDialog(
          'We are creating your information...', SImages.docer);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove loader
        SFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!informationFormKey.currentState!.validate()) {
        // Remove loader
        SFullScreenLoader.stopLoading();
        return;
      }

      // Save authenticated user data
      final newInformation = InformationModel(
        informant: informant.text.trim(),
        title: title.text.trim(),
        detail: detail.text.trim(),
        link: link.text.trim(),
      );

      // Update the information observable
      information.value = newInformation;

      final informationRepository = Get.put(InformationRepository());
      await informationRepository.saveInformationRecord(newInformation);

      // Remove loader
      SFullScreenLoader.stopLoading();

      // Show success message
      SLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your information has been created!');

      // Move to information screen
      Get.toNamed(SRoutes.infonurse);
    } catch (e) {
      // Remove loader
      SFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //delete information warning
  void deleteInformationWarningPopup(String informationId) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(SSizes.md),
      title: 'Delete Information',
      middleText:
          'Are you sure you want to delete this information permanently?',
      confirm: ElevatedButton(
        onPressed: () async {
          // Call the deleteInformation method with the informationId
          deleteInformation(informationId);

          // Close the dialog
          Navigator.of(Get.overlayContext!).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: SSizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  //delete information
  void deleteInformation(String informationId) async {
    try {
      SFullScreenLoader.openLoadingDialog('Processing', SImages.docer);

      // Call the deleteInformationRecord method from the repository
      await informationRepository.deleteInformationRecord(informationId);

      // Remove loader
      SFullScreenLoader.stopLoading();

      // Show success message
      SLoaders.successSnackBar(
          title: 'Success', message: 'Information deleted successfully!');
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
