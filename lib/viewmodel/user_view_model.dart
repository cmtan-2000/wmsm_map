import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../model/users.dart';

class UserViewModel with ChangeNotifier {
  late Users _user;
  Users get user => _user;
  int _goal = 0;
  int get goal => _goal;

  // String get fullname => _user.fullname;
  // String get username => _user.username;
  // String get email => _user.email;
  // String get phoneNumber => _user.phoneNumber;
  // String get dateOfBirth => _user.dateOfBirth;
  // double? get weight => _user.weight;
  // double? get height => _user.height;
  // String? get gender => _user.gender;
  // double? get bmi => _user.bmi;

  void setUser() {
    _user = Users(
      fullname: '',
      username: '',
      email: '',
      phoneNumber: '',
      dateOfBirth: '',
      weight: "0.0",
      height: "0.0",
      gender: '',
      bmi: "0.0",
      role: '',
    );

    String userid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .get()
        .then((user) {
      _user = Users(
        fullname: user['fullname'],
        username: user['username'],
        email: user['email'],
        phoneNumber: user['phoneNumber'],
        dateOfBirth: user['dateOfBirth'],
        weight: user['weight'],
        height: user['height'],
        gender: user['gender'],
        goal: user['goal'],
        bmi: user['bmi'],
        role: user['role'],
      );
      _goal = int.parse(user['goal']);
      notifyListeners();
    });
  }

  // Future<void> updateGoal() async {
  //   String userId = FirebaseAuth.instance.currentUser!.uid;

  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userId)
  //       .get()
  //       .then((snapshot) {
  //     if (snapshot.exists) {
  //       _goal = int.parse(snapshot.data()?['goal'] ?? '0');
  //       Logger().d("$_goal");
  //       notifyListeners();
  //     }
  //   });

  // }

  
 
}
