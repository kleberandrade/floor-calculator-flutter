import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/pages/calculators/floor_calculator_page.dart';
import 'package:floor_calculator/providers/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('valida formulário vazio mostra mensagens de erro', (tester) async {
    await pumpPage(tester, page: const FloorCalculatorPage());

    final l10n = await AppLocalizations.delegate.load(const Locale('pt'));
    await _tap(tester, find.text(l10n.calculateButton));

    expect(find.text(l10n.validatorFloorWidth), findsOneWidget);
    expect(find.text(l10n.validatorFloorLength), findsOneWidget);
    expect(find.text(l10n.validatorPricePerBox), findsOneWidget);
    expect(find.text(l10n.validatorPiecesPerBox), findsOneWidget);
    expect(find.text(l10n.validatorRoomWidth), findsOneWidget);
    expect(find.text(l10n.validatorRoomLength), findsOneWidget);
  });

  testWidgets('preenche, calcula e popula lastResultProvider', (tester) async {
    await pumpPage(tester, page: const FloorCalculatorPage());

    final l10n = await AppLocalizations.delegate.load(const Locale('pt'));

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

    final container = ProviderScope.containerOf(
      tester.element(find.byType(FloorCalculatorPage)),
    );
    expect(container.read(lastResultProvider), isNull);

    // Tap CALCULAR. Sem go_router o context.push falha, mas o resultado
    // é gravado no provider ANTES do push. Validamos por aí.
    await tester.ensureVisible(find.text(l10n.calculateButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.calculateButton), warnIfMissed: false);
    await tester.pump();

    // O cálculo seta o provider ANTES do context.push, então o resultado
    // está disponível. O push em si lança "No GoRouter found in context"
    // porque montamos a página isolada sem router — drenamos essa exception.
    expect(container.read(lastResultProvider), isNotNull);
    expect(find.text(l10n.validatorFloorWidth), findsNothing);
    tester.takeException(); // consome a AssertionError do GoRouter
    // drena timers do toast antes do teste terminar
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });
}
