import 'package:floor_calculator/l10n/gen/app_localizations.dart';
import 'package:flutter/widgets.dart';

/// Carrega [AppLocalizations] para um [Locale] em testes unitários,
/// sem precisar montar um Widget tree completo.
Future<AppLocalizations> loadL10n([Locale locale = const Locale('pt')]) {
  return AppLocalizations.delegate.load(locale);
}
