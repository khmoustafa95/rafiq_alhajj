import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/utils/field_status_l10n.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_status_filter_chip.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class FieldOperatorPilgrimStatusFilters extends StatelessWidget {
  const FieldOperatorPilgrimStatusFilters({
    required this.selectedStatus,
    required this.onFilterSelected,
    super.key,
  });

  final String? selectedStatus;
  final ValueChanged<String?> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          FieldOperatorStatusFilterChip(
            label: l10n.fieldOperatorFilterAll,
            selected: selectedStatus == null,
            onSelected: () => onFilterSelected(null),
          ),
          for (final status in FieldPilgrimStatus.values)
            FieldOperatorStatusFilterChip(
              label: fieldStatusLabel(l10n, status),
              selected: selectedStatus == status,
              onSelected: () => onFilterSelected(status),
            ),
        ],
      ),
    );
  }
}
