import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:races/data/repositories/dependent/dependent_repository.dart';
import 'package:races/features/dependent/model/dependent_model.dart';
import 'package:races/routes/routes.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/helpers/network_manager.dart';
import 'package:races/utils/popups/full_screen_loader.dart';
import 'package:races/utils/popups/loaders.dart';

class DependentController extends GetxController {
  static DependentController get instance => Get.find();
  // Variables
  Rx<DependentModel> dependent = DependentModel.empty().obs;
  final name = TextEditingController();
  Rx<String> gender = Rx<String>('');
  final dob = TextEditingController();
  final relation = TextEditingController();
  final dependentRepository = Get.put(DependentRepository());
  GlobalKey<FormState> dependentFormKey = GlobalKey<FormState>();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  @override
  void onInit() {
    super.onInit();
    // Initialize the dependent observable
    dependent.value = DependentModel.empty();
  }

  void createDependent() async {
    try {
      SFullScreenLoader.openLoadingDialog(
          'We are creating your dependent...', SImages.docer);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }
      if (!dependentFormKey.currentState!.validate() &&
          !formKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }
      // Save authenticated user data
      final newDependent = DependentModel(
        name: '${name.text.trim()} (D)',
        gender: gender.value,
        dob: dob.text.trim(),
        relation: relation.text.trim(),
      );
      // Update the dependent observable
      dependent.value = newDependent;
      final dependentRepository = Get.put(DependentRepository());
      await dependentRepository.saveDependentRecord(newDependent);
      SFullScreenLoader.stopLoading();
      SLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your information has been created!');
      Get.toNamed(SRoutes.dependent);
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //delete dependent warning
  void deleteDependentWarningPopup(String dependentId) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(SSizes.md),
      title: 'Delete Dependent',
      middleText: 'Are you sure you want to delete this dependent permanently?',
      confirm: ElevatedButton(
        onPressed: () async {
          // Call the deleteDependent method with the dependentId
          deleteDependent(dependentId);

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

  //delete dependent
  void deleteDependent(String dependentId) async {
    try {
      SFullScreenLoader.openLoadingDialog('Processing', SImages.docer);

      // Call the deleteDependentRecord method from the repository
      await dependentRepository.deleteDependentRecord(dependentId);

      // Remove loader
      SFullScreenLoader.stopLoading();

      // Show success message
      SLoaders.successSnackBar(
          title: 'Success', message: 'Dependent deleted successfully!');
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
