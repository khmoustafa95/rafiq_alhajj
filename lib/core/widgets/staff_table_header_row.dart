import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_models.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';

/// Sortable column header row for [StaffDataTable].
class StaffTableHeaderRow extends StatelessWidget {
  const StaffTableHeaderRow({
    required this.columns,
    required this.query,
    required this.hasTrailing,
    required this.onSort,
    required this.fixedWidths,
    required this.compact,
    this.selectable = false,
    this.headerCheckboxValue,
    this.onToggleAll,
    super.key,
  });

  final List<StaffTableColumn<dynamic>> columns;
  final StaffTableQuery query;
  final bool hasTrailing;
  final ValueChanged<String> onSort;
  final bool fixedWidths;
  final bool compact;
  final bool selectable;
  final bool? headerCheckboxValue;
  final ValueChanged<bool?>? onToggleAll;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme.labelMedium?.copyWith(
          color: scheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        );

    return ColoredBox(
      color: scheme.surfaceContainerHighest,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sw(16),
          vertical: compact ? sh(8) : sh(12),
        ),
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
              final cell = column.sortable
                  ? Semantics(
                      button: true,
                      label: column.label,
                      selected: isActive,
                      child: InkWell(
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
                                      : scheme.onSurfaceVariant,
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
                                  : scheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Text(
                      column.label,
                      style: style,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
              return fixedWidths
                  ? SizedBox(width: column.minWidth, child: cell)
                  : Expanded(flex: column.flex, child: cell);
            }),
            if (hasTrailing)
              const SizedBox(width: staffTableActionsColumnWidth),
          ],
        ),
      ),
    );
  }
}
