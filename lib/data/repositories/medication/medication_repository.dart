import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:races/data/repositories/authentication/authentication_repository.dart';
import 'package:races/features/medication/model/medication_model.dart';
import 'package:races/utils/exceptions/firebase_exceptions.dart';
import 'package:races/utils/exceptions/format_exceptions.dart';
import 'package:races/utils/exceptions/platform_exceptions.dart';

class MedicationRepository extends GetxController {
  static MedicationRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //function to save medication data to Firebase
  Future<void> saveMedicationRecord(MedicationModel medication) async {
    try {
      final docMedication = _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Medications")
          .doc();
      medication.id = docMedication.id;
      final json = medication.toJson();
      await docMedication.set(json);
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

  // Function to update a specific medication record in Firebase
  Future<void> updateMedicationRecord(String userId, medicationId,
      Map<String, dynamic> detailsMedication) async {
    try {
      final docReference = _db
          .collection("Users")
          .doc(userId)
          .collection("Medications")
          .doc(medicationId);

      final docSnapshot = await docReference.get();
      if (docSnapshot.exists) {
        await docReference.update(detailsMedication);
      } else {
        throw 'Document with ID $medicationId not found';
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

  // Function to delete medication record from Firebase
  Future<void> deleteMedicationRecord(String medicationId) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Medications")
          .doc(medicationId)
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

  // Function to update a specific medication report in MedicationReports collection in Firebase
  Future<void> saveMedicationReport(String userId, medicationId) async {
    try {
      // Reference to the Medication document in Medications collection
      final medicationReference = _db
          .collection("Users")
          .doc(userId)
          .collection("Medications")
          .doc(medicationId);

      // Get the Medication document snapshot
      final medicationSnapshot = await medicationReference.get();

      // Check if the Medication document exists
      if (medicationSnapshot.exists) {
        // Get the data from the Medication document
        Map<String, dynamic> medicationData =
            medicationSnapshot.data() as Map<String, dynamic>;

        // Reference to the MedicationReports document
        final reportsReference = _db
            .collection("Users")
            .doc(userId)
            .collection("MedicationReports")
            .doc(medicationId);

        // Set the data in the MedicationReports document
        await reportsReference.set(medicationData);
      } else {
        throw 'Document with ID $medicationId not found in Medications collection';
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

  // Function to delete medication record from Firebase
  Future<void> deleteMedicationReport(String userId, medicationId) async {
    try {
      await _db
          .collection("Users")
          .doc(userId)
          .collection("Medications")
          .doc(medicationId)
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
