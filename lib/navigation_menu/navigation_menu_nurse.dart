import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:races/features/appointment/screens/appointment_report/appointment_report.dart';
import 'package:races/features/clinic/screens/home_nurse/home_nurse.dart';
import 'package:races/features/medication/screens/medication_report/medication_report.dart';
import 'package:races/features/personalization/screens/profile_nurse/profile_nurse.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/helpers/helper_functions.dart';

class NavigationMenuNurse extends StatelessWidget {
  const NavigationMenuNurse({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationControllerNurse());
    final darkMode = SHelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? SColors.black : SColors.white,
          indicatorColor: darkMode
              ? SColors.white.withOpacity(0.1)
              : SColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Iconsax.calendar), label: 'Appointments'),
            NavigationDestination(
                icon: Icon(Icons.medication), label: 'Medications'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationControllerNurse extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreenNurse(),
    const AppointmentRecordScreen(),
    const MedicationReportScreen(),
    const ProfileScreenNurse(),
  ];
}
