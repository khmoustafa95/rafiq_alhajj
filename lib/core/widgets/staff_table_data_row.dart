import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_models.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';

/// A single data row in [StaffDataTable].
class StaffTableDataRow<T> extends StatelessWidget {
  const StaffTableDataRow({
    required this.item,
    required this.columns,
    required this.trailing,
    required this.onTap,
    required this.fixedWidths,
    required this.compact,
    this.selectable = false,
    this.selected = false,
    this.onSelectedChanged,
    super.key,
  });

  final T item;
  final List<StaffTableColumn<T>> columns;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool fixedWidths;
  final bool compact;
  final bool selectable;
  final bool selected;
  final ValueChanged<bool?>? onSelectedChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: selected
          ? AppColors.primary.withValues(alpha: 0.06)
          : scheme.surfaceContainerHigh,
      child: InkWell(
        onTap: onTap,
        hoverColor: AppColors.primary.withValues(alpha: 0.04),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sw(16),
            vertical: compact ? sh(7) : sh(12),
          ),
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
              ...columns.map((column) {
                final cell = Align(
                  alignment: column.alignment,
                  child: column.cellBuilder(context, item),
                );
                return fixedWidths
                    ? SizedBox(width: column.minWidth, child: cell)
                    : Expanded(flex: column.flex, child: cell);
              }),
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
