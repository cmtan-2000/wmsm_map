import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String fullname;
  String username;
  String email;
  String phoneNumber;
  String dateOfBirth;
  String role;
  double? weight; //*in kg
  double? height; //*in cm
  String? gender; //* for bmi
  double? bmi; //* for bmi

  Users(
      {required this.fullname,
      required this.username,
      required this.email,
      required this.phoneNumber,
      required this.dateOfBirth,
      required this.role,
      this.weight,
      this.height,
      this.gender,
      this.bmi});

  Users.fromJson(Map<String, dynamic> json)
      : fullname = json['fullname'],
        username = json['username'],
        email = json['email'],
        phoneNumber = json['phoneNumber'],
        dateOfBirth = json['dateOfBirth'],
        role = json['role'];

  Map<String, dynamic> toJson() => {
        'fullname': fullname,
        'username': username,
        'email': email,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'role': role,
      };

  factory Users.fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Users(
      dateOfBirth: data['dateOfBirth'],
      email: data['email'],
      fullname: data['fullname'],
      phoneNumber: data['phoneNumber'],
      username: data['username'],
      role: data['role'],
    );
  }
}
