import 'dart:async';

import 'package:rafiq_alhajj/core/utils/file_export.dart';
import 'package:rafiq_alhajj/core/utils/tabular_codec.dart';
import 'package:rafiq_alhajj/features/operator_intake/application/services/pilgrim_export_service.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
import 'package:rafiq_alhajj/features/trips/presentation/providers/trips_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pilgrim_export_providers.g.dart';

/// Outcome of an export/template save: whether a file was produced, and (on
/// mobile/desktop) where it landed.
class PilgrimExportOutcome {
  const PilgrimExportOutcome({required this.savedPath, required this.empty});

  final String? savedPath;
  final bool empty;
}

/// Builds the workbook from the current trip's pilgrims and saves it via the
/// platform file helper.
@riverpod
class PilgrimExportController extends _$PilgrimExportController {
  @override
  FutureOr<void> build() {}

  Future<PilgrimExportOutcome?> exportPilgrims(AppLocalizations l10n) async {
    state = const AsyncLoading();
    PilgrimExportOutcome? outcome;
    state = await AsyncValue.guard(() async {
      final tripId = await ref.read(activeTripProvider.future);
      final pilgrims = await ref
          .read(operatorRegistryServiceProvider)
          .listPilgrims(tripId: tripId);
      if (pilgrims.isEmpty) {
        outcome = const PilgrimExportOutcome(savedPath: null, empty: true);
        return;
      }
      final rows = PilgrimExportService.buildRows(pilgrims, l10n);
      final bytes = TabularCodec.encodeXlsx(rows, sheetName: 'Pilgrims');
      final path = await FileExport.saveBytes(
        fileName: _fileName('pilgrims'),
        bytes: bytes,
        mimeType: TabularCodec.xlsxMimeType,
      );
      outcome = PilgrimExportOutcome(savedPath: path, empty: false);
    });
    return state.hasError ? null : outcome;
  }

  Future<PilgrimExportOutcome?> downloadTemplate(AppLocalizations l10n) async {
    state = const AsyncLoading();
    PilgrimExportOutcome? outcome;
    state = await AsyncValue.guard(() async {
      final rows = PilgrimExportService.templateRows(l10n);
      final bytes = TabularCodec.encodeXlsx(rows, sheetName: 'Template');
      final path = await FileExport.saveBytes(
        fileName: _fileName('pilgrims_template'),
        bytes: bytes,
        mimeType: TabularCodec.xlsxMimeType,
      );
      outcome = PilgrimExportOutcome(savedPath: path, empty: false);
    });
    return state.hasError ? null : outcome;
  }

  String _fileName(String base) {
    final today = DateTime.now().toIso8601String().split('T').first;
    return '${base}_$today.xlsx';
  }
}
