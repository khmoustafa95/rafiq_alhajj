import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';

part 'content_editor_input.freezed.dart';

/// Payload for creating or updating [content_library] rows (admin CMS).
@freezed
abstract class ContentEditorInput with _$ContentEditorInput {
  const factory ContentEditorInput({
    String? id,
    required String title,
    String? description,
    String? mediaUrl,
    required ContentType type,
    required ContentVisibility visibility,
  }) = _ContentEditorInput;

  const ContentEditorInput._();

  Map<String, dynamic> toDatabasePayload() {
    return {
      'title': title.trim(),
      'description': _emptyToNull(description),
      'media_url': _emptyToNull(mediaUrl),
      'type': type.databaseValue,
      'visibility': visibility.databaseValue,
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
