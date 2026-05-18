import 'dart:ui';

import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Resolves [AppLocalizations] without a [BuildContext] (bootstrap error UI).
AppLocalizations resolveBootstrapLocalizations() {
  final deviceLocale = PlatformDispatcher.instance.locale;

  for (final locale in AppLocalizations.supportedLocales) {
    if (locale.languageCode == deviceLocale.languageCode) {
      return lookupAppLocalizations(locale);
    }
  }

  return lookupAppLocalizations(const Locale('en'));
}
