import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:races/data/repositories/authentication/authentication_repository.dart';
import 'package:races/data/repositories/medication/medication_repository.dart';
import 'package:races/features/medication/model/medication_model.dart';
import 'package:races/routes/routes.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/helpers/network_manager.dart';
import 'package:races/utils/popups/full_screen_loader.dart';
import 'package:races/utils/popups/loaders.dart';

class MedicationController extends GetxController {
  static MedicationController get instance => Get.find();

  // Variables
  Rx<MedicationModel> medication = MedicationModel.empty().obs;
  final name = TextEditingController();
  final rom = TextEditingController();
  final note = TextEditingController();
  final status = TextEditingController();
  final message = TextEditingController();
  final time = TextEditingController();
  final medicationRepository = Get.put(MedicationRepository());
  GlobalKey<FormState> medicationFormKey = GlobalKey<FormState>();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  void onInit() {
    super.onInit();
    // Initialize the medication observable
    medication.value = MedicationModel.empty();
  }

  // Add medication
  void createMedication() async {
    try {
      // Start loading
      SFullScreenLoader.openLoadingDialog(
          'We are creating your medication...', SImages.docer);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove loader
        SFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!medicationFormKey.currentState!.validate() &&
          !formKey.currentState!.validate()) {
        // Remove loader
        SFullScreenLoader.stopLoading();
        return;
      }

      // Save authenticated user data
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm, dd MMM yyyy').format(now);

      final newMedication = MedicationModel(
        uid: AuthenticationRepository.instance.authUser!.uid,
        name: name.text.trim(),
        rom: rom.text.trim(),
        note: note.text.trim(),
        status: 'InProgress',
        message: message.text.trim(),
        time: formattedTime,
      );

      // Update the medication observable
      medication.value = newMedication;

      final medicationRepository = Get.put(MedicationRepository());
      await medicationRepository.saveMedicationRecord(newMedication);

      // Remove loader
      SFullScreenLoader.stopLoading();

      // Show success message
      SLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your medication has been created!');

      // Move to medication screen
      Get.toNamed(SRoutes.navmenu);
    } catch (e) {
      // Remove loader
      SFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e);
    }
  }

  //delete medication warning
  void deleteMedicationWarningPopup(String medicationId) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(SSizes.md),
      title: 'Cancel Medication',
      middleText: 'Are you sure you want to cancel this medication?',
      confirm: ElevatedButton(
        onPressed: () async {
          // Call the deleteMedication method with the medicationId
          deleteMedication(medicationId);

          // Close the dialog
          Navigator.of(Get.overlayContext!).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: SSizes.lg),
          child: Text('Cancel'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text('Back'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  //delete medication
  void deleteMedication(String medicationId) async {
    try {
      SFullScreenLoader.openLoadingDialog('Processing', SImages.docer);

      // Call the deleteMedicationRecord method from the repository
      await medicationRepository.deleteMedicationRecord(medicationId);

      // Remove loader
      SFullScreenLoader.stopLoading();

      // Show success message
      SLoaders.successSnackBar(
          title: 'Success',
          message: 'Medication has been cancel successfully!');
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //delete medication warning
  void recordWarningPopup({
    required String uid,
    required String id,
    required MedicationModel medication,
  }) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(SSizes.md),
      title: 'Medication Record',
      middleText: 'Are you sure you want to update this detail?',
      confirm: ElevatedButton(
        onPressed: () async {
          // Check if medication status is not 'InProgress' before calling createReport
          if (medication.status != 'InProgress') {
            createReport(uid, id, medication);
            // Close the dialog
            Navigator.of(Get.overlayContext!).pop();
          } else {
            // Remove loader
            SFullScreenLoader.stopLoading();
            // Show some Generic Error to the user
            SLoaders.errorSnackBar(
                title: 'Oh Snap!', message: 'Your Medication is InProgress');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          side: const BorderSide(color: Colors.teal),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: SSizes.lg),
          child: Text('Submit'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text('Back'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  //create report
  void createReport(
    String uid,
    String id,
    MedicationModel medication,
  ) async {
    try {
      // Start loading
      SFullScreenLoader.openLoadingDialog(
          'We are creating medication record...', SImages.docer);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove loader
        SFullScreenLoader.stopLoading();
        return;
      }

      final medicationRepository = Get.put(MedicationRepository());
      await medicationRepository.saveMedicationReport(uid, id);
      await medicationRepository.deleteMedicationReport(uid, id);

      // Remove loader
      SFullScreenLoader.stopLoading();

      // Show success message
      SLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your record has been created!');

      // Move to medication screen
      Get.toNamed(SRoutes.navnurse);
    } catch (e) {
      // Remove loader
      SFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e);
    }
  }

  // Assign medication
  void assignMedication() async {
    try {
      SFullScreenLoader.openLoadingDialog(
          'We are assigning your medication...', SImages.docer);
      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove loader
        SFullScreenLoader.stopLoading();
        return;
      }
      // Form validation
      if (!medicationFormKey.currentState!.validate() &&
          !formKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }
      // Save authenticated user data
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm, dd MMM yyyy').format(now);
      final newMedication = MedicationModel(
        uid: AuthenticationRepository.instance.authUser!.uid,
        name: name.text.trim(),
        rom: rom.text.trim(),
        note: note.text.trim(),
        status: 'Assigned',
        message: message.text.trim(),
        time: formattedTime,
      );
      // Update the medication observable
      medication.value = newMedication;
      final medicationRepository = Get.put(MedicationRepository());
      await medicationRepository.saveMedicationRecord(newMedication);
      SFullScreenLoader.stopLoading();
      // Show success message
      SLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your medication has been assigned!');
      // Move to medication screen
      Get.toNamed(SRoutes.navdoctor);
    } catch (e) {
      // Remove loader
      SFullScreenLoader.stopLoading();
      // Show some Generic Error to the user
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e);
    }
  }
}
