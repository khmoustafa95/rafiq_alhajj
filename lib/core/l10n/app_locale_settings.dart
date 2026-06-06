import 'package:flutter/material.dart';

/// Supported app locales and persistence key.
abstract final class AppLocaleSettings {
  static const String storageKey = 'app_locale';

  static const Locale defaultLocale = Locale('ar');

  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  static Locale? fromLanguageCode(String? code) {
    if (code == null) {
      return null;
    }
    for (final locale in supportedLocales) {
      if (locale.languageCode == code) {
        return locale;
      }
    }
    return null;
  }
}
