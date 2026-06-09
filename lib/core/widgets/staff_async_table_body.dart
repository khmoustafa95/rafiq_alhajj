import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/telemetry/agent_debug_log.dart';
import 'package:rafiq_alhajj/core/widgets/staff_data_table.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Renders a single persistent [StaffDataTable] for async paginated data so the
/// search field and toolbar are not recreated on every provider reload.
class StaffAsyncTableBody<T> extends StatelessWidget {
  const StaffAsyncTableBody({
    required this.pageAsync,
    required this.query,
    required this.onQueryChanged,
    required this.columns,
    required this.searchHint,
    required this.tableKey,
    this.filters = const [],
    this.toolbarActions = const [],
    this.isLoading = false,
    this.onRowTap,
    this.trailingBuilder,
    this.emptyMessage,
    this.emptyIcon = Icons.inbox_outlined,
    this.selectable = false,
    this.rowKey,
    this.bulkActions = const [],
    this.onRetry,
    super.key,
  });

  final AsyncValue<PaginatedResult<T>> pageAsync;
  final StaffTableQuery query;
  final ValueChanged<StaffTableQuery> onQueryChanged;
  final List<StaffTableColumn<T>> columns;
  final String searchHint;
  final Key tableKey;
  final List<StaffTableFilter> filters;
  final List<Widget> toolbarActions;
  final bool isLoading;
  final void Function(T item)? onRowTap;
  final Widget Function(BuildContext context, T item)? trailingBuilder;
  final String? emptyMessage;
  final IconData emptyIcon;
  final bool selectable;
  final String Function(T item)? rowKey;
  final List<StaffTableBulkAction<T>> bulkActions;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final page = pageAsync.value;
    final showError = pageAsync.hasError && page == null;
    // #region agent log
    if (AppConfig.rebuildDebugLog) {
      agentDebugLog(
        location: 'staff_async_table_body.dart:build',
        message: 'StaffAsyncTableBody rebuild',
        hypothesisId: 'E',
        data: {
          'isLoading': pageAsync.isLoading,
          'hasValue': pageAsync.hasValue,
          'itemCount': page?.items.length ?? 0,
        },
      );
    }
    // #endregion

    if (showError) {
      return StaffErrorView.fromError(
        l10n,
        error: pageAsync.error!,
        onRetry: onRetry,
      );
    }

    if (!AppPlatform.isWeb) {
      if (pageAsync.isLoading && page == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return const SizedBox.shrink();
    }

    return StaffDataTable<T>(
      key: tableKey,
      columns: columns,
      rows: page?.items ?? const [],
      totalCount: page?.totalCount ?? 0,
      query: query,
      onQueryChanged: onQueryChanged,
      searchHint: searchHint,
      filters: filters,
      toolbarActions: toolbarActions,
      // Only show loading UI on the first fetch — not on realtime refetches
      // while previous page data is still on screen (avoids flickering bar).
      isLoading: isLoading || (pageAsync.isLoading && !pageAsync.hasValue),
      onRowTap: onRowTap,
      trailingBuilder: trailingBuilder,
      emptyMessage: emptyMessage,
      emptyIcon: emptyIcon,
      selectable: selectable,
      rowKey: rowKey,
      bulkActions: bulkActions,
    );
  }
}
