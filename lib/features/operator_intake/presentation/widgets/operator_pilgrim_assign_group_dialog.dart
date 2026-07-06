import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Bulk group assignment dialogs for the operator pilgrim registry.
abstract final class OperatorPilgrimAssignGroupDialog {
  static Future<void> show({
    required BuildContext context,
    required WidgetRef ref,
    required AppLocalizations l10n,
    required List<PilgrimGroupOption> groups,
    required List<String> pilgrimIds,
  }) async {
    if (groups.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminPilgrimNoGroups)),
      );
      return;
    }

    var selectedGroupId = groups.first.id;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminPilgrimAssignGroupTitle),
        content: DropdownButtonFormField<String>(
          initialValue: selectedGroupId,
          decoration: InputDecoration(labelText: l10n.staffTableFilterGroup),
          items: groups
              .map(
                (group) => DropdownMenuItem(
                  value: group.id,
                  child: Text(group.name),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              selectedGroupId = value;
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.dialogCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.adminPilgrimAssignGroupConfirm),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    await _assign(
      context: context,
      ref: ref,
      l10n: l10n,
      pilgrimIds: pilgrimIds,
      groupId: selectedGroupId,
    );
  }

  static Future<void> clearGroup({
    required BuildContext context,
    required WidgetRef ref,
    required AppLocalizations l10n,
    required List<String> pilgrimIds,
  }) async {
    await _assign(
      context: context,
      ref: ref,
      l10n: l10n,
      pilgrimIds: pilgrimIds,
      groupId: null,
    );
  }

  static Future<void> _assign({
    required BuildContext context,
    required WidgetRef ref,
    required AppLocalizations l10n,
    required List<String> pilgrimIds,
    required String? groupId,
  }) async {
    final ok = await ref.read(pilgrimBulkAssignGroupProvider.notifier).assign(
          pilgrimIds: pilgrimIds,
          groupId: groupId,
        );

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? l10n.adminPilgrimAssignGroupSuccess : l10n.adminPilgrimAssignGroupError,
        ),
      ),
    );
  }
}
