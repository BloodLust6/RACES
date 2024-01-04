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
class UpdateNameControllerDoctor extends GetxController {
  static UpdateNameControllerDoctor get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  //init user data when Home Screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  //fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
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
      if (!updateUserNameFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //update user's first & last name in the Firebase Firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      //update the Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      //remove loader
      SFullScreenLoader.stopLoading();

      //show success message
      SLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your Name has been updated.');

      //move to previous screen
      Get.off(() => const NavigationMenuDoctor());
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
