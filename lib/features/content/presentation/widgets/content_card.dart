import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/utils/content_cover_utils.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/resolved_cover_image.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

enum ContentCardLayout { compact, featured, horizontal }

class ContentCard extends StatelessWidget {
  const ContentCard({
    required this.item,
    required this.onTap,
    this.layout = ContentCardLayout.compact,
    super.key,
  });

  final ContentItem item;
  final VoidCallback onTap;
  final ContentCardLayout layout;

  @override
  Widget build(BuildContext context) {
    return switch (layout) {
      ContentCardLayout.featured => _FeaturedCard(item: item, onTap: onTap),
      ContentCardLayout.horizontal => _HorizontalCard(item: item, onTap: onTap),
      ContentCardLayout.compact => _CompactCard(item: item, onTap: onTap),
    };
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.item, required this.onTap});

  final ContentItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final title = item.localizedTitle(locale);
    final description = item.localizedDescription(locale);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: DecoratedBox(
          decoration: AppDecorations.card(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  _ContentCover(
                    item: item,
                    height: 160.h,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppDecorations.radiusMd),
                    ),
                    fallbackIcon: item.type == ContentType.video
                        ? Icons.play_circle_fill_rounded
                        : Icons.article_rounded,
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        l10n.contentImportantTag,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(14.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 4,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _relativeTime(item.createdAt, l10n),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (description != null && description.isNotEmpty) ...[
                            SizedBox(height: 4.h),
                            Text(
                              description,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),
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

class _HorizontalCard extends StatelessWidget {
  const _HorizontalCard({required this.item, required this.onTap});

  final ContentItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final title = item.localizedTitle(locale);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: Container(
          decoration: AppDecorations.card(),
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDate(item.createdAt),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              SizedBox(
                width: 72.w,
                height: 72.w,
                child: _ContentCover(
                  item: item,
                  height: 72.w,
                  borderRadius: BorderRadius.circular(10),
                  fallbackIcon: Icons.image_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompactCard extends StatelessWidget {
  const _CompactCard({required this.item, required this.onTap});

  final ContentItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final title = item.localizedTitle(locale);
    final description = item.localizedDescription(locale);
    final hasCover =
        isContentCoverImageUrl(item.mediaUrl);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: Container(
          decoration: AppDecorations.card(),
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              if (hasCover)
                SizedBox(
                  width: 44.w,
                  height: 44.w,
                  child: _ContentCover(
                    item: item,
                    height: 44.w,
                    borderRadius: BorderRadius.circular(10),
                    fallbackIcon: Icons.article_outlined,
                  ),
                )
              else
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item.type == ContentType.video
                        ? Icons.play_circle_outline
                        : Icons.article_outlined,
                    color: AppColors.primary,
                    size: 24.sp,
                  ),
                ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (description != null && description.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textSecondary,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContentCover extends ConsumerWidget {
  const _ContentCover({
    required this.item,
    required this.height,
    required this.borderRadius,
    required this.fallbackIcon,
  });

  final ContentItem item;
  final double height;
  final BorderRadius borderRadius;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaUrl = item.mediaUrl;
    if (isContentCoverImageUrl(mediaUrl)) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: ResolvedCoverImage(
          cacheMediaId:
              ContentMediaDownloadController.contentCoverMediaId(item.id),
          remoteUrl: mediaUrl!,
          fit: BoxFit.cover,
          height: height,
        ),
      );
    }

    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.85),
            AppColors.primaryDark,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          fallbackIcon,
          size: 56.sp,
          color: AppColors.onPrimary.withValues(alpha: 0.9),
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  final months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  return '${months[date.month - 1]} ${date.day}, ${date.year}';
}

String _relativeTime(DateTime date, AppLocalizations l10n) {
  final diff = DateTime.now().difference(date);
  if (diff.inHours < 24) {
    final hours = diff.inHours.clamp(1, 23);
    return l10n.contentHoursAgo(hours);
  }
  return _formatDate(date);
}
