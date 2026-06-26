import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_import_models.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/forms/pilgrim_field_catalog.dart';
import 'package:rafiq_alhajj/l10n/app_localizations_ar.dart';
import 'package:rafiq_alhajj/l10n/app_localizations_en.dart';

/// Maps a raw tabular file (headers + rows) onto the pilgrim field catalog and
/// resolves each row's import action (create / update / error).
///
/// Pure logic: matches headers against catalog keys and both AR/EN labels,
/// coerces values per [PilgrimFieldKind], and detects validation problems.
abstract final class PilgrimImportParser {
  /// Synthetic field key for the optional login-email column.
  static const String emailField = 'email';

  /// Auto-maps detected [headers] to catalog field keys / [emailField].
  static List<PilgrimImportColumn> mapHeaders(List<String> headers) {
    final lookup = _headerLookup();
    return [
      for (var i = 0; i < headers.length; i++)
        PilgrimImportColumn(
          index: i,
          header: headers[i],
          fieldKey: lookup[_normalize(headers[i])],
        ),
    ];
  }

  /// Builds preview rows from the data [table] (header row included) using the
  /// resolved [columns]. [existingPassports] maps a normalized passport number
  /// to an existing pilgrim id (for create-vs-update); [existingNames] maps a
  /// pilgrim id to its display name.
  static PilgrimImportPreview buildPreview({
    required List<List<String>> table,
    required List<PilgrimImportColumn> columns,
    required Map<String, String> existingPassports,
    Map<String, String> existingNames = const {},
  }) {
    final fieldByKey = {for (final f in pilgrimFields) f.key: f};
    final seenPassports = <String>{};
    final rows = <PilgrimImportRow>[];

    for (var r = 1; r < table.length; r++) {
      final raw = table[r];
      if (_isEmptyRow(raw)) {
        continue;
      }

      final person = <String, dynamic>{};
      final enrollment = <String, dynamic>{};
      final issues = <PilgrimImportIssue>[];
      String? email;
      String? passport;
      String? fullNameAr;

      for (final col in columns) {
        final key = col.fieldKey;
        if (key == null) {
          continue;
        }
        final cell = col.index < raw.length ? raw[col.index].trim() : '';

        if (key == emailField) {
          if (cell.isNotEmpty) {
            email = cell;
          }
          continue;
        }

        final field = fieldByKey[key];
        if (field == null) {
          continue;
        }

        final coerced = _coerce(field, cell, col.header, issues);
        if (key == 'passport_number' && cell.isNotEmpty) {
          passport = cell;
        }
        if (key == 'full_name_ar') {
          fullNameAr = coerced as String?;
        }
        if (coerced == null) {
          continue;
        }
        if (field.table == PilgrimFieldTable.person) {
          person[key] = coerced;
        } else {
          enrollment[key] = coerced;
        }
      }

      final normPassport = passport?.toLowerCase() ?? '';
      if (normPassport.isNotEmpty && !seenPassports.add(normPassport)) {
        issues.add(
          const PilgrimImportIssue(
            PilgrimImportIssueLevel.error,
            PilgrimImportIssueCode.duplicatePassport,
          ),
        );
      }

      PilgrimImportAction action;
      String? existingId;
      String? existingName;

      if (issues.any((i) => i.level == PilgrimImportIssueLevel.error)) {
        action = PilgrimImportAction.error;
      } else if (normPassport.isNotEmpty &&
          existingPassports.containsKey(normPassport)) {
        action = PilgrimImportAction.update;
        existingId = existingPassports[normPassport];
        existingName = existingId == null ? null : existingNames[existingId];
      } else if (fullNameAr == null || fullNameAr.trim().isEmpty) {
        issues.add(
          const PilgrimImportIssue(
            PilgrimImportIssueLevel.error,
            PilgrimImportIssueCode.missingName,
          ),
        );
        action = PilgrimImportAction.error;
      } else {
        action = PilgrimImportAction.create;
      }

      rows.add(
        PilgrimImportRow(
          rowNumber: r,
          person: person,
          enrollment: enrollment,
          action: action,
          issues: issues,
          email: email,
          passportNumber: passport,
          fullNameAr: fullNameAr,
          existingPilgrimId: existingId,
          existingName: existingName,
        ),
      );
    }

    return PilgrimImportPreview(
      columns: columns,
      rows: rows,
      ignoredHeaders: [
        for (final c in columns)
          if (c.fieldKey == null && c.header.trim().isNotEmpty) c.header,
      ],
    );
  }

  // --- coercion ------------------------------------------------------------

  static dynamic _coerce(
    PilgrimField field,
    String cell,
    String header,
    List<PilgrimImportIssue> issues,
  ) {
    if (cell.isEmpty) {
      return null;
    }
    switch (field.kind) {
      case PilgrimFieldKind.boolean:
        final value = _parseBool(cell);
        if (value == null) {
          issues.add(
            PilgrimImportIssue(
              PilgrimImportIssueLevel.warning,
              PilgrimImportIssueCode.invalidBoolean,
              header,
            ),
          );
          return null;
        }
        return value;
      case PilgrimFieldKind.date:
        final iso = _parseDate(cell);
        if (iso == null) {
          issues.add(
            PilgrimImportIssue(
              PilgrimImportIssueLevel.warning,
              PilgrimImportIssueCode.invalidDate,
              header,
            ),
          );
          return null;
        }
        return iso;
      case PilgrimFieldKind.gender:
        final value = _parseGender(cell);
        if (value == null) {
          issues.add(
            PilgrimImportIssue(
              PilgrimImportIssueLevel.warning,
              PilgrimImportIssueCode.invalidGender,
              header,
            ),
          );
          return null;
        }
        return value;
      case PilgrimFieldKind.text:
      case PilgrimFieldKind.multiline:
      case PilgrimFieldKind.url:
      case PilgrimFieldKind.phone:
        return cell;
    }
  }

  static bool? _parseBool(String raw) {
    final value = raw.trim().toLowerCase();
    const truthy = {'true', '1', 'yes', 'y', 'نعم', 'صح', 'متوفر', 'true.'};
    const falsy = {'false', '0', 'no', 'n', 'لا', 'خطأ', 'غير متوفر'};
    if (truthy.contains(value)) {
      return true;
    }
    if (falsy.contains(value)) {
      return false;
    }
    return null;
  }

  static String? _parseGender(String raw) {
    final value = raw.trim().toLowerCase();
    const male = {'male', 'm', 'ذكر', 'رجل'};
    const female = {'female', 'f', 'أنثى', 'انثى', 'امرأة', 'مرأة'};
    if (male.contains(value)) {
      return 'male';
    }
    if (female.contains(value)) {
      return 'female';
    }
    return null;
  }

  /// Parses common date encodings into an ISO `yyyy-MM-dd` string.
  static String? _parseDate(String raw) {
    final value = raw.trim();
    if (value.isEmpty) {
      return null;
    }

    final iso = DateTime.tryParse(value);
    if (iso != null) {
      return _formatDate(iso.year, iso.month, iso.day);
    }

    final match = RegExp(r'^(\d{1,4})[\/\-.](\d{1,2})[\/\-.](\d{1,4})$')
        .firstMatch(value);
    if (match == null) {
      return null;
    }
    final a = int.parse(match.group(1)!);
    final b = int.parse(match.group(2)!);
    final c = int.parse(match.group(3)!);

    int year;
    int month;
    int day;
    if (match.group(1)!.length == 4) {
      // yyyy-MM-dd
      year = a;
      month = b;
      day = c;
    } else {
      // dd/MM/yyyy (the regional default here)
      day = a;
      month = b;
      year = c < 100 ? 2000 + c : c;
    }
    if (month < 1 || month > 12 || day < 1 || day > 31) {
      return null;
    }
    return _formatDate(year, month, day);
  }

  static String _formatDate(int year, int month, int day) =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';

  // --- header matching -----------------------------------------------------

  static Map<String, String> _headerLookup() {
    final ar = AppLocalizationsAr();
    final en = AppLocalizationsEn();
    final map = <String, String>{};

    void put(String? raw, String key) {
      if (raw == null) {
        return;
      }
      final normalized = _normalize(raw);
      if (normalized.isNotEmpty) {
        map.putIfAbsent(normalized, () => key);
      }
    }

    for (final field in pilgrimFields) {
      put(field.key, field.key);
      put(field.label(ar), field.key);
      put(field.label(en), field.key);
    }

    for (final synonym in const [
      'email',
      'e-mail',
      'mail',
      'البريد الالكتروني',
      'البريد الإلكتروني',
      'الايميل',
      'الإيميل',
      'بريد',
    ]) {
      put(synonym, emailField);
    }

    return map;
  }

  static String _normalize(String raw) {
    return raw
        .trim()
        .toLowerCase()
        .replaceAll('*', '')
        .replaceAll(':', '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static bool _isEmptyRow(List<String> row) =>
      row.every((cell) => cell.trim().isEmpty);
}
