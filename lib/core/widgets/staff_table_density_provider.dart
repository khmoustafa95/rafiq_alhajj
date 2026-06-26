import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'staff_table_density_provider.g.dart';

/// Persisted row-density preference shared by every staff data table. When
/// `true` rows render compact (more rows per screen); otherwise comfortable.
@Riverpod(keepAlive: true)
class StaffTableCompactDensity extends _$StaffTableCompactDensity {
  static const _prefsKey = 'staff_table_compact_density';

  @override
  bool build() {
    unawaited(_restore());
    return false;
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(_prefsKey);
    if (value == null || !ref.mounted) {
      return;
    }
    state = value;
  }

  Future<void> toggle() => _set(!state);

  Future<void> _set(bool value) async {
    state = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, value);
  }
}
