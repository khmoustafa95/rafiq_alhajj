import 'package:flutter/material.dart';

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
    this.minWidth = 140,
    this.sortable = false,
    this.alignment = AlignmentDirectional.centerStart,
  });

  final String id;
  final String label;
  final int flex;

  /// Minimum width this column needs to stay readable. When the sum of all
  /// column min-widths exceeds the viewport the table scrolls horizontally and
  /// each column is laid out at [minWidth]; otherwise columns share the extra
  /// space by [flex].
  final double minWidth;
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
