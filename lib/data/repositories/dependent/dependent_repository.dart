import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:races/data/repositories/authentication/authentication_repository.dart';
import 'package:races/features/dependent/model/dependent_model.dart';
import 'package:races/features/personalization/controllers/user_controller.dart';
import 'package:races/utils/exceptions/firebase_exceptions.dart';
import 'package:races/utils/exceptions/format_exceptions.dart';
import 'package:races/utils/exceptions/platform_exceptions.dart';

class DependentRepository extends GetxController {
  static DependentRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //function to save dependent data to Firebase
  Future<void> saveDependentRecord(DependentModel dependent) async {
    try {
      final docDependent = _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Dependents")
          .doc();
      dependent.id = docDependent.id;
      final json = dependent.toJson();
      await docDependent.set(json);
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

  // Function to update dependent record in Firebase
  Future<void> updateDependentRecord(
      String dependentId, Map<String, dynamic> detailsDependent) async {
    try {
      final docReference = _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Dependents")
          .doc(dependentId);
      await docReference.update(detailsDependent);
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

  // Function to delete dependent record from Firebase
  Future<void> deleteDependentRecord(String dependentId) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .collection("Dependents")
          .doc(dependentId)
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

  // Function to fetch user and dependent names
  Future<List<String>> getUserAndDependentNames() async {
    try {
      final userDoc = _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid);
      final userSnap = await userDoc.get();
      if (userSnap.exists) {
        final userName = UserController.instance.user.value.fullName;
        final dependentsSnap = await userDoc.collection("Dependents").get();
        final dependentNames = dependentsSnap.docs
            .map((doc) => DependentModel.fromSnapshot(doc).name)
            .toList();
        // Adding user's name to the list of dependent names
        dependentNames.add(userName);
        return dependentNames;
      }
      return [];
    } catch (e) {
      print('Error fetching user and dependent names: $e');
      return [];
    }
  }
}
