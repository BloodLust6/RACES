//model class representing medication data
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  //keep those values final which you do not want to update
  String uid;
  String id;
  String name;
  String roa;
  String time;
  String date;
  String slot;

  //constructor for UserModel
  AppointmentModel({
    this.uid = '',
    this.id = '',
    required this.name,
    required this.roa,
    required this.time,
    required this.date,
    required this.slot,
  });

  //static function to create an empty dependent model
  static AppointmentModel empty() => AppointmentModel(
        uid: '',
        id: '',
        name: '',
        roa: '',
        time: '',
        date: '',
        slot: '',
      );

  //convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'UserId': uid,
      'Id': id,
      'Name': name,
      'ReasonOfAppointment': roa,
      'AppliedTime': time,
      'Date': date,
      'Slot': slot,
    };
  }

  //factory medthod to create an InformationModel from a Firebase document snapshot
  factory AppointmentModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return AppointmentModel(
        uid: data['UserId'] ?? '',
        id: document.id,
        name: data['Name'] ?? '',
        roa: data['ReasonOfAppointment'] ?? '',
        time: data['AppliedTime'] ?? '',
        date: data['Date'] ?? '',
        slot: data['Slot'] ?? '',
      );
    }
    return AppointmentModel.empty();
  }
}
