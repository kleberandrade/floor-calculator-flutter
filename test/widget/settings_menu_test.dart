import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/main.dart';
import 'package:floor_calculator/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('trocar idioma via menu na HomePage', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localeProvider.overrideWith((ref) => const Locale('pt')),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    final ptL10n = await AppLocalizations.delegate.load(const Locale('pt'));
    expect(find.text(ptL10n.homeTitle), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    await tester.tap(find.text(ptL10n.languageEnglish));
    await tester.pumpAndSettle();

    final enL10n = await AppLocalizations.delegate.load(const Locale('en'));
    expect(find.text(enL10n.homeTitle), findsOneWidget);
  });

  testWidgets('trocar tema via menu', (tester) async {
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

    final container = ProviderScope.containerOf(
      tester.element(find.byType(MyApp)),
    );
    expect(container.read(themeModeProvider), ThemeMode.system);

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    await tester.tap(find.text(l10n.themeDark));
    await tester.pumpAndSettle();

    expect(container.read(themeModeProvider), ThemeMode.dark);
  });
}
