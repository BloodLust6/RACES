import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:races/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:races/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:races/features/appointment/controllers/appointment_controller.dart';
import 'package:races/features/clinic/screens/home/widgets/action_slider.dart';
import 'package:races/features/clinic/screens/home/widgets/home_appbar.dart';
import 'package:races/features/clinic/screens/home/widgets/home_card.dart';
import 'package:races/features/clinic/screens/home/widgets/others_slider.dart';
import 'package:races/features/medication/controllers/medication_controller.dart';
import 'package:races/routes/routes.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/constants/sizes.dart';

class HomeScreenDoctor extends StatelessWidget {
  const HomeScreenDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AppointmentController());
    Get.put(MedicationController());
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //header
            SPrimaryHeaderContainer(
              child: Column(
                children: [
                  //appbar
                  SHomeAppBar(),
                  SizedBox(height: SSizes.spaceBtwSections),

                  //search bar
                  SSearchContainer(
                    text: 'Search',
                  ),
                  SizedBox(height: SSizes.spaceBtwItems),

                  //card
                  SHomeCard(),
                ],
              ),
            ),

            //body
            Padding(
              padding: EdgeInsets.all(SSizes.defaultSpace),
              child: Column(
                children: [
                  //action slider
                  SActionSlider(
                    banners: [
                      SImages.appointments,
                      SImages.medications,
                    ],
                    pages: [
                      SRoutes.appntmntdoctor,
                      SRoutes.medicdoctor,
                    ],
                  ),
                  SizedBox(height: SSizes.spaceBtwItems),

                  SOthersSlider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
