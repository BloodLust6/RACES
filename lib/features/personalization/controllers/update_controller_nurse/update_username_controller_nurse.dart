import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:races/data/repositories/user/user_repository.dart';
import 'package:races/features/personalization/controllers/user_controller.dart';
import 'package:races/navigation_menu/navigation_menu_nurse.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/helpers/network_manager.dart';
import 'package:races/utils/popups/full_screen_loader.dart';
import 'package:races/utils/popups/loaders.dart';

//controller to manage user-related functionality
class UpdateUsernameControllerNurse extends GetxController {
  static UpdateUsernameControllerNurse get instance => Get.find();

  final username = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserUsernameFormKey = GlobalKey<FormState>();

  //init user data when Home Screen appears
  @override
  void onInit() {
    initializeUsernames();
    super.onInit();
  }

  //fetch user record
  Future<void> initializeUsernames() async {
    username.text = userController.user.value.username;
  }

  Future<void> updateUserUsername() async {
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
      if (!updateUserUsernameFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //update user's username in the Firebase Firestore
      Map<String, dynamic> userName = {'Username': username.text.trim()};
      await userRepository.updateSingleField(userName);

      //update the Rx User value
      userController.user.value.username = username.text.trim();

      //remove loader
      SFullScreenLoader.stopLoading();

      //show success message
      SLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your Username has been updated.');

      //move to previous screen
      Get.off(() => const NavigationMenuNurse());
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
