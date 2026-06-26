import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/forms/pilgrim_field_catalog.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Builds tabular rows (header + data) for export and template downloads,
/// straight from the pilgrim field catalog so columns always match the
/// intake/edit forms and the importer.
abstract final class PilgrimExportService {
  /// Header row of localized catalog labels.
  static List<String> header(AppLocalizations l10n) =>
      [for (final field in pilgrimFields) field.label(l10n)];

  /// A headers-only template the operator can fill in and re-import.
  static List<List<String>> templateRows(AppLocalizations l10n) =>
      [header(l10n)];

  /// Full export: header followed by one row per pilgrim. Values are emitted in
  /// the same normalized form the importer accepts (clean round-trip).
  static List<List<String>> buildRows(
    List<OperatorPilgrimSummary> pilgrims,
    AppLocalizations l10n,
  ) {
    final fields = pilgrimFields;
    return [
      header(l10n),
      for (final pilgrim in pilgrims)
        [for (final field in fields) _format(pilgrim.raw[field.key], field.kind)],
    ];
  }

  static String _format(dynamic value, PilgrimFieldKind kind) {
    if (value == null) {
      return '';
    }
    switch (kind) {
      case PilgrimFieldKind.boolean:
        return value == true ? 'true' : 'false';
      case PilgrimFieldKind.date:
        final date = DateTime.tryParse(value.toString());
        if (date == null) {
          return value.toString();
        }
        return '${date.year.toString().padLeft(4, '0')}-'
            '${date.month.toString().padLeft(2, '0')}-'
            '${date.day.toString().padLeft(2, '0')}';
      case PilgrimFieldKind.text:
      case PilgrimFieldKind.multiline:
      case PilgrimFieldKind.url:
      case PilgrimFieldKind.phone:
      case PilgrimFieldKind.gender:
        return value.toString();
    }
  }
}
