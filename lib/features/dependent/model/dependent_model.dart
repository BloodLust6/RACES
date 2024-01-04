//model class representing dependent data
import 'package:cloud_firestore/cloud_firestore.dart';

class DependentModel {
  //keep those values final which you do not want to update
  String id;
  String name;
  String gender;
  String dob;
  String relation;

  //constructor for UserModel
  DependentModel({
    this.id = '',
    required this.name,
    required this.gender,
    required this.dob,
    required this.relation,
  });

  //static function to create an empty dependent model
  static DependentModel empty() => DependentModel(
        id: '',
        name: '',
        gender: '',
        dob: '',
        relation: '',
      );

  //convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Gender': gender,
      'DateOfBirth': dob,
      'Relation': relation,
    };
  }

  //factory medthod to create an InformationModel from a Firebase document snapshot
  factory DependentModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return DependentModel(
        id: document.id,
        name: data['Name'] ?? '',
        gender: data['Gender'] ?? '',
        dob: data['DateOfBirth'] ?? '',
        relation: data['Relation'] ?? '',
      );
    }
    return DependentModel.empty();
  }
}
