import 'dart:async';
import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pilgrim_shared_defaults_provider.g.dart';

/// Storage key for the operator intake "shared defaults" (logistics fields
/// reused across a batch of pilgrims so they are not retyped each time).
const pilgrimSharedDefaultsPrefsKey = 'operator_intake_shared_defaults';

/// Persisted map of shared logistics field values, keyed by catalog field key.
@Riverpod(keepAlive: true)
class PilgrimSharedDefaults extends _$PilgrimSharedDefaults {
  @override
  Map<String, dynamic> build() {
    unawaited(_restore());
    return const {};
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(pilgrimSharedDefaultsPrefsKey);
    if (raw == null || raw.isEmpty || !ref.mounted) {
      return;
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map) {
        state = Map<String, dynamic>.from(decoded);
      }
    } catch (_) {
      // Ignore corrupt persisted defaults.
    }
  }

  Future<void> setAll(Map<String, dynamic> values) async {
    state = Map<String, dynamic>.from(values);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(pilgrimSharedDefaultsPrefsKey, jsonEncode(state));
  }

  Future<void> clear() async {
    state = const {};
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(pilgrimSharedDefaultsPrefsKey);
  }
}
