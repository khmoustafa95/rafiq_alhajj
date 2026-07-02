import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_media_cache_store.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_catalog_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_downloads_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_offline_settings_card.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class ContentDownloadsScreen extends ConsumerWidget {
  const ContentDownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final downloadsAsync = ref.watch(contentDownloadsByTopicProvider);
    final cacheAsync = ref.watch(contentMediaCacheServiceProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RafiqAppBar(title: Text(l10n.contentDownloadsTitle)),
      body: downloadsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.contentLoadError)),
        data: (grouped) {
          if (grouped.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Text(
                  l10n.contentDownloadsEmpty,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }

          final usageBytes = cacheAsync.value?.usageBytes ?? 0;
          final topicIds = grouped.keys.toList()..sort();

          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              Text(
                l10n.contentOfflineStorageUsage(
                  formatBytes(usageBytes),
                  formatBytes(ContentMediaCacheStore.defaultQuotaBytes),
                ),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              SizedBox(height: 16.h),
              for (final topicId in topicIds) ...[
                _DownloadTopicTile(
                  topicId: topicId,
                  entries: grouped[topicId]!,
                ),
                SizedBox(height: 8.h),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _DownloadTopicTile extends ConsumerWidget {
  const _DownloadTopicTile({
    required this.topicId,
    required this.entries,
  });

  final String topicId;
  final List<CachedContentMediaEntry> entries;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final catalog = ref.watch(contentCatalogCacheProvider).asData?.value;
    final topic = catalog?.readTopic(topicId);
    final title = topic?.title ?? topicId;
    final bytes = entries.fold<int>(0, (sum, e) => sum + e.bytes);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: topic == null
            ? null
            : () => unawaited(
                  context.push(AppRoutes.contentTopicDetailPath(topicId)),
                ),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              Icon(Icons.folder_outlined, color: AppColors.primary, size: 28.sp),
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
                    SizedBox(height: 4.h),
                    Text(
                      l10n.contentDownloadsTopicSummary(
                        entries.length,
                        formatBytes(bytes),
                      ),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ),
              ),
              if (topic != null)
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textSecondary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
