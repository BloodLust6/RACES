import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:races/data/repositories/authentication/authentication_repository.dart';
import 'package:races/features/personalization/controllers/user_controller.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/popups/full_screen_loader.dart';
import 'package:races/utils/popups/loaders.dart';

import '../../../../utils/helpers/network_manager.dart';

class LoginController extends GetxController {
  //variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    final rememberedEmail = localStorage.read('REMEMBER_ME_EMAIL');
    final rememberedPassword = localStorage.read('REMEMBER_ME_PASSWORD');
    if (rememberedEmail != null) {
      email.text = rememberedEmail;
    }
    if (rememberedPassword != null) {
      password.text = rememberedPassword;
    }
    super.onInit();
  }

  //email and password signin
  Future<void> emailAndPasswordSignIn() async {
    try {
      //start loading
      SFullScreenLoader.openLoadingDialog('Logging you in...', SImages.docer);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //remove loader
        SFullScreenLoader.stopLoading();
        return;
      }

      //form validation
      if (!loginFormKey.currentState!.validate()) {
        //remove loader
        SFullScreenLoader.stopLoading();
        return;
      }

      //save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim);
      }

      //login user using email & password authentication
      AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //remove loader
      SFullScreenLoader.stopLoading();

      //redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  //google sigin authentication
  Future<void> googleSignIn() async {
    try {
      SFullScreenLoader.openLoadingDialog('Logging you in...', SImages.docer);

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //google authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      //save user record
      await userController.saveUserRecord(userCredentials);

      //remove loader
      SFullScreenLoader.stopLoading();
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
