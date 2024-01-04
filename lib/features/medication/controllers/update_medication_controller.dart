import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:races/data/repositories/medication/medication_repository.dart';
import 'package:races/features/medication/controllers/medication_controller.dart';
import 'package:races/routes/routes.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/helpers/network_manager.dart';
import 'package:races/utils/popups/full_screen_loader.dart';
import 'package:races/utils/popups/loaders.dart';

//controller to manage medication-related functionality
class UpdateMedicationController extends GetxController {
  static UpdateMedicationController get instance => Get.find();
  final status = TextEditingController();
  final message = TextEditingController();
  final medicationController = MedicationController.instance;
  final medicationRepository = Get.put(MedicationRepository());
  GlobalKey<FormState> updateMedicationFormKey = GlobalKey<FormState>();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  //init user data when Home Screen appears
  @override
  void onInit() {
    initializeDependents();
    super.onInit();
  }

  //fetch user record
  Future<void> initializeDependents() async {
    status.text = medicationController.medication.value.status;
    message.text = medicationController.medication.value.message;
  }

  Future<void> updateMedication(String uid, String id) async {
    try {
      //start loading
      SFullScreenLoader.openLoadingDialog(
          'We are updating the medication...', SImages.docer);
      //check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }
      //form validation
      if (!updateMedicationFormKey.currentState!.validate() &&
          !formKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }
      //update medication' details in the Firebase Firestore
      Map<String, dynamic> detailsMedication = {
        'Status': status.text.trim(),
        'Message': message.text.trim(),
      };
      await medicationRepository.updateMedicationRecord(
          uid, id, detailsMedication);
      //update the Rx Information value
      medicationController.medication.value.status = status.text.trim();
      medicationController.medication.value.message = message.text.trim();
      //remove loader
      SFullScreenLoader.stopLoading();

      //show success message
      SLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Medication has been updated.');

      //move to previous screen
      Get.toNamed(SRoutes.navnurse);
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message: 'Something went wrong. Please try again.');
    }
  }
}
