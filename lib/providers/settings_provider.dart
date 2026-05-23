import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

final localeProvider = StateProvider<Locale?>((ref) => null);

const supportedLocales = <Locale>[
  Locale('pt'),
  Locale('en'),
  Locale('es'),
];
