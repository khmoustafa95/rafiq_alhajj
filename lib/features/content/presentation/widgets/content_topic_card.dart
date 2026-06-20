import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

enum ContentTopicCardLayout { horizontal, featured }

class ContentTopicCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return switch (layout) {
      ContentTopicCardLayout.featured => _FeaturedCard(
          topic: topic,
          onTap: onTap,
          l10n: l10n,
        ),
      ContentTopicCardLayout.horizontal => _HorizontalCard(
          topic: topic,
          onTap: onTap,
          l10n: l10n,
        ),
    };
  }
}

class _HorizontalCard extends StatelessWidget {
  const _HorizontalCard({
    required this.topic,
    required this.onTap,
    required this.l10n,
  });

  final ContentTopic topic;
  final VoidCallback onTap;
  final AppLocalizations l10n;

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
                  url: topic.coverImageUrl,
                  height: 130.h,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topic.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (topic.description != null) ...[
                          SizedBox(height: 4.h),
                          Expanded(
                            child: Text(
                              topic.description!,
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
                        ] else
                          const Spacer(),
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
    required this.onTap,
    required this.l10n,
  });

  final ContentTopic topic;
  final VoidCallback onTap;
  final AppLocalizations l10n;

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
                url: topic.coverImageUrl,
                height: 180.h,
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    if (topic.description != null) ...[
                      SizedBox(height: 6.h),
                      Text(
                        topic.description!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    SizedBox(height: 10.h),
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
  const _CoverImage({required this.url, required this.height});

  final String? url;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppDecorations.radiusLg),
      ),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: url != null && url!.isNotEmpty
            ? Image.network(
                url!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const _CoverPlaceholder(),
              )
            : const _CoverPlaceholder(),
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
