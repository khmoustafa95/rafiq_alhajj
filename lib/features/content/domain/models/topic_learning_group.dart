import 'package:rafiq_alhajj/features/content/domain/models/content_media_progress.dart';

/// Aggregated learning progress for a single educational topic.
class TopicLearningGroup {
  const TopicLearningGroup({
    required this.topicId,
    required this.topicTitle,
    required this.lessons,
  });

  final String topicId;
  final String topicTitle;
  final List<ContentMediaProgress> lessons;

  int get completedCount => lessons.where((lesson) => lesson.completed).length;

  int get lessonCount => lessons.length;

  DateTime get lastUpdated {
    return lessons
        .map((lesson) => lesson.updatedAt)
        .reduce((a, b) => a.isAfter(b) ? a : b);
  }

  ContentMediaProgress? get activeLesson {
    final open = lessons.where((lesson) => !lesson.completed).toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    if (open.isEmpty) {
      return null;
    }
    return open.first;
  }

  List<ContentMediaProgress> get completedLessons =>
      lessons.where((lesson) => lesson.completed).toList(growable: false);
}
