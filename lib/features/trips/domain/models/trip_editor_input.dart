import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_editor_input.freezed.dart';

/// Input payload for creating or updating a [Trip].
@freezed
abstract class TripEditorInput with _$TripEditorInput {
  const factory TripEditorInput({
    String? id,
    required String type,
    required int seasonYear,
    required String name,
    required String status,
    DateTime? startDate,
    DateTime? endDate,
  }) = _TripEditorInput;
}
