//model class representing information data
import 'package:cloud_firestore/cloud_firestore.dart';

class InformationModel {
  //keep those values final which you do not want to update
  String id;
  String informant;
  String title;
  String detail;
  String link;

  //constructor for InformationModel
  InformationModel({
    this.id = '',
    required this.informant,
    required this.title,
    required this.detail,
    required this.link,
  });

  //static function to create an empty information model
  static InformationModel empty() => InformationModel(
        id: '',
        informant: '',
        title: '',
        detail: '',
        link: '',
      );

  //convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Informant': informant,
      'Title': title,
      'Detail': detail,
      'Link': link,
    };
  }

  //factory medthod to create an InformationModel from a Firebase document snapshot
  factory InformationModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return InformationModel(
        id: document.id,
        informant: data['Informant'] ?? '',
        title: data['Title'] ?? '',
        detail: data['Detail'] ?? '',
        link: data['Link'] ?? '',
      );
    }
    return InformationModel.empty();
  }
}
