import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:races/data/repositories/appointment/appointment_repository.dart';
import 'package:races/data/repositories/authentication/authentication_repository.dart';
import 'package:races/features/appointment/model/appointment_model.dart';
import 'package:races/routes/routes.dart';
import 'package:races/utils/constants/image_strings.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/helpers/network_manager.dart';
import 'package:races/utils/popups/full_screen_loader.dart';
import 'package:races/utils/popups/loaders.dart';

class AppointmentController extends GetxController {
  static AppointmentController get instance => Get.find();

  // Variables
  Rx<AppointmentModel> appointment = AppointmentModel.empty().obs;
  final name = TextEditingController();
  final roa = TextEditingController();
  final time = TextEditingController();
  final date = TextEditingController();
  final slot = TextEditingController();
  final appointmentRepository = Get.put(AppointmentRepository());
  GlobalKey<FormState> appointmentFormKey = GlobalKey<FormState>();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  DateTime? selectedDate;
  List<String> availableTimeSlots = [];
  @override
  void onInit() {
    super.onInit();
    // Initialize the appointment observable
    appointment.value = AppointmentModel.empty();
  }

  void createAppointment() async {
    try {
      // Start loading
      SFullScreenLoader.openLoadingDialog(
          'We are creating your appointment...', SImages.docer);
      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove loader
        SFullScreenLoader.stopLoading();
        return;
      }
      // Form validation
      if (!formKey.currentState!.validate()) {
        // Remove loader
        SFullScreenLoader.stopLoading();
        return;
      }
      // Save authenticated user data
      final now = DateTime.now();
      final formattedTime = DateFormat('HH:mm, dd MMM yyyy').format(now);
      final newAppointment = AppointmentModel(
        uid: AuthenticationRepository.instance.authUser!.uid,
        name: name.text.trim(),
        roa: roa.text.trim(),
        time: formattedTime,
        date: date.text.trim(),
        slot: slot.text.trim(),
      );

      // Update the appointment observable
      appointment.value = newAppointment;

      final appointmentRepository = Get.put(AppointmentRepository());
      await appointmentRepository.saveAppointmentRecord(newAppointment);

      // Remove loader
      SFullScreenLoader.stopLoading();

      // Show success message
      SLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your appointment has been created!');

      // Move to appointment screen
      Get.toNamed(SRoutes.navmenu);
    } catch (e) {
      // Remove loader
      SFullScreenLoader.stopLoading();

      // Show some Generic Error to the user
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e);
    }
  }

  Future<List<String>> fetchAvailableTimeSlots(DateTime? selectedDate) async {
    if (selectedDate == null || selectedDate.isBefore(DateTime.now())) {
      return [];
    }

    // Fetch existing appointments for the selected date and the authenticated user
    final existingAppointments = await FirebaseFirestore.instance
        .collection('appointments')
        .where('date', isEqualTo: DateFormat('yyyy-MM-dd').format(selectedDate))
        .where('uid',
            isEqualTo: AuthenticationRepository.instance.authUser?.uid)
        .get();

    // Extract booked slots for the selected date
    final bookedSlots = existingAppointments.docs
        .map((doc) => DateFormat('hh:mm a').format(doc['slot'].toDate()))
        .toList();

    print('Booked Slots for ${selectedDate.toString()}: $bookedSlots');

    // Generate all available slots for the day
    final allAvailableSlots = generateAvailableSlots(selectedDate, bookedSlots);

    return allAvailableSlots;
  }

  List<String> generateAvailableSlots(
      DateTime selectedDate, List<String> bookedSlots) {
    final List<String> allSlots = generateAllSlots(selectedDate);

    // Exclude booked slots for the selected date
    final availableTimeSlots =
        allSlots.where((slot) => !bookedSlots.contains(slot)).toList();

    return availableTimeSlots;
  }

  List<String> generateAllSlots(DateTime selectedDate) {
    final List<String> slots = [];
    final DateTime today = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    // Set the opening and closing time for appointments
    final DateTime openingTime = today.add(const Duration(hours: 9));
    final DateTime closingTime = today.add(const Duration(hours: 20));

    // Add slots from opening time to closing time
    DateTime currentSlot = openingTime;
    while (currentSlot.isBefore(closingTime)) {
      // Exclude lunch break slot from 1 pm to 2 pm
      if (!(currentSlot.hour == 13 && currentSlot.minute == 0) &&
          !(currentSlot.hour == 13 && currentSlot.minute == 30)) {
        slots.add(DateFormat('hh:mm a').format(currentSlot));
      }

      currentSlot = currentSlot.add(const Duration(minutes: 30));
    }

    return slots;
  }

  //delete appointment warning
  void deleteAppointmentWarningPopup(String appointmentId) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(SSizes.md),
      title: 'Cancel Appointment',
      middleText: 'Are you sure you want to cancel this appointment?',
      confirm: ElevatedButton(
        onPressed: () async {
          // Call the deleteAppointment method with the appointmentId
          deleteAppointment(appointmentId);

          // Close the dialog
          Navigator.of(Get.overlayContext!).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: SSizes.lg),
          child: Text('Cancel'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text('Back'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  //delete appointment
  void deleteAppointment(String appointmentId) async {
    try {
      SFullScreenLoader.openLoadingDialog('Processing', SImages.docer);

      // Call the deleteAppointmentRecord method from the repository
      await appointmentRepository.deleteAppointmentRecord(appointmentId);

      // Remove loader
      SFullScreenLoader.stopLoading();

      // Show success message
      SLoaders.successSnackBar(
          title: 'Success',
          message: 'Appointment has been cancel successfully!');
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //delete appointment warning
  void recordWarningPopup({
    required String uid,
    required String id,
    required AppointmentModel appointment,
  }) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(SSizes.md),
      title: 'Appointment Report',
      middleText: 'Are you sure you want to update this detail?',
      confirm: ElevatedButton(
        onPressed: () async {
          // Call the create report method with the appointmentId
          createReport(uid, id, appointment);

          // Close the dialog
          Navigator.of(Get.overlayContext!).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          side: const BorderSide(color: Colors.teal),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: SSizes.lg),
          child: Text('Submit'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text('Back'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }

  //create report
  void createReport(
    String uid,
    String id,
    AppointmentModel appointment,
  ) async {
    try {
      // Start loading
      SFullScreenLoader.openLoadingDialog(
          'We are creating appointment report...', SImages.docer);
      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Remove loader
        SFullScreenLoader.stopLoading();
        return;
      }
      final appointmentRepository = Get.put(AppointmentRepository());
      await appointmentRepository.saveAppointmentReport(uid, id);
      await appointmentRepository.deleteAppointmentReport(uid, id);
      // Remove loader
      SFullScreenLoader.stopLoading();
      // Show success message
      SLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your report has been created!');
      // Move to appointment screen
      Get.toNamed(SRoutes.navnurse);
    } catch (e) {
      // Remove loader
      SFullScreenLoader.stopLoading();
      // Show some Generic Error to the user
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      print(e);
    }
  }
}
