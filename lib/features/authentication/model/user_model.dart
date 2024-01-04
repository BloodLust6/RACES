//model class representing user data
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:races/utils/formatters/formatter.dart';

class UserModel {
  //keep those values final which you do not want to update
  final String id;
  String firstName;
  String lastName;
  String username;
  final String email;
  String phoneNumber;
  String profilePicture;
  String gender;
  String dob;
  String role;

  //constructor for UserModel
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.gender,
    required this.dob,
    required this.role,
  });

  //helper function to get the full name
  String get fullName => '$firstName $lastName';

  //helper function to format phone number
  String get formattedPhoneNo => SFormatter.formatPhoneNumber(phoneNumber);

  //static function tp split full name
  static List<String> nameParts(fullName) => fullName.split(" ");

  //static function to generate a username
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "races_$camelCaseUsername";
    return usernameWithPrefix;
  }

  //static function to create an empty user model
  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
        gender: '',
        dob: '',
        role: '',
      );

  //convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Gender': gender,
      'DateOfBirth': dob,
      'Role': role,
    };
  }

  //factory medthod to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
        gender: data['Gender'] ?? '',
        dob: data['DateOfBirth'] ?? '',
        role: data['Role'] ?? '',
      );
    }
    return UserModel.empty();
  }
}
