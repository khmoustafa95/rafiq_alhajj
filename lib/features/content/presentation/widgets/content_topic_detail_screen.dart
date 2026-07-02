import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/educational_media_viewer.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_page_constraint.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_topics_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_offline_banner.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_topic_offline_actions.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/resolved_cover_image.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/topic_learning_progress_badge.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class ContentTopicDetailScreen extends ConsumerWidget {
  const ContentTopicDetailScreen({
    required this.topicId,
    this.initialMediaId,
    this.initialPositionMs,
    super.key,
  });

  final String topicId;
  final String? initialMediaId;
  final int? initialPositionMs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final topicAsync = ref.watch(contentTopicDetailProvider(topicId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const ContentOfflineBanner(),
          Expanded(
            child: topicAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.contentLoadError, textAlign: TextAlign.center),
                SizedBox(height: 16.h),
                FilledButton(
                  onPressed: () =>
                      ref.invalidate(contentTopicDetailProvider(topicId)),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (topic) {
          if (topic == null) {
            return Scaffold(
              appBar: const RafiqAppBar(),
              body: Center(child: Text(l10n.contentTopicNotFound)),
            );
          }

          final locale = Localizations.localeOf(context).languageCode;
          final topicTitle = topic.localizedTitle(locale);
          final topicDescription = topic.localizedDescription(locale);

          return CompetitionPageConstraint(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(contentTopicDetailProvider(topicId));
                await ref.read(contentTopicDetailProvider(topicId).future);
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200.h,
                    pinned: true,
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnDark,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsetsDirectional.only(
                        start: 16.w,
                        bottom: 16.h,
                        end: 56.w,
                      ),
                      title: Text(
                        topicTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textOnDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (topic.coverImageUrl != null)
                            ResolvedCoverImage(
                              cacheMediaId: ContentMediaDownloadController
                                  .coverMediaId(topic.id),
                              remoteUrl: topic.coverImageUrl!,
                              fit: BoxFit.cover,
                            )
                          else
                            _heroFallback(),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.55),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(16.w),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        if (topicDescription != null &&
                            topicDescription.isNotEmpty) ...[
                          DecoratedBox(
                            decoration: AppDecorations.card(
                              radius: AppDecorations.radiusLg,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Text(
                                topicDescription,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],
                        TopicLearningProgressBadge(topic: topic),
                        SizedBox(height: 16.h),
                        if (!AppPlatform.isWeb) ...[
                          ContentTopicOfflineActions(topic: topic),
                          SizedBox(height: 16.h),
                        ],
                        EducationalMediaViewer(
                          media: topic.educationalMedia,
                          sectionTitle: l10n.contentTopicMediaTitle,
                          emptyMessage: l10n.contentTopicNoMedia,
                          progressTopicId: topic.id,
                          progressTopicTitle: topicTitle,
                          initialMediaId: initialMediaId,
                          initialPositionMs: initialPositionMs,
                        ),
                        SizedBox(height: 24.h),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroFallback() {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.menu_book_rounded,
          color: AppColors.textOnDark.withValues(alpha: 0.8),
          size: 64.sp,
        ),
      ),
    );
  }
}
