import 'package:floor_calculator/core/theme_app.dart';
import 'package:floor_calculator/pages/calculator_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Pisos',
      theme: themeApp,
      home: CalculatorPage(),
    );
  }
}
