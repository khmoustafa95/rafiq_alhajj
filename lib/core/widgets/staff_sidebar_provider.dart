import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'staff_sidebar_provider.g.dart';

/// Persisted collapse state for the staff web sidebar. When collapsed the
/// sidebar shows icon-only navigation (with hover tooltips) to give content
/// pages — especially wide data tables — more horizontal room.
@Riverpod(keepAlive: true)
class StaffSidebarCollapsed extends _$StaffSidebarCollapsed {
  static const _prefsKey = 'staff_sidebar_collapsed';

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
