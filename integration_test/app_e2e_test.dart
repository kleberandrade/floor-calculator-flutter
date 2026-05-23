import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/main.dart';
import 'package:floor_calculator/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('fluxo completo: preencher, calcular, ver resultado',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localeProvider.overrideWith((ref) => const Locale('pt')),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('pt'));
    expect(find.text(l10n.calculatorTitle), findsOneWidget);

    Future<void> enter(String label, String value) async {
      final field = find.widgetWithText(TextFormField, label);
      await tester.ensureVisible(field);
      await tester.pumpAndSettle();
      await tester.enterText(field, value);
    }

    await enter(l10n.floorWidthLabel, '60');
    await enter(l10n.floorLengthLabel, '60');
    await enter(l10n.pricePerBoxLabel, '120');
    await enter(l10n.piecesPerBoxLabel, '5');
    await enter(l10n.roomWidthLabel, '2.4');
    await enter(l10n.roomLengthLabel, '3.22');

    final calcButton = find.text(l10n.calculateButton);
    await tester.ensureVisible(calcButton);
    await tester.pumpAndSettle();
    await tester.tap(calcButton);
    await tester.pumpAndSettle();

    expect(find.text(l10n.resultTitle), findsOneWidget);
    expect(find.text(l10n.quantitiesSection), findsOneWidget);
    expect(find.text(l10n.piecesUnit(24)), findsWidgets);
    expect(find.text(l10n.boxesLabel(8)), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text(l10n.calculatorTitle), findsOneWidget);
  });

  testWidgets('trocar idioma e calcular em inglês', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localeProvider.overrideWith((ref) => const Locale('pt')),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    final ptL10n = await AppLocalizations.delegate.load(const Locale('pt'));
    await tester.tap(find.text(ptL10n.languageEnglish));
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.text(l10n.calculatorTitle), findsOneWidget);
    expect(find.text(l10n.calculateButton), findsOneWidget);
  });
}
