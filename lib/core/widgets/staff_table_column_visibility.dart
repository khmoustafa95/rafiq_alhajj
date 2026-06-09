import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/widgets/staff_data_table.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Describes a hideable staff table column for the column picker UI.
class StaffTableColumnOption {
  const StaffTableColumnOption({
    required this.id,
    required this.label,
    this.essential = false,
  });

  final String id;
  final String label;
  final bool essential;
}

/// Persists hidden column ids per table in [SharedPreferences].
class StaffTableColumnVisibilityStorage {
  const StaffTableColumnVisibilityStorage(this._prefsKey);

  final String _prefsKey;

  Future<Set<String>> loadHidden({
    required Set<String> knownColumnIds,
    required Set<String> essentialColumnIds,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null || raw.isEmpty) {
      return {};
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return {};
      }
      return decoded
          .whereType<String>()
          .where(knownColumnIds.contains)
          .where((id) => !essentialColumnIds.contains(id))
          .toSet();
    } catch (_) {
      return {};
    }
  }

  Future<void> saveHidden(Set<String> hiddenIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(hiddenIds.toList()..sort()));
  }
}

List<StaffTableColumn<T>> filterVisibleStaffColumns<T>({
  required List<StaffTableColumn<T>> allColumns,
  required Set<String> hiddenColumnIds,
  required Set<String> essentialColumnIds,
}) {
  return allColumns
      .where(
        (column) =>
            essentialColumnIds.contains(column.id) ||
            !hiddenColumnIds.contains(column.id),
      )
      .toList();
}

Future<void> showStaffTableColumnPicker({
  required BuildContext context,
  required List<StaffTableColumnOption> options,
  required Set<String> hiddenColumnIds,
  required ValueChanged<Set<String>> onChanged,
}) async {
  final l10n = AppLocalizations.of(context);
  final draft = Set<String>.from(hiddenColumnIds);

  await showDialog<void>(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(l10n.staffTableColumnsTitle),
            content: SizedBox(
              width: sw(360),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final option in options)
                      CheckboxListTile(
                        value: option.essential ||
                            !draft.contains(option.id),
                        onChanged: option.essential
                            ? null
                            : (visible) {
                                setDialogState(() {
                                  if (visible ?? false) {
                                    draft.remove(option.id);
                                  } else {
                                    draft.add(option.id);
                                  }
                                });
                              },
                        title: Text(option.label),
                        subtitle: option.essential
                            ? Text(l10n.staffTableColumnRequired)
                            : null,
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setDialogState(() => draft.clear());
                },
                child: Text(l10n.staffTableColumnsShowAll),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(l10n.dialogCancel),
              ),
              FilledButton(
                onPressed: () {
                  onChanged(Set<String>.from(draft));
                  Navigator.pop(ctx);
                },
                child: Text(l10n.staffTableColumnsApply),
              ),
            ],
          );
        },
      );
    },
  );
}
