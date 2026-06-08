import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';

/// Responsive grid for staff web dashboards and card lists.
class StaffResponsiveGrid extends StatelessWidget {
  const StaffResponsiveGrid({
    required this.children,
    this.minItemWidth = 260,
    this.maxColumns = 3,
    this.spacing = 16,
    super.key,
  });

  final List<Widget> children;
  final double minItemWidth;
  final int maxColumns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!constraints.hasBoundedWidth) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _withSpacing(children, spacing, vertical: true),
          );
        }

        final width = constraints.maxWidth;
        final columns = (width / minItemWidth).floor().clamp(1, maxColumns);

        if (columns == 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _withSpacing(children, spacing, vertical: true),
          );
        }

        final itemWidth = (width - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: children
              .map((child) => SizedBox(width: itemWidth, child: child))
              .toList(),
        );
      },
    );
  }

  List<Widget> _withSpacing(
    List<Widget> items,
    double gap, {
    required bool vertical,
  }) {
    final result = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      result.add(items[i]);
      if (i < items.length - 1) {
        result.add(
          SizedBox(
            width: vertical ? null : sw(gap),
            height: vertical ? sh(gap) : null,
          ),
        );
      }
    }
    return result;
  }
}
