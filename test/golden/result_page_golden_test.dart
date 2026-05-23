import 'package:alchemist/alchemist.dart';
import 'package:floor_calculator/core/theme_app.dart';
import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/models/floor_model.dart';
import 'package:floor_calculator/models/result_model.dart';
import 'package:floor_calculator/pages/result_page.dart';
import 'package:floor_calculator/providers/calculator_provider.dart';
import 'package:floor_calculator/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

ResultModel _fixtureResult() {
  final floor = FloorModel(
    widthCm: 60,
    lengthCm: 60,
    pricePerBox: 120,
    piecesPerBox: 5,
  );
  return ResultModel(
    rooms: [
      RoomResult(
        name: 'Sala',
        area: 7.728,
        piecesByWidth: 4,
        piecesByLength: 6,
      ),
      RoomResult(
        name: 'Quarto',
        area: 9.0,
        piecesByWidth: 5,
        piecesByLength: 5,
      ),
    ],
    floor: floor,
    wastagePercent: 10,
  );
}

Widget _wrapped({
  required Locale locale,
  required ThemeMode themeMode,
}) {
  final result = _fixtureResult();
  return ProviderScope(
    overrides: [
      localeProvider.overrideWith((ref) => locale),
      themeModeProvider.overrideWith((ref) => themeMode),
      lastResultProvider.overrideWith((ref) => result),
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
        home: const ResultPage(),
      ),
  );
}

void main() {
  goldenTest(
    'ResultPage - claro em três idiomas',
    fileName: 'result_page_light',
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
              minHeight: 900,
              maxHeight: 900,
            ),
            child: _wrapped(locale: loc, themeMode: ThemeMode.light),
          ),
      ],
    ),
  );

  goldenTest(
    'ResultPage - escuro em três idiomas',
    fileName: 'result_page_dark',
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
              minHeight: 900,
              maxHeight: 900,
            ),
            child: _wrapped(locale: loc, themeMode: ThemeMode.dark),
          ),
      ],
    ),
  );
}
