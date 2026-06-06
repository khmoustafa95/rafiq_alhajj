
import 'package:rafiq_alhajj/core/l10n/app_locale_settings.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Resolves [AppLocalizations] without a [BuildContext] (bootstrap error UI).
AppLocalizations resolveBootstrapLocalizations() {
  return lookupAppLocalizations(AppLocaleSettings.defaultLocale);
}
