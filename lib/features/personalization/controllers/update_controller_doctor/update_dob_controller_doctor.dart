import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:races/data/repositories/user/user_repository.dart';
import 'package:races/features/personalization/controllers/user_controller.dart';
import 'package:races/navigation_menu/navigation_menu_doctor.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/helpers/network_manager.dart';
import 'package:races/utils/popups/full_screen_loader.dart';
import 'package:races/utils/popups/loaders.dart';

//controller to manage user-related functionality
class UpdateDateOfBirthControllerDoctor extends GetxController {
  static UpdateDateOfBirthControllerDoctor get instance => Get.find();

  final dob = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserDateOfBirthFormKey = GlobalKey<FormState>();

  //init user data when Home Screen appears
  @override
  void onInit() {
    initializeDateOfBirth();
    super.onInit();
  }

  //fetch user record
  Future<void> initializeDateOfBirth() async {
    dob.text = userController.user.value.dob;
  }

  Future<void> updateUserDateOfBirth() async {
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
      if (!updateUserDateOfBirthFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //update user's phone date of birth in the Firebase Firestore
      Map<String, dynamic> dateofbirth = {'DateOfBirth': dob.text.trim()};
      await userRepository.updateSingleField(dateofbirth);

      //update the Rx User value
      userController.user.value.dob = dob.text.trim();

      //remove loader
      SFullScreenLoader.stopLoading();

      //show success message
      SLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Date of Birth has been updated.');

      //move to previous screen
      Get.off(() => const NavigationMenuDoctor());
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
