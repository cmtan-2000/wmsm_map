// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class MessageViewModel extends ChangeNotifier {
  String _value = '';
  String get value => _value;

  void update(String newValue) {
    _value = newValue;
    notifyListeners();
  }
}
