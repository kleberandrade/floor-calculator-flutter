import 'package:flutter/material.dart';

final themeApp = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
  primarySwatch: Colors.deepOrange,
  accentColor: Colors.deepOrangeAccent,
  buttonTheme: ButtonThemeData(
    height: 52,
    textTheme: ButtonTextTheme.primary,
  ),
);
