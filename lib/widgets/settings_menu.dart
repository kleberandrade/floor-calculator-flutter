import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:floor_calculator/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsMenu extends ConsumerWidget {
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider) ?? Localizations.localeOf(context);

    return PopupMenuButton<_SettingsAction>(
      icon: const Icon(Icons.settings),
      onSelected: (action) => action.apply(ref),
      itemBuilder: (context) => [
        PopupMenuItem<_SettingsAction>(
          enabled: false,
          child: Text(
            l10n.themeMenuTitle,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        _themeItem(l10n.themeSystem, ThemeMode.system, themeMode),
        _themeItem(l10n.themeLight, ThemeMode.light, themeMode),
        _themeItem(l10n.themeDark, ThemeMode.dark, themeMode),
        const PopupMenuDivider(),
        PopupMenuItem<_SettingsAction>(
          enabled: false,
          child: Text(
            l10n.languageMenuTitle,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        _localeItem(l10n.languagePortuguese, const Locale('pt'), locale),
        _localeItem(l10n.languageEnglish, const Locale('en'), locale),
        _localeItem(l10n.languageSpanish, const Locale('es'), locale),
      ],
    );
  }

  PopupMenuItem<_SettingsAction> _themeItem(
    String label,
    ThemeMode value,
    ThemeMode current,
  ) {
    return PopupMenuItem(
      value: _ThemeAction(value),
      child: Row(
        children: [
          Icon(
            value == current ? Icons.radio_button_checked : Icons.radio_button_off,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  PopupMenuItem<_SettingsAction> _localeItem(
    String label,
    Locale value,
    Locale current,
  ) {
    return PopupMenuItem(
      value: _LocaleAction(value),
      child: Row(
        children: [
          Icon(
            value.languageCode == current.languageCode
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

sealed class _SettingsAction {
  const _SettingsAction();
  void apply(WidgetRef ref);
}

class _ThemeAction extends _SettingsAction {
  final ThemeMode mode;
  const _ThemeAction(this.mode);
  @override
  void apply(WidgetRef ref) {
    ref.read(themeModeProvider.notifier).state = mode;
  }
}

class _LocaleAction extends _SettingsAction {
  final Locale locale;
  const _LocaleAction(this.locale);
  @override
  void apply(WidgetRef ref) {
    ref.read(localeProvider.notifier).state = locale;
  }
}
