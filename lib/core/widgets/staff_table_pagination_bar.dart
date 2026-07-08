import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Pagination and density controls below a staff data table.
class StaffTablePaginationBar extends StatelessWidget {
  const StaffTablePaginationBar({
    required this.l10n,
    required this.theme,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
    required this.pageSize,
    required this.compact,
    required this.onToggleDensity,
    required this.onPageChanged,
    required this.onPageSizeChanged,
    super.key,
  });

  final AppLocalizations l10n;
  final ThemeData theme;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final int pageSize;
  final bool compact;
  final VoidCallback onToggleDensity;
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
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );

    final densityTooltip = compact
        ? l10n.staffTableDensityComfortable
        : l10n.staffTableDensityCompact;

    final controls = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          button: true,
          label: densityTooltip,
          child: IconButton(
            onPressed: onToggleDensity,
            icon: Icon(
              compact
                  ? Icons.density_small_rounded
                  : Icons.density_medium_rounded,
            ),
            tooltip: densityTooltip,
            visualDensity: VisualDensity.compact,
          ),
        ),
        SizedBox(width: sw(8)),
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
        Semantics(
          button: true,
          label: l10n.staffTablePreviousPage,
          enabled: currentPage > 0,
          child: IconButton(
            onPressed: currentPage > 0
                ? () => onPageChanged(currentPage - 1)
                : null,
            icon: const Icon(Icons.chevron_left),
            tooltip: l10n.staffTablePreviousPage,
          ),
        ),
        Text(
          l10n.staffTablePageOf(currentPage + 1, totalPages),
          style: theme.textTheme.bodySmall,
        ),
        Semantics(
          button: true,
          label: l10n.staffTableNextPage,
          enabled: currentPage < totalPages - 1,
          child: IconButton(
            onPressed: currentPage < totalPages - 1
                ? () => onPageChanged(currentPage + 1)
                : null,
            icon: const Icon(Icons.chevron_right),
            tooltip: l10n.staffTableNextPage,
          ),
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
