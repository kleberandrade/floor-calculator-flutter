import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:floor_calculator/main.dart';

void main() {
  testWidgets(
    'example calculates, editing invalidates result and clear resets',
    (tester) async {
      tester.view.physicalSize = const Size(1280, 1200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MyApp());
      await tester.tap(find.text('Usar exemplo'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Calcular quantidade'));
      await tester.pumpAndSettle();
      expect(find.text('28 peças'), findsOneWidget);
      expect(find.text('7 caixas'), findsOneWidget);
      await tester.enterText(find.byType(TextFormField).first, '0');
      await tester.pumpAndSettle();
      expect(find.text('28 peças'), findsNothing);
      await tester.tap(find.text('Calcular quantidade'));
      await tester.pumpAndSettle();
      expect(find.text('Informe um valor maior que zero.'), findsOneWidget);
      await tester.tap(find.byTooltip('Limpar formulário'));
      await tester.pumpAndSettle();
      expect(find.text('Pronto para planejar?'), findsOneWidget);
    },
  );
  testWidgets('narrow screen with large text scrolls without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    tester.platformDispatcher.textScaleFactorTestValue = 1.5;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Usar exemplo'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Calcular quantidade'));
    await tester.tap(find.text('Calcular quantidade'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('28 peças'));
    expect(find.text('7 caixas'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
  testWidgets('validates localized input and explains excessive quantities', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 1500);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('Calcular quantidade'));
    await tester.pumpAndSettle();
    expect(
      find.text('Informe um número válido (ex.: 2,40).'),
      findsNWidgets(6),
    );
    await tester.tap(find.text('Usar exemplo'));
    await tester.enterText(find.byType(TextFormField).at(4), '101');
    await tester.enterText(find.byType(TextFormField).at(5), '2.5');
    await tester.tap(find.text('Calcular quantidade'));
    await tester.pumpAndSettle();
    expect(find.text('Use uma perda entre 0 e 100%.'), findsOneWidget);
    expect(find.text('Use um inteiro de 1 a 10.000.'), findsOneWidget);
    await tester.tap(find.text('Usar exemplo'));
    await tester.enterText(find.byType(TextFormField).at(2), '0,000001');
    await tester.tap(find.text('Calcular quantidade'));
    await tester.pumpAndSettle();
    expect(
      find.text('Quantidade muito alta. Confira as medidas e unidades.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
