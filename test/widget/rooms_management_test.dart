import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/pages/calculators/floor_calculator_page.dart';
import 'package:floor_calculator/providers/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/pump_app.dart';

void main() {
  testWidgets('controller adiciona e remove cômodos via API', (tester) async {
    await pumpPage(tester, page: const FloorCalculatorPage());

    final container = ProviderScope.containerOf(
      tester.element(find.byType(FloorCalculatorPage)),
    );
    final controller = container.read(calculatorProvider);
    expect(controller.rooms.length, 1);

    controller.addRoom();
    controller.addRoom();
    await tester.pumpAndSettle();
    expect(controller.rooms.length, 3);

    controller.removeRoom(0);
    await tester.pumpAndSettle();
    expect(controller.rooms.length, 2);
  });

  testWidgets('nome padrão do cômodo respeita o idioma', (tester) async {
    await pumpPage(
      tester,
      page: const FloorCalculatorPage(),
      locale: const Locale('en'),
    );

    final container = ProviderScope.containerOf(
      tester.element(find.byType(FloorCalculatorPage)),
    );
    final controller = container.read(calculatorProvider);
    final l10n = await AppLocalizations.delegate.load(const Locale('en'));

    controller.addRoom();
    expect(controller.rooms[1].name, l10n.defaultRoomName(2));
  });
}
