import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:races/data/repositories/authentication/authentication_repository.dart';
import 'package:races/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/helpers/network_manager.dart';
import 'package:races/utils/popups/full_screen_loader.dart';
import 'package:races/utils/popups/loaders.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  //variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  //send reset password email
  sendPasswordResetEmail() async {
    try {
      //startloading
      SFullScreenLoader.openLoadingDialog(
          'Processing your request...', SImages.docer);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      //remove loader
      SFullScreenLoader.stopLoading();

      //show success screen
      SLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link Sent to Reset your Password'.tr);

      //redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      //remove loader
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      //startloading
      SFullScreenLoader.openLoadingDialog(
          'Processing your request...', SImages.docer);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //send email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //remove loader
      SFullScreenLoader.stopLoading();

      //show success screen
      SLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link Sent to Reset your Password'.tr);

      //redirect
      Get.to(() => ResetPasswordScreen(email: email));
    } catch (e) {
      //remove loader
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
