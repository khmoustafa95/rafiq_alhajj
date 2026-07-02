import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/content/application/services/content_media_cache_service.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/resolved_cover_image.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/topic_learning_progress_badge.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

enum ContentTopicCardLayout { horizontal, featured }

class ContentTopicCard extends ConsumerWidget {
  const ContentTopicCard({
    required this.topic,
    required this.onTap,
    this.layout = ContentTopicCardLayout.horizontal,
    super.key,
  });

  final ContentTopic topic;
  final VoidCallback onTap;
  final ContentTopicCardLayout layout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    return switch (layout) {
      ContentTopicCardLayout.featured => _FeaturedCard(
          topic: topic,
          title: topic.localizedTitle(locale),
          description: topic.localizedDescription(locale),
          onTap: onTap,
          l10n: l10n,
          isOffline: _isOfflineReady(ref),
        ),
      ContentTopicCardLayout.horizontal => _HorizontalCard(
          topic: topic,
          title: topic.localizedTitle(locale),
          description: topic.localizedDescription(locale),
          onTap: onTap,
          l10n: l10n,
          isOffline: _isOfflineReady(ref),
        ),
    };
  }

  bool _isOfflineReady(WidgetRef ref) {
    final cacheable = topic.media
        .where((m) => ContentMediaUrlRules.isCacheable(m.url))
        .length;
    if (cacheable == 0) {
      return false;
    }
    final cache = ref.watch(contentMediaCacheServiceProvider).value;
    if (cache == null) {
      return false;
    }
    return cache.cachedCountForTopic(topic.id) >= cacheable;
  }
}

class _HorizontalCard extends StatelessWidget {
  const _HorizontalCard({
    required this.topic,
    required this.title,
    required this.description,
    required this.onTap,
    required this.l10n,
    required this.isOffline,
  });

  final ContentTopic topic;
  final String title;
  final String? description;
  final VoidCallback onTap;
  final AppLocalizations l10n;
  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    final cardWidth = math.min(
      280.w,
      MediaQuery.sizeOf(context).width * 0.78,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
        child: Ink(
          decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
          child: SizedBox(
            width: cardWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _CoverImage(
                  topic: topic,
                  height: 130.h,
                  isOffline: isOffline,
                  l10n: l10n,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (description != null && description!.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Expanded(
                            child: Text(
                              description!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]                         else
                          const Spacer(),
                        TopicLearningProgressBadge(topic: topic),
                        SizedBox(height: 6.h),
                        _MediaBadges(topic: topic, l10n: l10n),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({
    required this.topic,
    required this.title,
    required this.description,
    required this.onTap,
    required this.l10n,
    required this.isOffline,
  });

  final ContentTopic topic;
  final String title;
  final String? description;
  final VoidCallback onTap;
  final AppLocalizations l10n;
  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
        child: Ink(
          decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _CoverImage(
                topic: topic,
                height: 180.h,
                isOffline: isOffline,
                l10n: l10n,
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    if (description != null && description!.isNotEmpty) ...[
                      SizedBox(height: 6.h),
                      Text(
                        description!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    SizedBox(height: 10.h),
                    TopicLearningProgressBadge(topic: topic),
                    SizedBox(height: 8.h),
                    _MediaBadges(topic: topic, l10n: l10n),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoverImage extends StatelessWidget {
  const _CoverImage({
    required this.topic,
    required this.height,
    required this.isOffline,
    required this.l10n,
  });

  final ContentTopic topic;
  final double height;
  final bool isOffline;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppDecorations.radiusLg),
      ),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (topic.coverImageUrl != null && topic.coverImageUrl!.isNotEmpty)
              ResolvedCoverImage(
                cacheMediaId:
                    ContentMediaDownloadController.coverMediaId(topic.id),
                remoteUrl: topic.coverImageUrl!,
                fit: BoxFit.cover,
                height: height,
              )
            else
              const _CoverPlaceholder(),
            if (isOffline)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.9),
                    borderRadius:
                        BorderRadius.circular(AppDecorations.radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.download_done,
                        size: 14.sp,
                        color: AppColors.textOnDark,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        l10n.contentTopicOfflineAvailable,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.textOnDark,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.85),
            AppColors.primaryDark,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.menu_book_rounded,
          color: AppColors.textOnDark.withValues(alpha: 0.9),
          size: 40.sp,
        ),
      ),
    );
  }
}

class _MediaBadges extends StatelessWidget {
  const _MediaBadges({required this.topic, required this.l10n});

  final ContentTopic topic;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[];

    if (topic.videoCount > 0) {
      chips.add(_Badge(
        icon: Icons.play_circle_outline,
        label: l10n.contentTopicVideoCount(topic.videoCount),
      ));
    }
    if (topic.audioCount > 0) {
      chips.add(_Badge(
        icon: Icons.headphones_outlined,
        label: l10n.contentTopicAudioCount(topic.audioCount),
      ));
    }
    if (topic.imageCount > 0) {
      chips.add(_Badge(
        icon: Icons.photo_library_outlined,
        label: l10n.contentTopicImageCount(topic.imageCount),
      ));
    }

    if (chips.isEmpty) {
      return Text(
        l10n.contentTopicNoMedia,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
            ),
      );
    }

    return Wrap(
      spacing: 6.w,
      runSpacing: 4.h,
      children: chips,
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(AppDecorations.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: AppColors.primaryDark),
          SizedBox(width: 4.w),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDark,
                ),
          ),
        ],
      ),
    );
  }
}
