import 'dart:async';

import 'package:rafiq_alhajj/core/widgets/staff_table_column_visibility.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pilgrim_table_column_visibility_provider.g.dart';

/// Storage key for pilgrim registry table column visibility (web).
const pilgrimTableColumnPrefsKey = 'staff_table_hidden_columns_pilgrim_registry';

/// Column ids for the operator/admin pilgrim list table.
abstract final class PilgrimTableColumns {
  static const essential = {'full_name'};

  static const all = {
    'full_name',
    'gender',
    'group',
    'passport',
    'travel_permit',
    'medical_test',
    'travel_date',
    'hotel',
    'cluster',
    'sticker',
    'makkah_hotel',
    'phone',
    'whatsapp',
  };
}

@Riverpod(keepAlive: true)
class PilgrimTableColumnVisibility extends _$PilgrimTableColumnVisibility {
  static const _storage =
      StaffTableColumnVisibilityStorage(pilgrimTableColumnPrefsKey);

  @override
  Set<String> build() {
    unawaited(_restore());
    return {};
  }

  Future<void> _restore() async {
    final hidden = await _storage.loadHidden(
      knownColumnIds: PilgrimTableColumns.all,
      essentialColumnIds: PilgrimTableColumns.essential,
    );
    if (!ref.mounted) {
      return;
    }
    state = hidden;
  }

  Future<void> setHidden(Set<String> hiddenIds) async {
    final sanitized = hiddenIds
        .where(PilgrimTableColumns.all.contains)
        .where((id) => !PilgrimTableColumns.essential.contains(id))
        .toSet();
    state = sanitized;
    await _storage.saveHidden(sanitized);
  }
}
