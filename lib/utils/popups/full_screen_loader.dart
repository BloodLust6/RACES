import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:races/common/widgets/loaders/animation_loader.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/helpers/helper_functions.dart';

class SFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => Dialog(
        child: Container(
          color: SHelperFunctions.isDarkMode(Get.context!)
              ? SColors.dark
              : SColors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 250),
                SAnimationLoaderWidget(text: text, animation: animation),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //stop the currently open dialog
  //this method doesn't return anything
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
