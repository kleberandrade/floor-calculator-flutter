import 'package:flutter/material.dart';
import 'core/theme_app.dart';
import 'pages/calculator_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Calculadora de pisos',
    theme: themeApp,
    home: const CalculatorPage(),
  );
}
