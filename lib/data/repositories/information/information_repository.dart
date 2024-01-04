import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:races/features/information/model/information_model.dart';
import 'package:races/utils/exceptions/firebase_exceptions.dart';
import 'package:races/utils/exceptions/format_exceptions.dart';
import 'package:races/utils/exceptions/platform_exceptions.dart';

class InformationRepository extends GetxController {
  static InformationRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //function to save information data to Firebase
  Future<void> saveInformationRecord(InformationModel information) async {
    try {
      final docInformation = _db.collection("Informations").doc();
      information.id = docInformation.id;
      final json = information.toJson();
      await docInformation.set(json);
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

  // Function to update information record in Firebase
  Future<void> updateInformationRecord(
      String informationId, Map<String, dynamic> detailsInformation) async {
    try {
      final docReference = _db.collection("Informations").doc(informationId);
      await docReference.update(detailsInformation);
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

  // Function to delete information record from Firebase
  Future<void> deleteInformationRecord(String informationId) async {
    try {
      await _db.collection("Informations").doc(informationId).delete();
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
