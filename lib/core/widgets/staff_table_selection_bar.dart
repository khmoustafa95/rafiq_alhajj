import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_button_styles.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_models.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Bulk-action bar shown when rows are selected in a staff data table.
class StaffTableSelectionBar<T> extends StatelessWidget {
  const StaffTableSelectionBar({
    required this.l10n,
    required this.selectedCount,
    required this.bulkActions,
    required this.selectedItems,
    required this.onClear,
    super.key,
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
        decoration: AppDecorations.card().copyWith(
          color: AppColors.primary.withValues(alpha: 0.08),
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
              TextButton(
                onPressed: onClear,
                child: Text(l10n.staffTableClearSelection),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
