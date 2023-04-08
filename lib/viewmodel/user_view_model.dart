import 'package:flutter/material.dart';

import '../model/user.dart';

class UserViewModel with ChangeNotifier {
  late User _user;

  UserViewModel() {
    _user = User(name: '', age: 0);
  }

  String get name => _user.name;
  int get age => _user.age;

  void setUser(String name, int age) {
    _user = User(name: name, age: age);
    notifyListeners();
  }
}
