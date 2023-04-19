// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// Define your custom theme data
final customTheme = ThemeData(
  primaryColor: const Color.fromRGBO(255, 188, 2, 1),
  accentColor: const Color.fromARGB(97, 231, 170, 0),
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
    headline2: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    headline3: TextStyle(fontSize: 20, color: Colors.black),
    bodyText1: TextStyle(fontSize: 16, color: Colors.black),
    bodyText2: TextStyle(fontSize: 14, color: Colors.black),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: const Color.fromRGBO(255, 188, 2, 1),
      onPrimary: Colors.white,
      minimumSize: const Size(100, 36),
      textStyle: const TextStyle(
        fontSize: 16,
      ),
    ),
  ),
);

//final backgroundGradient =