import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_media_progress.dart';
import 'package:rafiq_alhajj/features/content/domain/models/topic_learning_group.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_learning_progress_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/my_learning_summary_card.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class ContentMyLearningScreen extends ConsumerWidget {
  const ContentMyLearningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final groupsAsync = ref.watch(myLearningGroupedProvider);

    return Scaffold(
      appBar: RafiqAppBar(title: Text(l10n.contentMyLearningTitle)),
      body: groupsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.contentLoadError)),
        data: (groups) {
          if (groups.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Text(
                  l10n.contentMyLearningEmpty,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),
            );
          }

          final inProgressCount = groups
              .expand((group) => group.lessons)
              .where((lesson) => !lesson.completed)
              .length;
          final completedCount = groups
              .expand((group) => group.lessons)
              .where((lesson) => lesson.completed)
              .length;

          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              MyLearningSummaryCard(
                inProgressCount: inProgressCount,
                completedCount: completedCount,
              ),
              SizedBox(height: 16.h),
              for (final group in groups) ...[
                _TopicGroupCard(group: group),
                SizedBox(height: 12.h),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _TopicGroupCard extends StatelessWidget {
  const _TopicGroupCard({required this.group});

  final TopicLearningGroup group;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final activeLesson = group.activeLesson;
    final progressValue = group.lessonCount == 0
        ? 0.0
        : group.completedCount / group.lessonCount;

    return DecoratedBox(
      decoration: AppDecorations.card(),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              group.topicTitle,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            SizedBox(height: 8.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: progressValue.clamp(0, 1),
                minHeight: 4.h,
                backgroundColor: AppColors.surfaceMuted,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              l10n.contentTopicLessonsProgress(
                group.completedCount,
                group.lessonCount,
              ),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            if (activeLesson != null) ...[
              SizedBox(height: 12.h),
              _LessonResumeRow(progress: activeLesson),
            ],
            SizedBox(height: 12.h),
            FilledButton.icon(
              onPressed: () {
                final target = activeLesson ?? group.lessons.first;
                final uri = Uri(
                  path: AppRoutes.contentTopicDetailPath(group.topicId),
                  queryParameters: {
                    if (!target.completed) 'mediaId': target.mediaId,
                    if (!target.completed && target.positionMs > 0)
                      'positionMs': '${target.positionMs}',
                  },
                );
                unawaited(context.push(uri.toString()));
              },
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(l10n.contentMyLearningContinueTopic),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonResumeRow extends StatelessWidget {
  const _LessonResumeRow({required this.progress});

  final ContentMediaProgress progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final subtitle = progress.mediaTitle ?? progress.topicTitle;

    return Material(
      color: AppColors.primary.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
        leading: Icon(
          Icons.play_lesson_outlined,
          color: AppColors.primary,
          size: 22.sp,
        ),
        title: Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          progress.positionMs > 0
              ? l10n.contentContinueLearningResume
              : l10n.contentLessonInProgress,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: () {
          final uri = Uri(
            path: AppRoutes.contentTopicDetailPath(progress.topicId),
            queryParameters: {
              'mediaId': progress.mediaId,
              if (progress.positionMs > 0)
                'positionMs': '${progress.positionMs}',
            },
          );
          unawaited(context.push(uri.toString()));
        },
      ),
    );
  }
}
