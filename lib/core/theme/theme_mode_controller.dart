import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/theme_mode_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_mode_controller.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() {
    unawaited(_restoreSavedThemeMode());
    return ThemeMode.system;
  }

  Future<void> _restoreSavedThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = ThemeModeSettings.fromStorage(
      prefs.getString(ThemeModeSettings.storageKey),
    );
    if (saved != null && saved != state) {
      state = saved;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      ThemeModeSettings.storageKey,
      ThemeModeSettings.toStorage(mode),
    );
  }
}
