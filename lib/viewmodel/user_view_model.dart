import 'package:flutter/material.dart';

import '../model/users.dart';

class UserViewModel with ChangeNotifier {
  late Users _user;

  UserViewModel() {
    _user = Users(
      fullname: '',
      username: '',
      email: '',
      phoneNumber: '',
      dateOfBirth: '',
      weight: 0.0,
      height: 0.0,
      gender: '',
      bmi: 0.0,
      role: '',
    );
  }

  String get fullname => _user.fullname;
  String get username => _user.username;
  String get email => _user.email;
  String get phoneNumber => _user.phoneNumber;
  String get dateOfBirth => _user.dateOfBirth;
  double? get weight => _user.weight;
  double? get height => _user.height;
  String? get gender => _user.gender;
  double? get bmi => _user.bmi;

  void setUser(
      String fullname,
      String username,
      String email,
      String phoneNumber,
      String dateOfBirth,
      double? weight,
      double? height,
      String? gender,
      double? bmi) {
    _user = Users(
      fullname: fullname,
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      dateOfBirth: dateOfBirth,
      weight: weight!,
      height: height!,
      gender: gender!,
      bmi: bmi!,
      role: '',
    );
    notifyListeners();
  }
}
