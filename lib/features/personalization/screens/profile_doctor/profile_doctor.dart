import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/common/widgets/appbar/appbar.dart';
import 'package:races/data/repositories/authentication/authentication_repository.dart';
import 'package:races/features/personalization/controllers/user_controller.dart';
import 'package:races/features/personalization/screens/profile/widgets/circular_image.dart';
import 'package:races/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:races/features/personalization/screens/profile/widgets/section_heading.dart';
import 'package:races/routes/routes.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/constants/shimmer.dart';
import 'package:races/utils/constants/sizes.dart';

class ProfileScreenDoctor extends StatelessWidget {
  const ProfileScreenDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            children: [
              SAppBar(
                title: Text(
                  'Profile',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: SColors.white),
                ),
              ),
              //profile pic
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : SImages.classicLogo;
                        return controller.imageUploading.value
                            ? const SShimmerEffect(
                                width: 80, height: 80, radius: 80)
                            : SCircularImage(
                                image: image,
                                width: 80,
                                height: 80,
                                isNetworkImage: networkImage.isNotEmpty,
                              );
                      },
                    ),
                    TextButton(
                      onPressed: () => controller.uploadUserProfilePicture(),
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),

              //details
              const SizedBox(height: SSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: SSizes.spaceBtwItems),

              //heading profile info
              const SSectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              const SizedBox(height: SSizes.spaceBtwItems),

              SProfileMenu(
                title: 'Name',
                value: controller.user.value.fullName,
                onPressed: () => Get.toNamed(SRoutes.chgnameD),
              ),
              SProfileMenu(
                title: 'Username',
                value: controller.user.value.username,
                onPressed: () => Get.toNamed(SRoutes.chgusernameD),
              ),

              const SizedBox(height: SSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: SSizes.spaceBtwItems),

              //heading profile info
              const SSectionHeading(
                title: 'Personal Information',
                showActionButton: false,
              ),
              const SizedBox(height: SSizes.spaceBtwItems),

              SProfileMenu(
                title: 'User ID',
                value: controller.user.value.id,
                icon: Iconsax.copy,
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: controller.user.value.id),
                  );
                },
              ),
              SProfileMenu(
                title: 'E-mail',
                value: controller.user.value.email,
                icon: Iconsax.slash,
                onPressed: () {},
              ),
              SProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
                onPressed: () => Get.toNamed(SRoutes.chgphonenoD),
              ),
              SProfileMenu(
                title: 'Gender',
                value: controller.user.value.gender,
                onPressed: () => Get.toNamed(SRoutes.chggenderD),
              ),
              SProfileMenu(
                title: 'Date of Birth',
                value: controller.user.value.dob,
                onPressed: () => Get.toNamed(SRoutes.chgdobD),
              ),
              const Divider(),
              const SizedBox(height: SSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => AuthenticationRepository.instance.logout(),
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ),
              const SizedBox(height: SSizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
