import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';

/// Payload for creating or updating [content_library] rows (admin CMS).
class ContentEditorInput {
  const ContentEditorInput({
    this.id,
    required this.title,
    this.description,
    this.mediaUrl,
    required this.type,
    required this.visibility,
  });

  final String? id;
  final String title;
  final String? description;
  final String? mediaUrl;
  final ContentType type;
  final ContentVisibility visibility;

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
