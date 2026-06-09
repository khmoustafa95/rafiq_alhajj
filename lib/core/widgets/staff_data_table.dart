import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/telemetry/agent_debug_log.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_button_styles.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class StaffTableFilterOption {
  const StaffTableFilterOption({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;
}

class StaffTableFilter {
  const StaffTableFilter({
    required this.id,
    required this.label,
    required this.options,
    this.allLabel,
  });

  final String id;
  final String label;
  final List<StaffTableFilterOption> options;
  final String? allLabel;
}

class StaffTableColumn<T> {
  const StaffTableColumn({
    required this.id,
    required this.label,
    required this.cellBuilder,
    this.flex = 1,
    this.sortable = false,
    this.alignment = AlignmentDirectional.centerStart,
  });

  final String id;
  final String label;
  final int flex;
  final bool sortable;
  final AlignmentDirectional alignment;
  final Widget Function(BuildContext context, T item) cellBuilder;
}

/// Width reserved for trailing row actions (e.g. two compact icon buttons).
const double staffTableActionsColumnWidth = 88;

/// Width reserved for optional selection checkbox column.
const double staffTableSelectionColumnWidth = 48;

class StaffTableBulkAction<T> {
  const StaffTableBulkAction({
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final void Function(List<T> items) onPressed;
}

class StaffDataTable<T> extends StatefulWidget {
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
  State<StaffDataTable<T>> createState() => _StaffDataTableState<T>();
}

class _StaffDataTableState<T> extends State<StaffDataTable<T>> {
  final Set<String> _selectedKeys = {};
  int _buildCount = 0;

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
    _buildCount++;
    // #region agent log
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
    // #endregion

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StaffTableToolbar(
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
          _SelectionBar<T>(
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
            decoration: AppDecorations.card(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
              child: widget.isLoading && widget.rows.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : widget.rows.isEmpty
                      ? _EmptyState(
                          message: widget.emptyMessage ?? l10n.staffTableEmpty,
                          icon: widget.emptyIcon,
                        )
                      : Column(
                          children: [
                            _HeaderRow(
                              columns: widget.columns,
                              query: widget.query,
                              hasTrailing: widget.trailingBuilder != null,
                              selectable: _isSelectable,
                              headerCheckboxValue: _headerCheckboxValue,
                              onToggleAll: _toggleAll,
                              onSort: _toggleSort,
                            ),
                            const Divider(height: 1, color: AppColors.border),
                            Expanded(
                              child: ListView.separated(
                                itemCount: widget.rows.length,
                                separatorBuilder: (_, _) => const Divider(
                                  height: 1,
                                  color: AppColors.border,
                                ),
                                itemBuilder: (context, index) {
                                  final item = widget.rows[index];
                                  final key = _isSelectable
                                      ? widget.rowKey!(item)
                                      : null;
                                  return _DataRow<T>(
                                    item: item,
                                    columns: widget.columns,
                                    trailing: widget.trailingBuilder
                                        ?.call(context, item),
                                    onTap: widget.onRowTap == null
                                        ? null
                                        : () => widget.onRowTap!(item),
                                    selectable: _isSelectable,
                                    selected: key != null &&
                                        _selectedKeys.contains(key),
                                    onSelectedChanged: key == null
                                        ? null
                                        : (value) =>
                                            _toggleRow(key, value ?? false),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
            ),
          ),
        ),
        SizedBox(height: sh(12)),
        _PaginationBar(
          l10n: l10n,
          theme: theme,
          currentPage: widget.query.page,
          totalPages: _totalPages,
          totalCount: widget.totalCount,
          pageSize: widget.query.pageSize,
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
}

class _StaffTableToolbar extends StatefulWidget {
  const _StaffTableToolbar({
    super.key,
    required this.committedSearch,
    required this.searchHint,
    required this.filters,
    required this.query,
    required this.onSearchCommitted,
    required this.onFilterChanged,
    this.toolbarActions = const [],
  });

  final String committedSearch;
  final String searchHint;
  final List<StaffTableFilter> filters;
  final StaffTableQuery query;
  final ValueChanged<String> onSearchCommitted;
  final ValueChanged<Map<String, String>> onFilterChanged;
  final List<Widget> toolbarActions;

  @override
  State<_StaffTableToolbar> createState() => _StaffTableToolbarState();
}

class _StaffTableToolbarState extends State<_StaffTableToolbar> {
  late final TextEditingController _searchController;
  Timer? _searchDebounce;
  String _lastEmittedSearch = '';

  @override
  void initState() {
    super.initState();
    _lastEmittedSearch = widget.committedSearch;
    _searchController = TextEditingController(text: widget.committedSearch);
  }

  @override
  void didUpdateWidget(covariant _StaffTableToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.committedSearch == oldWidget.committedSearch) {
      return;
    }
    // Parent updated search externally (not from our debounced emit).
    if (widget.committedSearch != _lastEmittedSearch) {
      _searchDebounce?.cancel();
      _lastEmittedSearch = widget.committedSearch;
      _searchController.text = widget.committedSearch;
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      _lastEmittedSearch = value;
      widget.onSearchCommitted(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ToolbarLayout(
      searchController: _searchController,
      searchHint: widget.searchHint,
      filters: widget.filters,
      query: widget.query,
      toolbarActions: widget.toolbarActions,
      onSearchChanged: _onSearchChanged,
      onFilterChanged: widget.onFilterChanged,
    );
  }
}

class _ToolbarLayout extends StatelessWidget {
  const _ToolbarLayout({
    required this.searchController,
    required this.searchHint,
    required this.filters,
    required this.query,
    required this.onSearchChanged,
    required this.onFilterChanged,
    this.toolbarActions = const [],
  });

  final TextEditingController searchController;
  final String searchHint;
  final List<StaffTableFilter> filters;
  final StaffTableQuery query;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<Map<String, String>> onFilterChanged;
  final List<Widget> toolbarActions;

  Widget _toolbarTheme(BuildContext context, Widget child) {
    return Theme(
      data: Theme.of(context).copyWith(
        filledButtonTheme: FilledButtonThemeData(
          style: staffRowFilledButtonStyle(context),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: staffRowOutlinedButtonStyle(context),
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final stackSearch = maxWidth < 1100;
        final compact = maxWidth < 720;

        final searchField = TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: searchHint,
            prefixIcon: const Icon(Icons.search, size: 20),
            filled: true,
            fillColor: AppColors.surface,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: sw(12),
              vertical: sh(12),
            ),
          ),
          onChanged: onSearchChanged,
        );

        final filterWidgets = filters.map(
          (filter) => _FilterDropdown(
            filter: filter,
            current: query.filters[filter.id] ?? '',
            fullWidth: compact,
            maxWidth: maxWidth,
            onChanged: onFilterChanged,
            query: query,
          ),
        );

        if (compact) {
          return _toolbarTheme(
            context,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                searchField,
                SizedBox(height: sh(10)),
                ...filterWidgets.map(
                  (widget) => Padding(
                    padding: EdgeInsets.only(bottom: sh(10)),
                    child: widget,
                  ),
                ),
                Wrap(
                  spacing: sw(8),
                  runSpacing: sh(8),
                  children: toolbarActions,
                ),
              ],
            ),
          );
        }

        if (stackSearch) {
          return _toolbarTheme(
            context,
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                searchField,
                SizedBox(height: sh(10)),
                Wrap(
                  spacing: sw(12),
                  runSpacing: sh(10),
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...filterWidgets,
                    ...toolbarActions,
                  ],
                ),
              ],
            ),
          );
        }

        return _toolbarTheme(
          context,
          Wrap(
            spacing: sw(12),
            runSpacing: sh(10),
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: sw(200),
                  maxWidth: sw(360),
                ),
                child: searchField,
              ),
              ...filterWidgets,
              ...toolbarActions,
            ],
          ),
        );
      },
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
    required this.filter,
    required this.current,
    required this.fullWidth,
    required this.maxWidth,
    required this.onChanged,
    required this.query,
  });

  final StaffTableFilter filter;
  final String current;
  final bool fullWidth;
  final double maxWidth;
  final ValueChanged<Map<String, String>> onChanged;
  final StaffTableQuery query;

  @override
  Widget build(BuildContext context) {
    final dropdown = DropdownButtonFormField<String>(
      key: ValueKey('${filter.id}-$current'),
      isExpanded: true,
      initialValue: current.isEmpty ? null : current,
      decoration: InputDecoration(
        labelText: filter.label,
        filled: true,
        fillColor: AppColors.surface,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: sw(12),
          vertical: sh(10),
        ),
      ),
      items: [
        DropdownMenuItem(
          value: '',
          child: Text(
            filter.allLabel ?? '—',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        ...filter.options.map(
          (option) => DropdownMenuItem(
            value: option.value,
            child: Text(
              option.label,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
      onChanged: (value) {
        final next = Map<String, String>.from(query.filters);
        if (value == null || value.isEmpty) {
          next.remove(filter.id);
        } else {
          next[filter.id] = value;
        }
        onChanged(next);
      },
    );

    if (fullWidth) {
      return SizedBox(width: maxWidth, child: dropdown);
    }

    return SizedBox(
      width: sw(180),
      child: dropdown,
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({
    required this.columns,
    required this.query,
    required this.hasTrailing,
    required this.onSort,
    this.selectable = false,
    this.headerCheckboxValue,
    this.onToggleAll,
  });

  final List<StaffTableColumn<dynamic>> columns;
  final StaffTableQuery query;
  final bool hasTrailing;
  final ValueChanged<String> onSort;
  final bool selectable;
  final bool? headerCheckboxValue;
  final ValueChanged<bool?>? onToggleAll;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        );

    return ColoredBox(
      color: AppColors.surfaceMuted,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sw(16), vertical: sh(12)),
        child: Row(
          children: [
            if (selectable) ...[
              SizedBox(
                width: staffTableSelectionColumnWidth,
                child: Checkbox(
                  tristate: true,
                  value: headerCheckboxValue,
                  onChanged: onToggleAll,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
            ...columns.map((column) {
              final isActive = query.sortColumnId == column.id;
              return Expanded(
                flex: column.flex,
                child: column.sortable
                    ? InkWell(
                        onTap: () => onSort(column.id),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                column.label,
                                style: style?.copyWith(
                                  color: isActive
                                      ? AppColors.primary
                                      : AppColors.textSecondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: sw(4)),
                            Icon(
                              isActive
                                  ? (query.sortAscending
                                      ? Icons.arrow_upward_rounded
                                      : Icons.arrow_downward_rounded)
                                  : Icons.unfold_more_rounded,
                              size: ss(16),
                              color: isActive
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                            ),
                          ],
                        ),
                      )
                    : Text(
                        column.label,
                        style: style,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              );
            }),
            if (hasTrailing)
              const SizedBox(width: staffTableActionsColumnWidth),
          ],
        ),
      ),
    );
  }
}

class _DataRow<T> extends StatelessWidget {
  const _DataRow({
    required this.item,
    required this.columns,
    required this.trailing,
    required this.onTap,
    this.selectable = false,
    this.selected = false,
    this.onSelectedChanged,
  });

  final T item;
  final List<StaffTableColumn<T>> columns;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool selectable;
  final bool selected;
  final ValueChanged<bool?>? onSelectedChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.primary.withValues(alpha: 0.06)
          : AppColors.surface,
      child: InkWell(
        onTap: onTap,
        hoverColor: AppColors.primary.withValues(alpha: 0.04),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw(16), vertical: sh(12)),
          child: Row(
            children: [
              if (selectable) ...[
                SizedBox(
                  width: staffTableSelectionColumnWidth,
                  child: Checkbox(
                    value: selected,
                    onChanged: onSelectedChanged,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
              ...columns.map(
                (column) => Expanded(
                  flex: column.flex,
                  child: Align(
                    alignment: column.alignment,
                    child: column.cellBuilder(context, item),
                  ),
                ),
              ),
              if (trailing != null)
                SizedBox(
                  width: staffTableActionsColumnWidth,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: trailing,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionBar<T> extends StatelessWidget {
  const _SelectionBar({
    required this.l10n,
    required this.selectedCount,
    required this.bulkActions,
    required this.selectedItems,
    required this.onClear,
  });

  final AppLocalizations l10n;
  final int selectedCount;
  final List<StaffTableBulkAction<T>> bulkActions;
  final List<T> selectedItems;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        filledButtonTheme: FilledButtonThemeData(
          style: staffRowFilledButtonStyle(context),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: staffRowOutlinedButtonStyle(context),
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw(16), vertical: sh(10)),
          child: Wrap(
            spacing: sw(12),
            runSpacing: sh(8),
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                l10n.staffTableSelectedCount(selectedCount),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              ...bulkActions.map(
                (action) => action.icon == null
                    ? FilledButton.tonal(
                        onPressed: selectedItems.isEmpty
                            ? null
                            : () => action.onPressed(selectedItems),
                        child: Text(action.label),
                      )
                    : FilledButton.tonalIcon(
                        onPressed: selectedItems.isEmpty
                            ? null
                            : () => action.onPressed(selectedItems),
                        icon: Icon(action.icon, size: 18),
                        label: Text(action.label),
                      ),
              ),
              TextButton(onPressed: onClear, child: Text(l10n.staffTableClearSelection)),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaginationBar extends StatelessWidget {
  const _PaginationBar({
    required this.l10n,
    required this.theme,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.pageSize,
    required this.onPageChanged,
    required this.onPageSizeChanged,
  });

  final AppLocalizations l10n;
  final ThemeData theme;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onPageSizeChanged;

  @override
  Widget build(BuildContext context) {
    final from = totalCount == 0 ? 0 : currentPage * pageSize + 1;
    final to = totalCount == 0
        ? 0
        : ((currentPage + 1) * pageSize).clamp(0, totalCount);

    final summary = Text(
      l10n.staffTableShowing(from, to, totalCount),
      style: theme.textTheme.bodySmall?.copyWith(
        color: AppColors.textSecondary,
      ),
    );

    final controls = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.staffTableRowsPerPage,
          style: theme.textTheme.bodySmall,
        ),
        SizedBox(width: sw(8)),
        DropdownButton<int>(
          value: pageSize,
          items: StaffTableQuery.pageSizeOptions
              .map(
                (size) => DropdownMenuItem(
                  value: size,
                  child: Text('$size'),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              onPageSizeChanged(value);
            }
          },
        ),
        SizedBox(width: sw(8)),
        IconButton(
          onPressed: currentPage > 0
              ? () => onPageChanged(currentPage - 1)
              : null,
          icon: const Icon(Icons.chevron_left),
          tooltip: l10n.staffTablePreviousPage,
        ),
        Text(
          l10n.staffTablePageOf(currentPage + 1, totalPages),
          style: theme.textTheme.bodySmall,
        ),
        IconButton(
          onPressed: currentPage < totalPages - 1
              ? () => onPageChanged(currentPage + 1)
              : null,
          icon: const Icon(Icons.chevron_right),
          tooltip: l10n.staffTableNextPage,
        ),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 640) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              summary,
              SizedBox(height: sh(8)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: controls,
              ),
            ],
          );
        }

        return Row(
          children: [
            Flexible(child: summary),
            controls,
          ],
        );
      },
    );
  }
}

/// Compact icon buttons for [StaffDataTable] trailing cells.
class StaffTableRowActions extends StatelessWidget {
  const StaffTableRowActions({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  static Widget iconButton({
    required IconData icon,
    required VoidCallback? onPressed,
    String? tooltip,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 40, height: 36),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.message,
    required this.icon,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sw(24), vertical: sh(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: ss(40), color: AppColors.textSecondary),
            SizedBox(height: sh(12)),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
