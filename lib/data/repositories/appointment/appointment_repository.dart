import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:races/data/repositories/authentication/authentication_repository.dart';
import 'package:races/features/appointment/model/appointment_model.dart';
import 'package:races/utils/exceptions/firebase_exceptions.dart';
import 'package:races/utils/exceptions/format_exceptions.dart';
import 'package:races/utils/exceptions/platform_exceptions.dart';

class AppointmentRepository extends GetxController {
  static AppointmentRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //function to save appointment data to Firebase
  Future<void> saveAppointmentRecord(AppointmentModel appointment) async {
    try {
      final docAppointment = _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Appointments")
          .doc();
      appointment.id = docAppointment.id;
      final json = appointment.toJson();
      await docAppointment.set(json);
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to update a specific appointment record in Firebase
  Future<void> updateAppointmentRecord(String userId, appointmentId,
      Map<String, dynamic> detailsAppointment) async {
    try {
      final docReference = _db
          .collection("Users")
          .doc(userId)
          .collection("Appointments")
          .doc(appointmentId);

      final docSnapshot = await docReference.get();
      if (docSnapshot.exists) {
        await docReference.update(detailsAppointment);
      } else {
        throw 'Document with ID $appointmentId not found';
      }
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to delete appointment record from Firebase
  Future<void> deleteAppointmentRecord(String appointmentId) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Appointments")
          .doc(appointmentId)
          .delete();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to update a specific appointment report in AppointmentReports collection in Firebase
  Future<void> saveAppointmentReport(String userId, appointmentId) async {
    try {
      // Reference to the Appointment document in Appointments collection
      final appointmentReference = _db
          .collection("Users")
          .doc(userId)
          .collection("Appointments")
          .doc(appointmentId);

      // Get the Appointment document snapshot
      final appointmentSnapshot = await appointmentReference.get();

      // Check if the Appointment document exists
      if (appointmentSnapshot.exists) {
        // Get the data from the Appointment document
        Map<String, dynamic> appointmentData =
            appointmentSnapshot.data() as Map<String, dynamic>;

        // Reference to the AppointmentReports document
        final reportsReference = _db
            .collection("Users")
            .doc(userId)
            .collection("AppointmentReports")
            .doc(appointmentId);

        // Set the data in the AppointmentReports document
        await reportsReference.set(appointmentData);
      } else {
        throw 'Document with ID $appointmentId not found in Appointments collection';
      }
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Function to delete appointment record from Firebase
  Future<void> deleteAppointmentReport(String userId, appointmentId) async {
    try {
      await _db
          .collection("Users")
          .doc(userId)
          .collection("Appointments")
          .doc(appointmentId)
          .delete();
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
