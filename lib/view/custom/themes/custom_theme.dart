// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// Define your custom theme data
final customTheme = ThemeData(
  primaryColor: Colors.green,
  accentColor: Colors.orange,
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16),
    bodyText2: TextStyle(fontSize: 14),
  ),
);
