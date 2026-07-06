import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/widgets/staff_data_table.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_assign_group_dialog.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_bulk_edit_dialog.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Bulk actions for the operator pilgrim registry table.
abstract final class OperatorPilgrimBulkActions {
  static List<StaffTableBulkAction<OperatorPilgrimSummary>> build({
    required BuildContext context,
    required WidgetRef ref,
    required AppLocalizations l10n,
    required List<PilgrimGroupOption> groups,
  }) {
    return [
      StaffTableBulkAction(
        label: l10n.bulkEditAction,
        icon: Icons.edit_note_outlined,
        onPressed: (items) => unawaited(
          PilgrimBulkEditDialog.show(
            context,
            items.map((item) => item.pilgrimId).toList(),
          ),
        ),
      ),
      StaffTableBulkAction(
        label: l10n.adminPilgrimBulkAssignGroup,
        icon: Icons.groups_outlined,
        onPressed: (items) => unawaited(
          OperatorPilgrimAssignGroupDialog.show(
            context: context,
            ref: ref,
            l10n: l10n,
            groups: groups,
            pilgrimIds: items.map((item) => item.pilgrimId).toList(),
          ),
        ),
      ),
      StaffTableBulkAction(
        label: l10n.adminPilgrimBulkClearGroup,
        icon: Icons.group_off_outlined,
        onPressed: (items) => unawaited(
          OperatorPilgrimAssignGroupDialog.clearGroup(
            context: context,
            ref: ref,
            l10n: l10n,
            pilgrimIds: items.map((item) => item.pilgrimId).toList(),
          ),
        ),
      ),
    ];
  }
}
