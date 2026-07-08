import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/widgets/staff_async_table_body.dart';
import 'package:rafiq_alhajj/core/widgets/staff_data_table.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_bulk_actions.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_list_toolbar.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_whatsapp_credentials.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Web staff table for the operator pilgrim registry.
class OperatorPilgrimWebTable extends ConsumerWidget {
  const OperatorPilgrimWebTable({
    required this.query,
    required this.onQueryChanged,
    required this.columns,
    required this.isAdmin,
    required this.groups,
    required this.filters,
    required this.onOpenPilgrim,
    required this.onOpenImport,
    required this.onOpenIntake,
    required this.onCustomizeColumns,
    required this.onDownloadTemplate,
    required this.onExport,
    this.isLoading = false,
    super.key,
  });

  final StaffTableQuery query;
  final ValueChanged<StaffTableQuery> onQueryChanged;
  final List<StaffTableColumn<OperatorPilgrimSummary>> columns;
  final bool isAdmin;
  final List<PilgrimGroupOption> groups;
  final List<StaffTableFilter> filters;
  final ValueChanged<OperatorPilgrimSummary> onOpenPilgrim;
  final VoidCallback onOpenImport;
  final VoidCallback onOpenIntake;
  final VoidCallback onCustomizeColumns;
  final VoidCallback onDownloadTemplate;
  final VoidCallback onExport;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final pageAsync = ref.watch(operatorPilgrimRegistryPageProvider(query));

    return StaffAsyncTableBody<OperatorPilgrimSummary>(
      tableKey: const ValueKey('operator-pilgrims-table'),
      pageAsync: pageAsync,
      query: query,
      onQueryChanged: onQueryChanged,
      columns: columns,
      searchHint: l10n.operatorPilgrimSearchHint,
      filters: filters,
      toolbarActions: OperatorPilgrimListToolbar.buildActions(
        l10n: l10n,
        isAdmin: isAdmin,
        onCustomizeColumns: onCustomizeColumns,
        onDownloadTemplate: onDownloadTemplate,
        onExport: onExport,
        onImport: onOpenImport,
        onAddPilgrim: onOpenIntake,
      ),
      isLoading: isLoading,
      onRetry: () => ref.invalidate(operatorPilgrimRegistryPageProvider(query)),
      onRowTap: onOpenPilgrim,
      trailingBuilder: (context, item) => StaffTableRowActions(
        children: [
          if (OperatorPilgrimWhatsappCredentials.canSend(item))
            StaffTableRowActions.iconButton(
              icon: Icons.chat_outlined,
              tooltip: l10n.operatorSendCredentialsWhatsapp,
              onPressed: () => unawaited(
                OperatorPilgrimWhatsappCredentials.send(
                  context: context,
                  ref: ref,
                  l10n: l10n,
                  item: item,
                ),
              ),
            ),
          StaffTableRowActions.iconButton(
            icon: Icons.edit_outlined,
            onPressed: () => onOpenPilgrim(item),
          ),
        ],
      ),
      selectable: isAdmin,
      rowKey: (item) => item.pilgrimId,
      bulkActions: isAdmin
          ? OperatorPilgrimBulkActions.build(
              context: context,
              ref: ref,
              l10n: l10n,
              groups: groups,
            )
          : const [],
      emptyMessage: l10n.operatorPilgrimListEmpty,
      emptyIcon: Icons.people_outline,
    );
  }
}
