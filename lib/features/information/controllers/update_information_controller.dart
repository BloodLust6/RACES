import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:races/data/repositories/information/information_repository.dart';
import 'package:races/features/information/controllers/information_controller.dart';
import 'package:races/routes/routes.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/helpers/network_manager.dart';
import 'package:races/utils/popups/full_screen_loader.dart';
import 'package:races/utils/popups/loaders.dart';

//controller to manage user-related functionality
class UpdateInformationController extends GetxController {
  static UpdateInformationController get instance => Get.find();

  final informant = TextEditingController();
  final title = TextEditingController();
  final detail = TextEditingController();
  final link = TextEditingController();
  final informationController = InformationController.instance;
  final informationRepository = Get.put(InformationRepository());
  GlobalKey<FormState> updateInformationFormKey = GlobalKey<FormState>();

  //init user data when Home Screen appears
  @override
  void onInit() {
    initializeInformations();
    super.onInit();
  }

  //fetch user record
  Future<void> initializeInformations() async {
    informant.text = informationController.information.value.informant;
    title.text = informationController.information.value.title;
    detail.text = informationController.information.value.detail;
    link.text = informationController.information.value.link;
  }

  Future<void> updateInformation(String id) async {
    try {
      //start loading
      SFullScreenLoader.openLoadingDialog(
          'We are updating your information', SImages.docer);

      //check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!updateInformationFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //update informations' details in the Firebase Firestore
      Map<String, dynamic> detailsInformation = {
        'Informant': informant.text.trim(),
        'Title': title.text.trim(),
        'Detail': detail.text.trim(),
        'Link': link.text.trim(),
      };
      await informationRepository.updateInformationRecord(
          id, detailsInformation);

      //update the Rx Information value
      informationController.information.value.informant = informant.text.trim();
      informationController.information.value.title = title.text.trim();
      informationController.information.value.detail = detail.text.trim();
      informationController.information.value.link = link.text.trim();

      //remove loader
      SFullScreenLoader.stopLoading();

      //show success message
      SLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Information has been updated.');

      //move to previous screen
      Get.toNamed(SRoutes.infonurse);
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message: 'Something went wrong. Please try again.');
    }
  }
}
