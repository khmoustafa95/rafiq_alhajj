import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_learning_progress_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Shows lesson completion progress for a topic on cards and detail headers.
class TopicLearningProgressBadge extends ConsumerWidget {
  const TopicLearningProgressBadge({
    required this.topic,
    super.key,
  });

  final ContentTopic topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final total = topic.media.length;
    if (total == 0) {
      return const SizedBox.shrink();
    }

    final progressAsync = ref.watch(myLearningProgressProvider);
    return progressAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (items) {
        final topicItems =
            items.where((p) => p.topicId == topic.id).toList(growable: false);
        if (topicItems.isEmpty) {
          return const SizedBox.shrink();
        }

        final completed =
            topicItems.where((p) => p.completed).map((p) => p.mediaId).toSet();
        final completedCount = completed.length;
        final hasInProgress = topicItems.any((p) => !p.completed);
        if (completedCount == 0 && !hasInProgress) {
          return const SizedBox.shrink();
        }

        final value = completedCount / total;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: value.clamp(0, 1),
                minHeight: 4.h,
                backgroundColor: AppColors.surfaceMuted,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              l10n.contentTopicLessonsProgress(completedCount, total),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        );
      },
    );
  }
}
