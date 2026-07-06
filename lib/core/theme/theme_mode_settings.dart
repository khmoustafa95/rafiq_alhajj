import 'package:flutter/material.dart';

/// Persisted theme-mode preference keys and parsing helpers.
abstract final class ThemeModeSettings {
  static const storageKey = 'app_theme_mode';

  static const system = 'system';
  static const light = 'light';
  static const dark = 'dark';

  static ThemeMode? fromStorage(String? value) {
    return switch (value) {
      system => ThemeMode.system,
      light => ThemeMode.light,
      dark => ThemeMode.dark,
      _ => null,
    };
  }

  static String toStorage(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => system,
      ThemeMode.light => light,
      ThemeMode.dark => dark,
    };
  }
}
