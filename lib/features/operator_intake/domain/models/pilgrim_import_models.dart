/// Domain models for the pilgrim Excel/CSV import flow (parse -> preview ->
/// commit). Kept free of Flutter/context dependencies; issue codes are
/// localized in the presentation layer.
library;

/// What will happen to a parsed row once committed.
enum PilgrimImportAction { create, update, error }

/// Severity of a parsed-row issue.
enum PilgrimImportIssueLevel { error, warning }

/// A machine code for a parsed-row issue (localized in the UI).
enum PilgrimImportIssueCode {
  missingName,
  invalidDate,
  invalidGender,
  invalidBoolean,
  duplicatePassport,
}

/// A detected source column and the catalog field (or `email`) it maps to.
class PilgrimImportColumn {
  const PilgrimImportColumn({
    required this.index,
    required this.header,
    this.fieldKey,
  });

  /// Zero-based column index in the source table.
  final int index;

  /// The raw header text from the file.
  final String header;

  /// Catalog field key (== DB column), the special [PilgrimImportParser.emailField],
  /// or `null` when the column is ignored.
  final String? fieldKey;

  PilgrimImportColumn withField(String? key) => PilgrimImportColumn(
        index: index,
        header: header,
        fieldKey: key,
      );
}

/// A localized-later validation issue attached to a parsed row.
class PilgrimImportIssue {
  const PilgrimImportIssue(this.level, this.code, [this.detail]);

  final PilgrimImportIssueLevel level;
  final PilgrimImportIssueCode code;

  /// Optional extra context (e.g. the offending header label).
  final String? detail;
}

/// One parsed source row, ready to preview and commit.
class PilgrimImportRow {
  const PilgrimImportRow({
    required this.rowNumber,
    required this.person,
    required this.enrollment,
    required this.action,
    required this.issues,
    this.email,
    this.passportNumber,
    this.fullNameAr,
    this.existingPilgrimId,
    this.existingName,
  });

  /// 1-based source row number (data rows, header excluded) for messages.
  final int rowNumber;
  final Map<String, dynamic> person;
  final Map<String, dynamic> enrollment;
  final PilgrimImportAction action;
  final List<PilgrimImportIssue> issues;
  final String? email;
  final String? passportNumber;
  final String? fullNameAr;

  /// Set when [action] is [PilgrimImportAction.update].
  final String? existingPilgrimId;
  final String? existingName;

  bool get hasError => action == PilgrimImportAction.error;

  String get displayName =>
      (fullNameAr?.trim().isNotEmpty ?? false) ? fullNameAr!.trim() : (existingName ?? '—');
}

/// The full parsed preview returned by the parser.
class PilgrimImportPreview {
  const PilgrimImportPreview({
    required this.columns,
    required this.rows,
    required this.ignoredHeaders,
  });

  final List<PilgrimImportColumn> columns;
  final List<PilgrimImportRow> rows;
  final List<String> ignoredHeaders;

  int get createCount =>
      rows.where((r) => r.action == PilgrimImportAction.create).length;
  int get updateCount =>
      rows.where((r) => r.action == PilgrimImportAction.update).length;
  int get errorCount =>
      rows.where((r) => r.action == PilgrimImportAction.error).length;
  int get importableCount => createCount + updateCount;

  bool get hasMappedColumns => columns.any((c) => c.fieldKey != null);
}

/// Per-row outcome returned by the import edge function.
class PilgrimImportResult {
  const PilgrimImportResult({
    required this.created,
    required this.updated,
    required this.failed,
    required this.errors,
  });

  final int created;
  final int updated;
  final int failed;

  /// Human-readable per-row error strings from the server (best-effort).
  final List<String> errors;

  int get total => created + updated + failed;
}
