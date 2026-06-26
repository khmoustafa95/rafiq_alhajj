import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_import_models.dart';

part 'pilgrim_import_state.freezed.dart';

/// The step the import wizard is currently on.
enum PilgrimImportStage { idle, mapping, committing, done }

@freezed
abstract class PilgrimImportState with _$PilgrimImportState {
  const factory PilgrimImportState({
    @Default(PilgrimImportStage.idle) PilgrimImportStage stage,
    String? fileName,
    @Default(<List<String>>[]) List<List<String>> table,
    PilgrimImportPreview? preview,
    PilgrimImportResult? result,
    String? error,
    @Default(false) bool busy,
  }) = _PilgrimImportState;
}
