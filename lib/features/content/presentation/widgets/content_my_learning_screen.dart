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
import 'package:rafiq_alhajj/features/content/presentation/providers/content_learning_progress_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class ContentMyLearningScreen extends ConsumerWidget {
  const ContentMyLearningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final progressAsync = ref.watch(myLearningProgressProvider);

    return Scaffold(
      appBar: RafiqAppBar(title: Text(l10n.contentMyLearningTitle)),
      body: progressAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.contentLoadError)),
        data: (items) {
          if (items.isEmpty) {
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

          final inProgress =
              items.where((p) => !p.completed).toList(growable: false);
          final completed =
              items.where((p) => p.completed).toList(growable: false);

          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              if (inProgress.isNotEmpty) ...[
                _SectionHeader(title: l10n.contentMyLearningInProgress),
                ...inProgress.map(
                  (p) => _ProgressTile(progress: p, showResume: true),
                ),
                SizedBox(height: 16.h),
              ],
              if (completed.isNotEmpty) ...[
                _SectionHeader(title: l10n.contentMyLearningCompleted),
                ...completed.map(
                  (p) => _ProgressTile(progress: p, showResume: false),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
      ),
    );
  }
}

class _ProgressTile extends StatelessWidget {
  const _ProgressTile({
    required this.progress,
    required this.showResume,
  });

  final ContentMediaProgress progress;
  final bool showResume;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final subtitle = progress.mediaTitle ?? progress.topicTitle;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: DecoratedBox(
        decoration: AppDecorations.card(),
        child: ListTile(
          leading: Icon(
            progress.completed
                ? Icons.check_circle_outline
                : Icons.play_lesson_outlined,
            color: progress.completed
                ? AppColors.success
                : AppColors.primary,
          ),
          title: Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
          subtitle: Text(
            progress.completed
                ? l10n.contentMyLearningCompletedLabel
                : l10n.contentMyLearningResumeHint,
          ),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () {
            final uri = Uri(
              path: AppRoutes.contentTopicDetailPath(progress.topicId),
              queryParameters: {
                if (showResume) 'mediaId': progress.mediaId,
                if (showResume && progress.positionMs > 0)
                  'positionMs': '${progress.positionMs}',
              },
            );
            unawaited(context.push(uri.toString()));
          },
        ),
      ),
    );
  }
}
