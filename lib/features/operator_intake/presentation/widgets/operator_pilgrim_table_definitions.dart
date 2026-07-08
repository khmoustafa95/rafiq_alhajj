import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/widgets/staff_data_table.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_column_visibility.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/pilgrim_table_column_visibility_provider.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Column, filter, and picker definitions for the operator pilgrim registry table.
abstract final class OperatorPilgrimTableDefinitions {
  static String genderLabel(AppLocalizations l10n, String? gender) {
    return switch (gender) {
      'male' => l10n.pilgrimGenderMale,
      'female' => l10n.pilgrimGenderFemale,
      _ => '—',
    };
  }

  static List<StaffTableColumnOption> columnPickerOptions(AppLocalizations l10n) {
    return [
      StaffTableColumnOption(
        id: 'full_name',
        label: l10n.operatorFullName,
        essential: true,
      ),
      StaffTableColumnOption(
        id: 'gender',
        label: l10n.staffTableFilterGender,
      ),
      StaffTableColumnOption(
        id: 'group',
        label: l10n.staffTableFilterGroup,
      ),
      StaffTableColumnOption(
        id: 'passport',
        label: l10n.operatorPassport,
      ),
      StaffTableColumnOption(
        id: 'travel_permit',
        label: l10n.operatorTravelPermit,
      ),
      StaffTableColumnOption(
        id: 'medical_test',
        label: l10n.pilgrimMedicalStatus,
      ),
      StaffTableColumnOption(
        id: 'travel_date',
        label: l10n.pilgrimTravelDate,
      ),
      StaffTableColumnOption(
        id: 'hotel',
        label: l10n.pilgrimHotel,
      ),
      StaffTableColumnOption(
        id: 'cluster',
        label: l10n.pilgrimLabelCluster,
      ),
      StaffTableColumnOption(
        id: 'sticker',
        label: l10n.pilgrimLabelSticker,
      ),
      StaffTableColumnOption(
        id: 'makkah_hotel',
        label: l10n.pilgrimLabelMakkahHotel,
      ),
      StaffTableColumnOption(
        id: 'phone',
        label: l10n.pilgrimLabelPhone,
      ),
      StaffTableColumnOption(
        id: 'whatsapp',
        label: l10n.pilgrimLabelWhatsapp,
      ),
    ];
  }

  static List<StaffTableFilter> buildFilters(
    AppLocalizations l10n,
    List<PilgrimGroupOption> groups,
  ) {
    return [
      StaffTableFilter(
        id: 'gender',
        label: l10n.staffTableFilterGender,
        allLabel: l10n.staffTableFilterAll,
        options: [
          StaffTableFilterOption(
            value: 'male',
            label: l10n.pilgrimGenderMale,
          ),
          StaffTableFilterOption(
            value: 'female',
            label: l10n.pilgrimGenderFemale,
          ),
        ],
      ),
      StaffTableFilter(
        id: 'group_id',
        label: l10n.staffTableFilterGroup,
        allLabel: l10n.staffTableFilterAll,
        options: groups
            .map(
              (group) => StaffTableFilterOption(
                value: group.id,
                label: group.name,
              ),
            )
            .toList(),
      ),
    ];
  }

  static List<StaffTableColumn<OperatorPilgrimSummary>> buildColumns(
    AppLocalizations l10n,
  ) {
    return [
      StaffTableColumn(
        id: 'full_name',
        label: l10n.operatorFullName,
        flex: 3,
        minWidth: 240,
        sortable: true,
        cellBuilder: (context, item) {
          final colorScheme = Theme.of(context).colorScheme;
          return Row(
            children: [
              CircleAvatar(
                radius: sr(16),
                backgroundColor: colorScheme.primaryContainer,
                child: Text(
                  item.fullName.isNotEmpty
                      ? item.fullName[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(width: sw(10)),
              Expanded(
                child: StaffCellText(item.fullName, strong: true),
              ),
            ],
          );
        },
      ),
      StaffTableColumn(
        id: 'gender',
        label: l10n.staffTableFilterGender,
        minWidth: 110,
        sortable: true,
        cellBuilder: (context, item) =>
            StaffCellText(genderLabel(l10n, item.gender)),
      ),
      StaffTableColumn(
        id: 'group',
        label: l10n.staffTableFilterGroup,
        flex: 2,
        sortable: true,
        cellBuilder: (context, item) => StaffCellText(item.groupName),
      ),
      StaffTableColumn(
        id: 'passport',
        label: l10n.operatorPassport,
        flex: 2,
        sortable: true,
        cellBuilder: (context, item) => StaffCellText(item.passportNumber),
      ),
      StaffTableColumn(
        id: 'travel_permit',
        label: l10n.operatorTravelPermit,
        flex: 2,
        sortable: true,
        cellBuilder: (context, item) => StaffCellText(item.travelPermitNumber),
      ),
      StaffTableColumn(
        id: 'medical_test',
        label: l10n.pilgrimMedicalStatus,
        flex: 2,
        sortable: true,
        cellBuilder: (context, item) => StaffCellText(item.medicalTestStatus),
      ),
      StaffTableColumn(
        id: 'travel_date',
        label: l10n.pilgrimTravelDate,
        flex: 2,
        sortable: true,
        cellBuilder: (context, item) => StaffCellText(
          item.travelDate == null
              ? l10n.operatorPilgrimTravelDateUnset
              : MaterialLocalizations.of(context)
                  .formatMediumDate(item.travelDate!),
        ),
      ),
      StaffTableColumn(
        id: 'hotel',
        label: l10n.pilgrimHotel,
        flex: 2,
        minWidth: 190,
        sortable: true,
        cellBuilder: (context, item) => StaffCellText(item.hotelName),
      ),
      StaffTableColumn(
        id: 'cluster',
        label: l10n.pilgrimLabelCluster,
        flex: 2,
        sortable: true,
        cellBuilder: (context, item) => StaffCellText(item.cluster),
      ),
      StaffTableColumn(
        id: 'sticker',
        label: l10n.pilgrimLabelSticker,
        flex: 2,
        sortable: true,
        cellBuilder: (context, item) => StaffCellText(item.stickerNumber),
      ),
      StaffTableColumn(
        id: 'makkah_hotel',
        label: l10n.pilgrimLabelMakkahHotel,
        flex: 2,
        minWidth: 190,
        sortable: true,
        cellBuilder: (context, item) => StaffCellText(item.makkahHotel),
      ),
      StaffTableColumn(
        id: 'phone',
        label: l10n.pilgrimLabelPhone,
        flex: 2,
        sortable: true,
        cellBuilder: (context, item) => StaffCellText(item.phoneNumber),
      ),
      StaffTableColumn(
        id: 'whatsapp',
        label: l10n.pilgrimLabelWhatsapp,
        flex: 2,
        sortable: true,
        cellBuilder: (context, item) => StaffCellText(item.whatsappNumber),
      ),
    ];
  }

  static List<StaffTableColumn<OperatorPilgrimSummary>> visibleColumns(
    BuildContext context,
    AppLocalizations l10n,
    Set<String> hiddenColumnIds,
  ) {
    return filterVisibleStaffColumns<OperatorPilgrimSummary>(
      allColumns: buildColumns(l10n),
      hiddenColumnIds: hiddenColumnIds,
      essentialColumnIds: PilgrimTableColumns.essential,
    );
  }
}
