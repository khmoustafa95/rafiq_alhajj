import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/themed_surface_card.dart';
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
    final controller =
        ref.read(contentMediaDownloadControllerProvider.notifier);
    final activeJobs = downloadState.jobs.values
        .where(
          (job) =>
              job.status == MediaDownloadStatus.downloading ||
              job.status == MediaDownloadStatus.queued,
        )
        .length;
    final busy = downloadAsync.isLoading;

    return ThemedSurfaceCard(
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
              onChanged: busy
                  ? null
                  : (enabled) async {
                      final topics = topicsAsync.value ?? const [];
                      await controller.setOfflineEnabled(
                        enabled,
                        topics: topics,
                      );
                    },
              title: Text(l10n.contentOfflineEnable),
              subtitle: downloadState.waitingForWifi
                  ? Text(l10n.contentOfflineWaitingWifi)
                  : (downloadState.isProcessing || activeJobs > 0
                      ? Text(l10n.contentOfflineDownloading)
                      : Text(l10n.contentOfflineCachedCount(cachedCount))),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: downloadState.wifiOnly,
              onChanged: busy ? null : controller.setWifiOnly,
              title: Text(l10n.contentOfflineWifiOnly),
              subtitle: Text(l10n.contentOfflineWifiOnlySubtitle),
            ),
            if (cachedCount > 0) ...[
              SizedBox(height: 8.h),
              _StorageUsageBar(
                usageBytes: downloadState.usageBytes,
                quotaBytes: downloadState.quotaBytes,
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: busy ? null : controller.clearCache,
                  child: Text(l10n.contentOfflineClearCache),
                ),
              ),
            ],
          ],
        ),
    );
  }
}

class _StorageUsageBar extends StatelessWidget {
  const _StorageUsageBar({
    required this.usageBytes,
    required this.quotaBytes,
  });

  final int usageBytes;
  final int quotaBytes;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final ratio = quotaBytes <= 0
        ? 0.0
        : (usageBytes / quotaBytes).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 8.h,
            backgroundColor: AppColors.surfaceMuted,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          l10n.contentOfflineStorageUsage(
            formatBytes(usageBytes),
            formatBytes(quotaBytes),
          ),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}

String formatBytes(int bytes) {
  if (bytes < 1024) {
    return '$bytes B';
  }
  const units = ['KB', 'MB', 'GB', 'TB'];
  var value = bytes / 1024;
  var unitIndex = 0;
  while (value >= 1024 && unitIndex < units.length - 1) {
    value /= 1024;
    unitIndex++;
  }
  return '${value.toStringAsFixed(value >= 10 ? 0 : 1)} ${units[unitIndex]}';
}
