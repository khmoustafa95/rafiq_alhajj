import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/content/application/services/content_media_cache_service.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class HajjJourneyOfflineActions extends ConsumerWidget {
  const HajjJourneyOfflineActions({required this.step, super.key});

  final HajjJourneyStep step;

  String get _topicId => 'journey_${step.ritualKey}';

  List<({String mediaId, String url, EducationalMediaType mediaType})>
      get _cacheable => [
            for (final media in step.media)
              if (ContentMediaUrlRules.isCacheable(media.url))
                (
                  mediaId: media.id,
                  url: media.url,
                  mediaType: EducationalMediaType.typeFromKey(
                    media.mediaTypeKey,
                  ),
                ),
          ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final cacheable = _cacheable;
    if (cacheable.isEmpty) {
      return const SizedBox.shrink();
    }

    final downloadAsync = ref.watch(contentMediaDownloadControllerProvider);
    final cacheAsync = ref.watch(contentMediaCacheServiceProvider);
    final controller =
        ref.read(contentMediaDownloadControllerProvider.notifier);
    final state = downloadAsync.value ?? const ContentDownloadState();
    final cachedCount = cacheAsync.value?.cachedCountForTopic(_topicId) ?? 0;

    final allCached = cachedCount >= cacheable.length;
    final downloading = state.jobs.values.any(
      (j) =>
          j.status == MediaDownloadStatus.downloading ||
          j.status == MediaDownloadStatus.queued,
    );

    return DecoratedBox(
      decoration: AppDecorations.card(color: AppColors.surfaceMuted),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.contentTopicOfflineTitle,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    allCached
                        ? l10n.contentTopicOfflineDownloaded
                        : l10n.contentTopicOfflineProgress(
                            cachedCount,
                            cacheable.length,
                          ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            if (allCached)
              TextButton.icon(
                onPressed: () => controller.removeTopicDownloads(_topicId),
                icon: const Icon(Icons.download_done_outlined),
                label: Text(l10n.contentTopicOfflineDelete),
              )
            else
              FilledButton.tonalIcon(
                onPressed: downloading
                    ? null
                    : () async {
                        await controller.enqueueJourneyStepMedia(
                          ritualKey: step.ritualKey,
                          media: cacheable,
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.contentTopicOfflineStarted),
                            ),
                          );
                        }
                      },
                icon: Icon(
                  downloading ? Icons.downloading : Icons.download_outlined,
                ),
                label: Text(l10n.contentTopicOfflineDownload),
              ),
          ],
        ),
      ),
    );
  }
}
