import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:races/common/widgets/appbar/appbar.dart';
import 'package:races/common/widgets/notification/notification_icon.dart';
import 'package:races/features/personalization/controllers/user_controller.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/constants/shimmer.dart';
import 'package:races/utils/constants/text_strings.dart';

class SHomeAppBar extends StatelessWidget {
  const SHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return SAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            STexts.homeAppbarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: SColors.softGrey),
          ),
          Obx(() {
            if (userController.profileLoading.value) {
              //display a shimer loading while user profile is being loaded
              return const SShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                userController.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: SColors.white),
              );
            }
          }),
        ],
      ),
      actions: [
        SNotficationIcon(
          onPressed: () {},
          iconColor: SColors.white,
        )
      ],
    );
  }
}
