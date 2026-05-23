import 'package:floor_calculator/core/theme_app.dart';
import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toastification/toastification.dart';

/// Monta uma página isolada (sem go_router) com ProviderScope, MaterialApp
/// localizado e ToastificationWrapper. Útil para widget tests que querem
/// validar uma página específica sem depender da navegação completa.
Future<void> pumpPage(
  WidgetTester tester, {
  required Widget page,
  Locale locale = const Locale('pt'),
  ThemeMode themeMode = ThemeMode.light,
  List<Override> overrides = const [],
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        localeProvider.overrideWith((ref) => locale),
        themeModeProvider.overrideWith((ref) => themeMode),
        ...overrides,
      ],
      child: ToastificationWrapper(
        child: MaterialApp(
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
          home: page,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
