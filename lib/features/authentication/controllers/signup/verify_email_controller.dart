import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:races/common/widgets/success_screen/success_screen.dart';
import 'package:races/data/repositories/authentication/authentication_repository.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/constants/text_strings.dart';
import 'package:races/utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  //send email whenever verify screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  //send email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      SLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Please Check your inbox and verify email.');
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //timer to automatically redirect on email verification
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
            () => SuccessScreen(
              image: SImages.success,
              title: STexts.yourAccountCreatedTitle,
              subTitle: STexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
            ),
          );
        }
      },
    );
  }

  //manually check if email verification
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(
        () => SuccessScreen(
          image: SImages.staticSuccessIllustration,
          title: STexts.yourAccountCreatedTitle,
          subTitle: STexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }
}
