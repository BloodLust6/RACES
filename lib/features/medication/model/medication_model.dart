//model class representing medication data
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicationModel {
  //keep those values final which you do not want to update
  String uid;
  String id;
  String name;
  String rom;
  String note;
  String status;
  String message;
  String time;

  //constructor for UserModel
  MedicationModel({
    this.uid = '',
    this.id = '',
    required this.name,
    required this.rom,
    required this.note,
    required this.status,
    required this.message,
    required this.time,
  });

  //static function to create an empty dependent model
  static MedicationModel empty() => MedicationModel(
        uid: '',
        id: '',
        name: '',
        rom: '',
        note: '',
        status: '',
        message: '',
        time: '',
      );

  //convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'UserId': uid,
      'Id': id,
      'Name': name,
      'ReasonOfMedication': rom,
      'Note': note,
      'Status': status,
      'Message': message,
      'AppliedTime': time,
    };
  }

  //factory medthod to create an InformationModel from a Firebase document snapshot
  factory MedicationModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return MedicationModel(
        uid: data['UserId'] ?? '',
        id: document.id,
        name: data['Name'] ?? '',
        rom: data['ReasonOfMedication'] ?? '',
        note: data['Note'] ?? '',
        status: data['Status'] ?? '',
        message: data['Message'] ?? '',
        time: data['AppliedTime'] ?? '',
      );
    }
    return MedicationModel.empty();
  }
}
