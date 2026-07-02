class ContentMediaProgress {
  const ContentMediaProgress({
    required this.topicId,
    required this.mediaId,
    required this.topicTitle,
    this.mediaTitle,
    this.positionMs = 0,
    this.completed = false,
    required this.updatedAt,
  });

  final String topicId;
  final String mediaId;
  final String topicTitle;
  final String? mediaTitle;
  final int positionMs;
  final bool completed;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
        'topicId': topicId,
        'mediaId': mediaId,
        'topicTitle': topicTitle,
        'mediaTitle': mediaTitle,
        'positionMs': positionMs,
        'completed': completed,
        'updatedAt': updatedAt.toIso8601String(),
      };

  static ContentMediaProgress? fromJson(Map<String, dynamic> json) {
    try {
      return ContentMediaProgress(
        topicId: json['topicId'] as String,
        mediaId: json['mediaId'] as String,
        topicTitle: json['topicTitle'] as String,
        mediaTitle: json['mediaTitle'] as String?,
        positionMs: json['positionMs'] as int? ?? 0,
        completed: json['completed'] as bool? ?? false,
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );
    } catch (_) {
      return null;
    }
  }

  ContentMediaProgress copyWith({
    int? positionMs,
    bool? completed,
    DateTime? updatedAt,
  }) {
    return ContentMediaProgress(
      topicId: topicId,
      mediaId: mediaId,
      topicTitle: topicTitle,
      mediaTitle: mediaTitle,
      positionMs: positionMs ?? this.positionMs,
      completed: completed ?? this.completed,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
