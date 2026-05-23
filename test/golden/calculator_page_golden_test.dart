import 'package:alchemist/alchemist.dart';
import 'package:floor_calculator/core/theme_app.dart';
import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/pages/calculators/floor_calculator_page.dart';
import 'package:floor_calculator/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget _wrapped({
  required Widget child,
  required Locale locale,
  required ThemeMode themeMode,
}) {
  return ProviderScope(
    overrides: [
      localeProvider.overrideWith((ref) => locale),
      themeModeProvider.overrideWith((ref) => themeMode),
    ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        locale: locale,
        supportedLocales: supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: child,
      ),
  );
}

void main() {
  goldenTest(
    'CalculatorPage - claro em três idiomas',
    fileName: 'calculator_page_light',
    constraints: const BoxConstraints(maxWidth: 1200),
    builder: () => GoldenTestGroup(
      columns: 3,
      children: [
        for (final loc in const [Locale('pt'), Locale('en'), Locale('es')])
          GoldenTestScenario(
            name: loc.languageCode,
            constraints: const BoxConstraints(
              minWidth: 360,
              maxWidth: 360,
              minHeight: 720,
              maxHeight: 720,
            ),
            child: _wrapped(
              child: const FloorCalculatorPage(),
              locale: loc,
              themeMode: ThemeMode.light,
            ),
          ),
      ],
    ),
  );

  goldenTest(
    'CalculatorPage - escuro em três idiomas',
    fileName: 'calculator_page_dark',
    constraints: const BoxConstraints(maxWidth: 1200),
    builder: () => GoldenTestGroup(
      columns: 3,
      children: [
        for (final loc in const [Locale('pt'), Locale('en'), Locale('es')])
          GoldenTestScenario(
            name: loc.languageCode,
            constraints: const BoxConstraints(
              minWidth: 360,
              maxWidth: 360,
              minHeight: 720,
              maxHeight: 720,
            ),
            child: _wrapped(
              child: const FloorCalculatorPage(),
              locale: loc,
              themeMode: ThemeMode.dark,
            ),
          ),
      ],
    ),
  );
}
