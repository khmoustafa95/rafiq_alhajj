import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/content/application/services/content_media_cache_service.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_topics_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class ContentOfflineSettingsCard extends ConsumerWidget {
  const ContentOfflineSettingsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final downloadAsync = ref.watch(contentMediaDownloadControllerProvider);
    final topicsAsync = ref.watch(contentTopicsListProvider(AppAccessMode.pilgrim));
    final cacheAsync = ref.watch(contentMediaCacheServiceProvider);

    final downloadState = downloadAsync.value ?? const ContentDownloadState();
    final cachedCount = cacheAsync.value?.cachedMediaCount ?? 0;
    final activeJobs = downloadState.jobs.values
        .where(
          (job) =>
              job.status == MediaDownloadStatus.downloading ||
              job.status == MediaDownloadStatus.queued,
        )
        .length;

    return DecoratedBox(
      decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.contentOfflineTitle,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            SizedBox(height: 6.h),
            Text(
              l10n.contentOfflineSubtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            SizedBox(height: 12.h),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: downloadState.offlineEnabled,
              onChanged: downloadAsync.isLoading
                  ? null
                  : (enabled) async {
                      final topics = topicsAsync.value ?? const [];
                      await ref
                          .read(contentMediaDownloadControllerProvider.notifier)
                          .setOfflineEnabled(enabled, topics: topics);
                    },
              title: Text(l10n.contentOfflineEnable),
              subtitle: downloadState.isProcessing || activeJobs > 0
                  ? Text(l10n.contentOfflineDownloading)
                  : Text(l10n.contentOfflineCachedCount(cachedCount)),
            ),
            if (cachedCount > 0)
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: downloadAsync.isLoading
                      ? null
                      : () async {
                          await ref
                              .read(
                                contentMediaDownloadControllerProvider.notifier,
                              )
                              .clearCache();
                        },
                  child: Text(l10n.contentOfflineClearCache),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
