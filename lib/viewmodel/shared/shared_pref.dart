import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.decode(prefs.getString(key)!);
    Map<String, dynamic> map = data;
    return map;
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    //save the string value with a given key
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}