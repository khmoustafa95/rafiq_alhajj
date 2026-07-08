import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/telemetry/agent_debug_log.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_data_row.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_density_provider.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_empty_state.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_header_row.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_models.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_pagination_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_selection_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_toolbar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

export 'package:rafiq_alhajj/core/widgets/staff_cell_text.dart';
export 'package:rafiq_alhajj/core/widgets/staff_table_models.dart';
export 'package:rafiq_alhajj/core/widgets/staff_table_row_actions.dart';
export 'package:rafiq_alhajj/core/widgets/staff_toolbar_button.dart';

class StaffDataTable<T> extends ConsumerStatefulWidget {
  const StaffDataTable({
    required this.columns,
    required this.rows,
    required this.totalCount,
    required this.query,
    required this.onQueryChanged,
    required this.searchHint,
    this.isLoading = false,
    this.filters = const [],
    this.onRowTap,
    this.trailingBuilder,
    this.emptyMessage,
    this.emptyIcon = Icons.inbox_outlined,
    this.toolbarActions = const [],
    this.selectable = false,
    this.rowKey,
    this.bulkActions = const [],
    super.key,
  });

  final List<StaffTableColumn<T>> columns;
  final List<T> rows;
  final int totalCount;
  final StaffTableQuery query;
  final ValueChanged<StaffTableQuery> onQueryChanged;
  final String searchHint;
  final bool isLoading;
  final List<StaffTableFilter> filters;
  final void Function(T item)? onRowTap;
  final Widget Function(BuildContext context, T item)? trailingBuilder;
  final String? emptyMessage;
  final IconData emptyIcon;
  final List<Widget> toolbarActions;
  final bool selectable;
  final String Function(T item)? rowKey;
  final List<StaffTableBulkAction<T>> bulkActions;

  @override
  ConsumerState<StaffDataTable<T>> createState() => _StaffDataTableState<T>();
}

class _StaffDataTableState<T> extends ConsumerState<StaffDataTable<T>> {
  final Set<String> _selectedKeys = {};
  final ScrollController _horizontalController = ScrollController();
  int _buildCount = 0;

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  bool get _isSelectable =>
      widget.selectable && widget.rowKey != null && widget.bulkActions.isNotEmpty;

  @override
  void didUpdateWidget(covariant StaffDataTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query.page != widget.query.page ||
        oldWidget.query.filters != widget.query.filters ||
        (oldWidget.query.search != widget.query.search &&
            oldWidget.query.sortColumnId != widget.query.sortColumnId)) {
      _selectedKeys.clear();
    }
  }

  void _updateQuery(StaffTableQuery query) {
    widget.onQueryChanged(query);
  }

  void _onSearchCommitted(String value) {
    _updateQuery(widget.query.copyWith(search: value, page: 0));
  }

  void _toggleSort(String columnId) {
    final isSame = widget.query.sortColumnId == columnId;
    _updateQuery(
      widget.query.copyWith(
        sortColumnId: columnId,
        sortAscending: isSame ? !widget.query.sortAscending : true,
        page: 0,
      ),
    );
  }

  int get _totalPages {
    if (widget.totalCount == 0) {
      return 1;
    }
    return (widget.totalCount / widget.query.pageSize).ceil();
  }

  List<T> get _selectedItems {
    if (!_isSelectable) {
      return const [];
    }
    final keyOf = widget.rowKey!;
    return widget.rows.where((row) => _selectedKeys.contains(keyOf(row))).toList();
  }

  bool? get _headerCheckboxValue {
    if (!_isSelectable || widget.rows.isEmpty) {
      return false;
    }
    final keys = widget.rows.map(widget.rowKey!).toSet();
    final selectedOnPage = keys.intersection(_selectedKeys);
    if (selectedOnPage.isEmpty) {
      return false;
    }
    if (selectedOnPage.length == keys.length) {
      return true;
    }
    return null;
  }

  void _toggleRow(String key, bool selected) {
    setState(() {
      if (selected) {
        _selectedKeys.add(key);
      } else {
        _selectedKeys.remove(key);
      }
    });
  }

  void _toggleAll(bool? value) {
    if (!_isSelectable) {
      return;
    }
    setState(() {
      if (value != true) {
        for (final row in widget.rows) {
          _selectedKeys.remove(widget.rowKey!(row));
        }
        return;
      }
      for (final row in widget.rows) {
        _selectedKeys.add(widget.rowKey!(row));
      }
    });
  }

  void _clearSelection() {
    if (_selectedKeys.isEmpty) {
      return;
    }
    setState(_selectedKeys.clear);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final compact = ref.watch(staffTableCompactDensityProvider);
    _buildCount++;
    if (AppConfig.rebuildDebugLog) {
      agentDebugLog(
        location: 'staff_data_table.dart:build',
        message: 'StaffDataTable rebuild',
        hypothesisId: 'D',
        data: {
          'buildCount': _buildCount,
          'rowCount': widget.rows.length,
          'isLoading': widget.isLoading,
          'columnsHash': widget.columns.map((c) => c.id).join(','),
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StaffTableToolbar(
          key: const ValueKey('staff-table-toolbar'),
          committedSearch: widget.query.search,
          searchHint: widget.searchHint,
          filters: widget.filters,
          query: widget.query,
          toolbarActions: widget.toolbarActions,
          onSearchCommitted: _onSearchCommitted,
          onFilterChanged: (filters) {
            _updateQuery(widget.query.copyWith(filters: filters, page: 0));
          },
        ),
        if (_isSelectable && _selectedKeys.isNotEmpty) ...[
          SizedBox(height: sh(8)),
          StaffTableSelectionBar<T>(
            l10n: l10n,
            selectedCount: _selectedKeys.length,
            bulkActions: widget.bulkActions,
            selectedItems: _selectedItems,
            onClear: _clearSelection,
          ),
        ],
        SizedBox(height: sh(12)),
        Expanded(
          child: DecoratedBox(
            decoration: AppDecorations.themedCard(context),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
              child: widget.isLoading && widget.rows.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : widget.rows.isEmpty
                      ? StaffTableEmptyState(
                          message: widget.emptyMessage ?? l10n.staffTableEmpty,
                          icon: widget.emptyIcon,
                        )
                      : _buildTable(compact),
            ),
          ),
        ),
        SizedBox(height: sh(12)),
        StaffTablePaginationBar(
          l10n: l10n,
          theme: theme,
          currentPage: widget.query.page,
          totalPages: _totalPages,
          totalCount: widget.totalCount,
          pageSize: widget.query.pageSize,
          compact: compact,
          onToggleDensity: () =>
              ref.read(staffTableCompactDensityProvider.notifier).toggle(),
          onPageChanged: (page) {
            _updateQuery(widget.query.copyWith(page: page));
          },
          onPageSizeChanged: (size) {
            _updateQuery(widget.query.copyWith(pageSize: size, page: 0));
          },
        ),
      ],
    );
  }

  Widget _buildTable(bool compact) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dividerColor = Theme.of(context).colorScheme.outlineVariant;
        final selectionW =
            _isSelectable ? staffTableSelectionColumnWidth : 0.0;
        final actionsW =
            widget.trailingBuilder != null ? staffTableActionsColumnWidth : 0.0;
        final rowHorizontalPadding = sw(16) * 2;
        final columnsMin = widget.columns
            .fold<double>(0, (sum, column) => sum + column.minWidth);
        final totalMin =
            selectionW + actionsW + columnsMin + rowHorizontalPadding;
        final fixedWidths = totalMin > constraints.maxWidth;
        final contentWidth = fixedWidths ? totalMin : constraints.maxWidth;

        final table = SizedBox(
          width: contentWidth,
          child: Column(
            children: [
              StaffTableHeaderRow(
                columns: widget.columns,
                query: widget.query,
                hasTrailing: widget.trailingBuilder != null,
                selectable: _isSelectable,
                headerCheckboxValue: _headerCheckboxValue,
                onToggleAll: _toggleAll,
                onSort: _toggleSort,
                fixedWidths: fixedWidths,
                compact: compact,
              ),
              Divider(height: 1, color: dividerColor),
              Expanded(
                child: ListView.separated(
                  itemCount: widget.rows.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 1,
                    color: dividerColor,
                  ),
                  itemBuilder: (context, index) {
                    final item = widget.rows[index];
                    final key = _isSelectable ? widget.rowKey!(item) : null;
                    return StaffTableDataRow<T>(
                      item: item,
                      columns: widget.columns,
                      trailing: widget.trailingBuilder?.call(context, item),
                      onTap: widget.onRowTap == null
                          ? null
                          : () => widget.onRowTap!(item),
                      selectable: _isSelectable,
                      selected: key != null && _selectedKeys.contains(key),
                      onSelectedChanged: key == null
                          ? null
                          : (value) => _toggleRow(key, value ?? false),
                      fixedWidths: fixedWidths,
                      compact: compact,
                    );
                  },
                ),
              ),
            ],
          ),
        );

        if (!fixedWidths) {
          return table;
        }

        return Scrollbar(
          controller: _horizontalController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _horizontalController,
            scrollDirection: Axis.horizontal,
            child: table,
          ),
        );
      },
    );
  }
}
