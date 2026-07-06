import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_media.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';

/// JSON codec for offline catalog snapshots (feed, articles, topics, journey).
abstract final class ContentCatalogCodec {
  static Map<String, dynamic> feedToJson(PublicContentFeed feed) => {
        'announcements': feed.announcements.map(itemToJson).toList(),
        'news': feed.news.map(itemToJson).toList(),
        'topics': feed.topics.map(topicToJson).toList(),
        'cachedAt': DateTime.now().toIso8601String(),
      };

  static PublicContentFeed? feedFromJson(Map<String, dynamic> json) {
    try {
      return PublicContentFeed(
        announcements: _itemsFromJson(json['announcements']),
        news: _itemsFromJson(json['news']),
        topics: _topicsFromJson(json['topics']),
      );
    } catch (_) {
      return null;
    }
  }

  static Map<String, dynamic> itemToJson(ContentItem item) => {
        'id': item.id,
        'title': item.title,
        'description': item.description,
        'mediaUrl': item.mediaUrl,
        'type': item.type.databaseValue,
        'visibility': item.visibility.databaseValue,
        'createdAt': item.createdAt.toIso8601String(),
      };

  static ContentItem? itemFromJson(Map<String, dynamic> json) {
    try {
      return ContentItem(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String?,
        mediaUrl: json['mediaUrl'] as String?,
        type: ContentType.fromDatabase(json['type'] as String),
        visibility: ContentVisibility.fromDatabase(
          json['visibility'] as String,
        ),
        createdAt: DateTime.parse(json['createdAt'] as String),
      );
    } catch (_) {
      return null;
    }
  }

  static Map<String, dynamic> topicToJson(ContentTopic topic) => {
        'id': topic.id,
        'title': topic.title,
        'description': topic.description,
        'coverImageUrl': topic.coverImageUrl,
        'visibility': topic.visibility.databaseValue,
        'sortOrder': topic.sortOrder,
        'isActive': topic.isActive,
        'createdAt': topic.createdAt.toIso8601String(),
        'media': topic.media.map(mediaToJson).toList(),
      };

  static ContentTopic? topicFromJson(Map<String, dynamic> json) {
    try {
      final mediaRows = json['media'] as List<dynamic>? ?? [];
      return ContentTopic(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String?,
        coverImageUrl: json['coverImageUrl'] as String?,
        visibility: ContentVisibility.fromDatabase(
          json['visibility'] as String,
        ),
        sortOrder: json['sortOrder'] as int? ?? 0,
        isActive: json['isActive'] as bool? ?? true,
        createdAt: DateTime.parse(json['createdAt'] as String),
        media: mediaRows
            .map((m) => mediaFromJson(Map<String, dynamic>.from(m as Map)))
            .whereType<ContentTopicMedia>()
            .toList(),
      );
    } catch (_) {
      return null;
    }
  }

  static Map<String, dynamic> mediaToJson(ContentTopicMedia media) => {
        'id': media.id,
        'mediaType': media.mediaType.name,
        'title': media.title,
        'url': media.url,
        'sortOrder': media.sortOrder,
      };

  static ContentTopicMedia? mediaFromJson(Map<String, dynamic> json) {
    try {
      return ContentTopicMedia(
        id: json['id'] as String,
        mediaType: EducationalMediaType.typeFromKey(
          json['mediaType'] as String,
        ),
        title: json['title'] as String?,
        url: json['url'] as String,
        sortOrder: json['sortOrder'] as int? ?? 0,
      );
    } catch (_) {
      return null;
    }
  }

  static Map<String, dynamic> journeyStepToJson(HajjJourneyStep step) => {
        'id': step.id,
        'ritualKey': step.ritualKey,
        'sortOrder': step.sortOrder,
        'titleAr': step.titleAr,
        'titleEn': step.titleEn,
        'descriptionAr': step.descriptionAr,
        'descriptionEn': step.descriptionEn,
        'isActive': step.isActive,
        'media': step.media.map(journeyMediaToJson).toList(),
      };

  static HajjJourneyStep? journeyStepFromJson(Map<String, dynamic> json) {
    try {
      final mediaRows = json['media'] as List<dynamic>? ?? [];
      return HajjJourneyStep(
        id: json['id'] as String,
        ritualKey: json['ritualKey'] as String,
        sortOrder: json['sortOrder'] as int? ?? 0,
        titleAr: json['titleAr'] as String,
        titleEn: json['titleEn'] as String,
        descriptionAr: json['descriptionAr'] as String,
        descriptionEn: json['descriptionEn'] as String,
        isActive: json['isActive'] as bool? ?? true,
        media: mediaRows
            .map(
              (m) => journeyMediaFromJson(
                Map<String, dynamic>.from(m as Map),
              ),
            )
            .whereType<HajjJourneyMedia>()
            .toList(),
      );
    } catch (_) {
      return null;
    }
  }

  static Map<String, dynamic> journeyMediaToJson(HajjJourneyMedia media) =>
      {
        'id': media.id,
        'mediaType': media.mediaTypeKey,
        'title': media.title,
        'url': media.url,
        'sortOrder': media.sortOrder,
      };

  static HajjJourneyMedia? journeyMediaFromJson(Map<String, dynamic> json) {
    try {
      return HajjJourneyMedia(
        id: json['id'] as String,
        mediaType: HajjJourneyMedia.mediaTypeFromString(
          json['mediaType'] as String,
        ),
        title: json['title'] as String?,
        url: json['url'] as String,
        sortOrder: json['sortOrder'] as int? ?? 0,
      );
    } catch (_) {
      return null;
    }
  }

  static Map<String, dynamic> quizProgressToJson(
    CompetitionQuizProgress progress,
  ) =>
      {
        'questions': progress.questions.map(questionToJson).toList(),
        'answeredQuestionIds': progress.answeredQuestionIds.toList(),
        'cachedAt': DateTime.now().toIso8601String(),
      };

  static CompetitionQuizProgress? quizProgressFromJson(
    Map<String, dynamic> json,
  ) {
    try {
      final questionRows = json['questions'] as List<dynamic>? ?? [];
      final answered = json['answeredQuestionIds'] as List<dynamic>? ?? [];
      return CompetitionQuizProgress(
        questions: questionRows
            .map(
              (q) => questionFromJson(Map<String, dynamic>.from(q as Map)),
            )
            .whereType<CompetitionQuestion>()
            .toList(),
        answeredQuestionIds: answered.map((id) => id as String).toSet(),
      );
    } catch (_) {
      return null;
    }
  }

  static Map<String, dynamic> competitionToJson(Competition competition) => {
        'id': competition.id,
        'title': competition.title,
        'description': competition.description,
        'startsAt': competition.startsAt.toIso8601String(),
        'endsAt': competition.endsAt.toIso8601String(),
        'isActive': competition.isActive,
      };

  static Competition? competitionFromJson(Map<String, dynamic> json) {
    try {
      return Competition(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String?,
        startsAt: DateTime.parse(json['startsAt'] as String),
        endsAt: DateTime.parse(json['endsAt'] as String),
        isActive: json['isActive'] as bool? ?? false,
      );
    } catch (_) {
      return null;
    }
  }

  static List<Competition> competitionsFromJsonList(List<dynamic> raw) {
    return raw
        .map((e) => competitionFromJson(Map<String, dynamic>.from(e as Map)))
        .whereType<Competition>()
        .toList();
  }

  static Map<String, dynamic> questionToJson(CompetitionQuestion question) =>
      {
        'id': question.id,
        'competitionId': question.competitionId,
        'sortOrder': question.sortOrder,
        'questionType': question.questionType.toDatabase(),
        'prompt': question.prompt,
        'explanation': question.explanation,
        'points': question.points,
        'options': question.options
            .map(
              (o) => {
                'id': o.id,
                'questionId': o.questionId,
                'sortOrder': o.sortOrder,
                'label': o.label,
                'isCorrect': o.isCorrect,
              },
            )
            .toList(),
      };

  static CompetitionQuestion? questionFromJson(Map<String, dynamic> json) {
    try {
      final optionRows = json['options'] as List<dynamic>? ?? [];
      return CompetitionQuestion(
        id: json['id'] as String,
        competitionId: json['competitionId'] as String,
        sortOrder: json['sortOrder'] as int? ?? 0,
        questionType: CompetitionQuestionType.fromDatabase(
          json['questionType'] as String,
        ),
        prompt: json['prompt'] as String,
        explanation: json['explanation'] as String?,
        points: json['points'] as int? ?? 0,
        options: optionRows
            .map((o) {
              final map = Map<String, dynamic>.from(o as Map);
              return CompetitionQuestionOption(
                id: map['id'] as String,
                questionId: map['questionId'] as String,
                sortOrder: map['sortOrder'] as int? ?? 0,
                label: map['label'] as String,
                isCorrect: map['isCorrect'] as bool? ?? false,
              );
            })
            .toList(),
      );
    } catch (_) {
      return null;
    }
  }

  static List<ContentItem> _itemsFromJson(dynamic raw) {
    if (raw is! List<dynamic>) {
      return const [];
    }
    return raw
        .map((e) => itemFromJson(Map<String, dynamic>.from(e as Map)))
        .whereType<ContentItem>()
        .toList();
  }

  static List<ContentTopic> _topicsFromJson(dynamic raw) {
    if (raw is! List<dynamic>) {
      return const [];
    }
    return raw
        .map((e) => topicFromJson(Map<String, dynamic>.from(e as Map)))
        .whereType<ContentTopic>()
        .toList();
  }
}
