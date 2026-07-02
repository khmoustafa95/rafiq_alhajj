import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_media_progress_cache.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_media_progress.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_learning_progress_providers.g.dart';

@riverpod
Future<ContentMediaProgress?> continueLearningProgress(Ref ref) async {
  final profileId = ref.watch(authProfileIdProvider);
  if (profileId == null) {
    return null;
  }
  return ContentMediaProgressCache.readLatest(profileId);
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

    await ContentMediaProgressCache.save(
      profileId,
      ContentMediaProgress(
        topicId: topicId,
        mediaId: mediaId,
        topicTitle: topicTitle,
        mediaTitle: mediaTitle,
        positionMs: positionMs,
        completed: completed,
        updatedAt: DateTime.now(),
      ),
    );
    ref.invalidate(continueLearningProgressProvider);
  }
}
