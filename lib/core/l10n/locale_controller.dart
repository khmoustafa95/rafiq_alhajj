import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/l10n/app_locale_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_controller.g.dart';

@Riverpod(keepAlive: true)
class LocaleController extends _$LocaleController {
  @override
  Locale build() {
    unawaited(_restoreSavedLocale());
    return AppLocaleSettings.defaultLocale;
  }

  Future<void> _restoreSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = AppLocaleSettings.fromLanguageCode(
      prefs.getString(AppLocaleSettings.storageKey),
    );
    if (saved != null && saved != state) {
      state = saved;
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (!AppLocaleSettings.supportedLocales
        .any((item) => item.languageCode == locale.languageCode)) {
      return;
    }
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppLocaleSettings.storageKey, locale.languageCode);
  }
}
