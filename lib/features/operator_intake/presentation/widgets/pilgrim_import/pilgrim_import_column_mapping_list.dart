import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_import_models.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/forms/pilgrim_field_catalog.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class PilgrimImportColumnMappingList extends StatelessWidget {
  const PilgrimImportColumnMappingList({
    required this.columns,
    required this.enabled,
    required this.onChanged,
    super.key,
  });

  final List<PilgrimImportColumn> columns;
  final bool enabled;
  final void Function(int index, String? fieldKey) onChanged;

  static const String ignoreValue = '__ignore__';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = _fieldMenuItems(l10n);

    return Column(
      children: [
        for (final column in columns)
          Padding(
            padding: EdgeInsets.only(bottom: sh(10)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    column.header.trim().isEmpty ? '—' : column.header,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.arrow_right_alt,
                  size: ss(18),
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: sw(8)),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: column.fieldKey ?? ignoreValue,
                    decoration: const InputDecoration(isDense: true),
                    items: items,
                    onChanged: enabled
                        ? (value) => onChanged(
                              column.index,
                              value == ignoreValue ? null : value,
                            )
                        : null,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _fieldMenuItems(AppLocalizations l10n) {
    return [
      DropdownMenuItem(value: ignoreValue, child: Text(l10n.importColumnIgnore)),
      DropdownMenuItem(value: 'email', child: Text(l10n.importEmailColumnLabel)),
      for (final field in pilgrimFields)
        DropdownMenuItem(value: field.key, child: Text(field.label(l10n))),
    ];
  }
}
