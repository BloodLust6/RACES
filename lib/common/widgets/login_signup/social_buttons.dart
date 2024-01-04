import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:races/features/authentication/controllers/login/login_controller.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/constants/sizes.dart';

class SSocialButtons extends StatelessWidget {
  const SSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: SColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
            icon: const Image(
              width: SSizes.iconMd,
              height: SSizes.iconMd,
              image: AssetImage(SImages.google),
            ),
          ),
        )
      ],
    );
  }
}
