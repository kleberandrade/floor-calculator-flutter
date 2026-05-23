import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/main.dart';
import 'package:floor_calculator/providers/settings_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app inicia em pt e mostra a HomePage', (tester) async {
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
    expect(find.text(l10n.homeTitle), findsOneWidget);
    expect(find.text(l10n.calculatorsSection), findsOneWidget);
    expect(find.text(l10n.toolsSection), findsOneWidget);
    expect(find.text(l10n.floorCalculatorTile), findsOneWidget);
    expect(find.text(l10n.paintCalculatorTile), findsOneWidget);
    expect(find.text(l10n.levelToolTile), findsOneWidget);
  });

  testWidgets('app inicia em en e mostra strings em inglês', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localeProvider.overrideWith((ref) => const Locale('en')),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    final l10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.text(l10n.homeTitle), findsOneWidget);
    expect(find.text(l10n.calculatorsSection), findsOneWidget);
  });
}
