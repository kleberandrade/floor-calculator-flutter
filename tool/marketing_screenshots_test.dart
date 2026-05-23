// Gerador de screenshots de marketing.
//
// Renderiza CalculatorPage e ResultPage nas dimensões exatas exigidas pelo
// Google Play e App Store (e também 7" tablet e iPad Pro 12.9") e salva os
// PNGs em store_screenshots/<plataforma>/<tela>_<idioma>.png.
//
// Rodar com:
//   flutter test tool/marketing_screenshots_test.dart --tags marketing
//
// Regerar todos os tamanhos de uma vez. Não roda em `flutter test` sem tag
// porque marca os testes com a tag "marketing".

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:floor_calculator/controllers/calculator_controller.dart';
import 'package:floor_calculator/core/theme_app.dart';
import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/models/floor_model.dart';
import 'package:floor_calculator/models/result_model.dart';
import 'package:floor_calculator/pages/calculators/floor_calculator_page.dart';
import 'package:floor_calculator/pages/result_page.dart';
import 'package:floor_calculator/providers/calculator_provider.dart';
import 'package:floor_calculator/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _sizes = <String, Size>{
  // Google Play — telefone (portrait)
  'google_play_phone': Size(1080, 1920),
  // Google Play — tablet 7" (landscape)
  'google_play_7inch': Size(1920, 1080),
  // App Store — iPhone 6.7" (14/15 Pro Max)
  'apple_iphone_6_7': Size(1290, 2796),
  // App Store — iPad Pro 12.9" (3ª gen+)
  'apple_ipad_pro_12_9': Size(2048, 2732),
};

const _languages = <String>['pt', 'en', 'es'];

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
        area: 12.0,
        piecesByWidth: 5,
        piecesByLength: 7,
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

CalculatorController _preFilledController() {
  final c = CalculatorController(defaultRoomName: (i) => 'Sala $i');
  c.setFloorWidth('60');
  c.setFloorLength('60');
  c.setFloorPrice('120');
  c.setFloorPiecesPerBox('5');
  c.setRoomWidth(0, '3');
  c.setRoomLength(0, '4');
  return c;
}

void main() {
  for (final entry in _sizes.entries) {
    final platform = entry.key;
    final size = entry.value;
    for (final lang in _languages) {
      testWidgets(
        '$platform CalculatorPage $lang',
        (tester) async {
          await _captureCalculator(
            tester,
            size: size,
            locale: Locale(lang),
            outputPath: 'store_screenshots/$platform/calculator_$lang.png',
          );
        },
        tags: ['marketing'],
      );

      testWidgets(
        '$platform ResultPage $lang',
        (tester) async {
          await _captureResult(
            tester,
            size: size,
            locale: Locale(lang),
            outputPath: 'store_screenshots/$platform/result_$lang.png',
          );
        },
        tags: ['marketing'],
      );
    }
  }
}

Future<void> _captureCalculator(
  WidgetTester tester, {
  required Size size,
  required Locale locale,
  required String outputPath,
}) async {
  await _pumpAndCapture(
    tester,
    size: size,
    locale: locale,
    outputPath: outputPath,
    overrides: [
      calculatorProvider.overrideWith((ref) => _preFilledController()),
    ],
    page: const FloorCalculatorPage(),
  );
}

Future<void> _captureResult(
  WidgetTester tester, {
  required Size size,
  required Locale locale,
  required String outputPath,
}) async {
  await _pumpAndCapture(
    tester,
    size: size,
    locale: locale,
    outputPath: outputPath,
    overrides: [
      lastResultProvider.overrideWith((ref) => _fixtureResult()),
    ],
    page: const ResultPage(),
  );
}

Future<void> _pumpAndCapture(
  WidgetTester tester, {
  required Size size,
  required Locale locale,
  required String outputPath,
  required List<Override> overrides,
  required Widget page,
}) async {
  // Define o tamanho físico exato (sem multiplicar por devicePixelRatio).
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  final boundaryKey = GlobalKey();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        localeProvider.overrideWith((ref) => locale),
        themeModeProvider.overrideWith((ref) => ThemeMode.light),
        ...overrides,
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        locale: locale,
        supportedLocales: supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: RepaintBoundary(key: boundaryKey, child: page),
      ),
    ),
  );
  await tester.pumpAndSettle();

  ByteData? bytes;
  await tester.runAsync(() async {
    final boundary =
        boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 1.0);
    bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
  });

  if (bytes == null) {
    fail('Failed to capture image for $outputPath');
  }
  final file = File(outputPath);
  await file.create(recursive: true);
  await file.writeAsBytes(bytes!.buffer.asUint8List());
}
