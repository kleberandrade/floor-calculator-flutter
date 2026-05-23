// Imprime as cores derivadas do ColorScheme.fromSeed para alinhar
// flutter_native_splash, AndroidManifest e logo com o tema do app.
//
// Rodar: flutter test tool/print_theme_colors.dart

import 'package:floor_calculator/core/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

String _hex(Color c) {
  String two(double v) => (v * 255).round().toRadixString(16).padLeft(2, '0').toUpperCase();
  return '#${two(c.r)}${two(c.g)}${two(c.b)}';
}

void main() {
  test('print derived theme colors', () {
    void printScheme(String name, ColorScheme s) {
      // ignore: avoid_print
      print('\n== $name ==');
      // ignore: avoid_print
      print('primary           ${_hex(s.primary)}');
      // ignore: avoid_print
      print('onPrimary         ${_hex(s.onPrimary)}');
      // ignore: avoid_print
      print('primaryContainer  ${_hex(s.primaryContainer)}');
      // ignore: avoid_print
      print('onPrimaryContainer${_hex(s.onPrimaryContainer)}');
      // ignore: avoid_print
      print('surface           ${_hex(s.surface)}');
      // ignore: avoid_print
      print('onSurface         ${_hex(s.onSurface)}');
    }

    printScheme('LIGHT', lightTheme.colorScheme);
    printScheme('DARK', darkTheme.colorScheme);
  });
}
