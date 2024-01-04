import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:races/data/repositories/dependent/dependent_repository.dart';
import 'package:races/features/dependent/controllers/dependent_controller.dart';
import 'package:races/routes/routes.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/helpers/network_manager.dart';
import 'package:races/utils/popups/full_screen_loader.dart';
import 'package:races/utils/popups/loaders.dart';

//controller to manage user-related functionality
class UpdateDependentController extends GetxController {
  static UpdateDependentController get instance => Get.find();
  final name = TextEditingController();
  Rx<String> gender = Rx<String>('');
  final dob = TextEditingController();
  final relation = TextEditingController();
  final dependentController = DependentController.instance;
  final dependentRepository = Get.put(DependentRepository());
  GlobalKey<FormState> updateDependentFormKey = GlobalKey<FormState>();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  //init user data when Home Screen appears
  @override
  void onInit() {
    initializeDependents();
    super.onInit();
  }

  //fetch user record
  Future<void> initializeDependents() async {
    name.text = dependentController.dependent.value.name;
    gender.value = dependentController.dependent.value.gender;
    dob.text = dependentController.dependent.value.dob;
    relation.text = dependentController.dependent.value.relation;
  }

  Future<void> updateDependent(String id) async {
    try {
      //start loading
      SFullScreenLoader.openLoadingDialog(
          'We are updating your dependent...', SImages.docer);
      //check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }
      //form validation
      if (!updateDependentFormKey.currentState!.validate() &&
          !formKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //update informations' details in the Firebase Firestore
      Map<String, dynamic> detailsDependent = {
        'Name': name.text.trim(),
        'Gender': gender.value,
        'DateOfBirth': dob.text.trim(),
        'Relation': relation.text.trim(),
      };
      await dependentRepository.updateDependentRecord(id, detailsDependent);

      //update the Rx Information value
      dependentController.dependent.value.name = name.text.trim();
      dependentController.dependent.value.gender = gender.value;
      dependentController.dependent.value.dob = dob.text.trim();
      dependentController.dependent.value.relation = relation.text.trim();

      //remove loader
      SFullScreenLoader.stopLoading();

      //show success message
      SLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Dependent has been updated.');

      //move to previous screen
      Get.toNamed(SRoutes.dependent);
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(
          title: 'Oh Snap!',
          message: 'Something went wrong. Please try again.');
    }
  }
}
