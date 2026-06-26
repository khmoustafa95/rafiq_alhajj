import 'package:file_picker/file_picker.dart';
import 'package:rafiq_alhajj/core/utils/tabular_codec.dart';
import 'package:rafiq_alhajj/features/operator_intake/application/services/pilgrim_import_parser.dart';
import 'package:rafiq_alhajj/features/operator_intake/application/services/pilgrim_intake_service.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_import_models.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_intake_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/states/pilgrim_import_state.dart';
import 'package:rafiq_alhajj/features/trips/presentation/providers/trips_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pilgrim_import_providers.g.dart';

/// Drives the import wizard: pick -> map columns -> preview -> commit.
@riverpod
class PilgrimImportController extends _$PilgrimImportController {
  @override
  PilgrimImportState build() => const PilgrimImportState();

  /// Opens the file picker (xlsx/csv), parses it, and produces an initial
  /// auto-mapped preview.
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: const ['xlsx', 'csv'],
    );
    if (result == null || result.files.isEmpty) {
      return;
    }
    final file = result.files.first;
    final bytes = file.bytes;
    if (bytes == null) {
      state = state.copyWith(error: 'empty');
      return;
    }

    state = state.copyWith(busy: true, error: null);
    try {
      final table = TabularCodec.decode(
        bytes,
        extension: file.extension ?? 'csv',
      );
      if (table.isEmpty || table.first.isEmpty) {
        state = const PilgrimImportState().copyWith(error: 'empty');
        return;
      }
      final columns = PilgrimImportParser.mapHeaders(table.first);
      final preview = await _buildPreview(table, columns);
      state = PilgrimImportState(
        stage: PilgrimImportStage.mapping,
        fileName: file.name,
        table: table,
        preview: preview,
      );
    } on Object catch (e) {
      state = state.copyWith(busy: false, error: e.toString());
    }
  }

  /// Re-maps a single column to [fieldKey] (or `null` to ignore it) and
  /// recomputes the preview.
  Future<void> setColumnField(int index, String? fieldKey) async {
    final preview = state.preview;
    if (preview == null) {
      return;
    }
    final columns = [
      for (final column in preview.columns)
        column.index == index ? column.withField(fieldKey) : column,
    ];
    state = state.copyWith(busy: true);
    final next = await _buildPreview(state.table, columns);
    state = state.copyWith(busy: false, preview: next);
  }

  /// Sends the importable (non-error) rows to the edge function.
  Future<void> commit() async {
    final preview = state.preview;
    if (preview == null || preview.importableCount == 0) {
      return;
    }
    state = state.copyWith(stage: PilgrimImportStage.committing, busy: true, error: null);
    try {
      final tripId = await ref.read(activeTripProvider.future);
      final rows = <Map<String, dynamic>>[
        for (final row in preview.rows)
          if (!row.hasError)
            {
              if (row.passportNumber != null)
                'passport_number': row.passportNumber,
              if (row.email != null) 'email': row.email,
              'person': row.person,
              'enrollment': row.enrollment,
            },
      ];
      final result = await ref.read(pilgrimIntakeServiceProvider).importPilgrims(
            rows: rows,
            tripId: tripId,
          );
      ref.invalidate(operatorPilgrimRegistryPageProvider);
      state = state.copyWith(
        busy: false,
        stage: PilgrimImportStage.done,
        result: result,
      );
    } on PilgrimIntakeException catch (e) {
      state = state.copyWith(
        busy: false,
        stage: PilgrimImportStage.mapping,
        error: e.message,
      );
    }
  }

  /// Clears all state to restart the wizard.
  void reset() => state = const PilgrimImportState();

  Future<PilgrimImportPreview> _buildPreview(
    List<List<String>> table,
    List<PilgrimImportColumn> columns,
  ) async {
    final tripId = await ref.read(activeTripProvider.future);
    final existing = await ref
        .read(operatorRegistryServiceProvider)
        .listPilgrims(tripId: tripId);

    final passports = <String, String>{};
    final names = <String, String>{};
    for (final pilgrim in existing) {
      final passport = pilgrim.passportNumber?.trim().toLowerCase();
      if (passport != null && passport.isNotEmpty) {
        passports[passport] = pilgrim.pilgrimId;
      }
      names[pilgrim.pilgrimId] = pilgrim.fullName;
    }

    return PilgrimImportParser.buildPreview(
      table: table,
      columns: columns,
      existingPassports: passports,
      existingNames: names,
    );
  }
}
