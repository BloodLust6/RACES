import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:races/data/repositories/user/user_repository.dart';
import 'package:races/features/personalization/controllers/user_controller.dart';
import 'package:races/navigation_menu/navigation_menu_doctor.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/helpers/network_manager.dart';
import 'package:races/utils/popups/full_screen_loader.dart';
import 'package:races/utils/popups/loaders.dart';

//controller to manage user-related functionality
class UpdateGenderControllerDoctor extends GetxController {
  static UpdateGenderControllerDoctor get instance => Get.find();

  Rx<String> gender = Rx<String>('');
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormBuilderState> updateGenderFormKey =
      GlobalKey<FormBuilderState>();

  //init user data when Home Screen appears
  @override
  void onInit() {
    initializeGender();
    super.onInit();
  }

  //fetch user record
  Future<void> initializeGender() async {
    gender.value = userController.user.value.gender;
  }

  Future<void> updateUserGender() async {
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
      if (!updateGenderFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //update user's gender in the Firebase Firestore
      Map<String, dynamic> sgender = {'Gender': gender.value};
      await userRepository.updateSingleField(sgender);

      //update the Rx User value
      userController.user.value.gender = gender.value;

      //remove loader
      SFullScreenLoader.stopLoading();

      //show success message
      SLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your Gender has been updated.');

      //move to previous screen
      Get.off(() => const NavigationMenuDoctor());
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
