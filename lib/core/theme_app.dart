import 'package:flutter/material.dart';

const _seed = Colors.deepOrange;

ThemeData _baseTheme(Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: brightness,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      isDense: true,
    ),
  );
}

final ThemeData lightTheme = _baseTheme(Brightness.light);
final ThemeData darkTheme = _baseTheme(Brightness.dark);
