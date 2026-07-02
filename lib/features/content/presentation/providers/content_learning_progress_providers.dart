import 'dart:async';

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/application/services/content_learning_progress_sync_service.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_media_progress_cache.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/content_learning_progress_repository.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_media_progress.dart';
import 'package:rafiq_alhajj/features/content/domain/models/topic_learning_group.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'content_learning_progress_providers.g.dart';

@Riverpod(keepAlive: true)
ContentLearningProgressRepository contentLearningProgressRepository(Ref ref) {
  return ContentLearningProgressRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
ContentLearningProgressSyncService contentLearningProgressSyncService(Ref ref) {
  return ContentLearningProgressSyncService(
    ref.watch(contentLearningProgressRepositoryProvider),
  );
}

@riverpod
Future<ContentMediaProgress?> continueLearningProgress(Ref ref) async {
  final profileId = ref.watch(authProfileIdProvider);
  if (profileId == null) {
    return null;
  }
  return ContentMediaProgressCache.readLatest(profileId);
}

@riverpod
Future<List<ContentMediaProgress>> myLearningProgress(Ref ref) async {
  final profileId = ref.watch(authProfileIdProvider);
  if (profileId == null) {
    return [];
  }

  final sync = ref.watch(contentLearningProgressSyncServiceProvider);
  await sync.pullAndMerge(profileId);
  final items = await sync.listAll(profileId);
  items.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  return items;
}

@riverpod
Future<List<TopicLearningGroup>> myLearningGrouped(Ref ref) async {
  final items = await ref.watch(myLearningProgressProvider.future);
  final grouped = <String, TopicLearningGroup>{};

  for (final progress in items) {
    final existing = grouped[progress.topicId];
    if (existing == null) {
      grouped[progress.topicId] = TopicLearningGroup(
        topicId: progress.topicId,
        topicTitle: progress.topicTitle,
        lessons: [progress],
      );
    } else {
      grouped[progress.topicId] = TopicLearningGroup(
        topicId: existing.topicId,
        topicTitle: existing.topicTitle,
        lessons: [...existing.lessons, progress],
      );
    }
  }

  final groups = grouped.values.toList()
    ..sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
  return groups;
}

@riverpod
Future<int?> mediaResumePositionMs(Ref ref, String mediaId) async {
  final profileId = ref.watch(authProfileIdProvider);
  if (profileId == null) {
    return null;
  }
  final progress =
      await ContentMediaProgressCache.readForMedia(profileId, mediaId);
  if (progress == null || progress.positionMs <= 0) {
    return null;
  }
  return progress.positionMs;
}

@Riverpod(keepAlive: true)
class ContentLearningProgressRecorder extends _$ContentLearningProgressRecorder {
  @override
  FutureOr<void> build() {}

  Future<void> record({
    required String topicId,
    required String mediaId,
    required String topicTitle,
    String? mediaTitle,
    int positionMs = 0,
    bool completed = false,
  }) async {
    final profileId = ref.read(authProfileIdProvider);
    if (profileId == null) {
      return;
    }

    final progress = ContentMediaProgress(
      topicId: topicId,
      mediaId: mediaId,
      topicTitle: topicTitle,
      mediaTitle: mediaTitle,
      positionMs: positionMs,
      completed: completed,
      updatedAt: DateTime.now(),
    );

    await ContentMediaProgressCache.save(profileId, progress);
    await ref
        .read(contentLearningProgressSyncServiceProvider)
        .pushLocal(profileId, progress);

    ref.invalidate(continueLearningProgressProvider);
    ref.invalidate(myLearningProgressProvider);
    ref.invalidate(myLearningGroupedProvider);
  }
}

@Riverpod(keepAlive: true)
class ContentLearningProgressBootstrap extends _$ContentLearningProgressBootstrap {
  @override
  FutureOr<void> build() {
    final profileId = ref.watch(authProfileIdProvider);
    if (profileId != null) {
      unawaited(
        ref.read(contentLearningProgressSyncServiceProvider).pullAndMerge(
              profileId,
            ),
      );
    }
  }
}
