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
class UpdatePhoneNumberControllerDoctor extends GetxController {
  static UpdatePhoneNumberControllerDoctor get instance => Get.find();

  final phoneNumber = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserPhoneNumberFormKey = GlobalKey<FormState>();

  //init user data when Home Screen appears
  @override
  void onInit() {
    initializePhoneNumber();
    super.onInit();
  }

  //fetch user record
  Future<void> initializePhoneNumber() async {
    phoneNumber.text = userController.user.value.phoneNumber;
  }

  Future<void> updateUserPhoneNumber() async {
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
      if (!updateUserPhoneNumberFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //update user's phone number in the Firebase Firestore
      Map<String, dynamic> phonenumber = {
        'PhoneNumber': phoneNumber.text.trim()
      };
      await userRepository.updateSingleField(phonenumber);

      //update the Rx User value
      userController.user.value.phoneNumber = phoneNumber.text.trim();

      //remove loader
      SFullScreenLoader.stopLoading();

      //show success message
      SLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your Phone Number has been updated.');

      //move to previous screen
      Get.off(() => const NavigationMenuDoctor());
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
