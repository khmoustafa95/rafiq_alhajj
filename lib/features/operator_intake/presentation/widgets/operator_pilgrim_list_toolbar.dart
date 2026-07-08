import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/widgets/staff_data_table.dart';
import 'package:rafiq_alhajj/features/trips/presentation/widgets/trip_selector.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Toolbar action buttons for the operator/admin pilgrim registry table.
abstract final class OperatorPilgrimListToolbar {
  static List<Widget> buildActions({
    required AppLocalizations l10n,
    required bool isAdmin,
    required VoidCallback onCustomizeColumns,
    required VoidCallback onDownloadTemplate,
    required VoidCallback onExport,
    required VoidCallback onImport,
    required VoidCallback onAddPilgrim,
  }) {
    return [
      const TripSelector(),
      StaffToolbarButton(
        icon: Icons.view_column_outlined,
        label: l10n.staffTableColumnsCustomize,
        onPressed: onCustomizeColumns,
      ),
      StaffToolbarButton(
        icon: Icons.description_outlined,
        label: l10n.exportTemplateButton,
        onPressed: onDownloadTemplate,
      ),
      StaffToolbarButton(
        icon: Icons.file_download_outlined,
        label: l10n.exportButton,
        onPressed: onExport,
      ),
      StaffToolbarButton(
        icon: Icons.upload_file_outlined,
        label: l10n.importTitle,
        onPressed: onImport,
      ),
      StaffToolbarButton(
        icon: Icons.person_add_outlined,
        label: isAdmin ? l10n.adminPilgrimAdd : l10n.operatorIntakeTitle,
        onPressed: onAddPilgrim,
        primary: true,
      ),
    ];
  }
}
