class CompetitionEditorInput {
  const CompetitionEditorInput({
    this.id,
    required this.title,
    this.description,
    required this.startsAt,
    required this.endsAt,
    required this.isActive,
  });

  final String? id;
  final String title;
  final String? description;
  final DateTime startsAt;
  final DateTime endsAt;
  final bool isActive;

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
