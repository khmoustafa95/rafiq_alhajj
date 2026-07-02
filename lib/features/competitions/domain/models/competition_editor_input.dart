import 'package:freezed_annotation/freezed_annotation.dart';

part 'competition_editor_input.freezed.dart';

@freezed
abstract class CompetitionEditorInput with _$CompetitionEditorInput {
  const factory CompetitionEditorInput({
    String? id,
    required String title,
    String? description,
    required DateTime startsAt,
    required DateTime endsAt,
    required bool isActive,
  }) = _CompetitionEditorInput;

  const CompetitionEditorInput._();

  Map<String, dynamic> toDatabasePayload() {
    return {
      'title': title.trim(),
      'description': _emptyToNull(description),
      'starts_at': startsAt.toUtc().toIso8601String(),
      'ends_at': endsAt.toUtc().toIso8601String(),
      'is_active': isActive,
    };
  }

  static String? _emptyToNull(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}
