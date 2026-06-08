import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
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

  @override
  State<StaffDataTable<T>> createState() => _StaffDataTableState<T>();
}

class _StaffDataTableState<T> extends State<StaffDataTable<T>> {
  late final TextEditingController _searchController;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.query.search);
  }

  @override
  void didUpdateWidget(covariant StaffDataTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query.search != _searchController.text) {
      _searchController.text = widget.query.search;
    }
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _updateQuery(StaffTableQuery query) {
    widget.onQueryChanged(query);
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 300), () {
      _updateQuery(widget.query.copyWith(search: value, page: 0));
    });
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Toolbar(
          searchController: _searchController,
          searchHint: widget.searchHint,
          filters: widget.filters,
          query: widget.query,
          toolbarActions: widget.toolbarActions,
          onSearchChanged: _onSearchChanged,
          onFilterChanged: (filters) {
            _updateQuery(widget.query.copyWith(filters: filters, page: 0));
          },
        ),
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
                                  return _DataRow<T>(
                                    item: item,
                                    columns: widget.columns,
                                    trailing: widget.trailingBuilder
                                        ?.call(context, item),
                                    onTap: widget.onRowTap == null
                                        ? null
                                        : () => widget.onRowTap!(item),
                                  );
                                },
                              ),
                            ),
                            if (widget.isLoading)
                              const LinearProgressIndicator(minHeight: 2),
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

class _Toolbar extends StatelessWidget {
  const _Toolbar({
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
      child: Wrap(
        spacing: sw(12),
        runSpacing: sh(10),
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: sw(320),
            child: TextField(
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
            ),
          ),
          ...filters.map((filter) {
            final current = query.filters[filter.id] ?? '';
            return SizedBox(
              width: sw(180),
              child: DropdownButtonFormField<String>(
                key: ValueKey('${filter.id}-$current'),
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
                    child: Text(filter.allLabel ?? '—'),
                  ),
                  ...filter.options.map(
                    (option) => DropdownMenuItem(
                      value: option.value,
                      child: Text(option.label),
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
                  onFilterChanged(next);
                },
              ),
            );
          }),
          ...toolbarActions,
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({
    required this.columns,
    required this.query,
    required this.hasTrailing,
    required this.onSort,
  });

  final List<StaffTableColumn<dynamic>> columns;
  final StaffTableQuery query;
  final bool hasTrailing;
  final ValueChanged<String> onSort;

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
  });

  final T item;
  final List<StaffTableColumn<T>> columns;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      child: InkWell(
        onTap: onTap,
        hoverColor: AppColors.primary.withValues(alpha: 0.04),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw(16), vertical: sh(12)),
          child: Row(
            children: [
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

    return Row(
      children: [
        Text(
          l10n.staffTableShowing(from, to, totalCount),
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
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
      child: Padding(
        padding: EdgeInsets.all(sw(32)),
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
