import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/educational_media_viewer.dart';
import 'package:rafiq_alhajj/features/content/application/services/content_media_cache_service.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class ContentTopicOfflineActions extends ConsumerWidget {
  const ContentTopicOfflineActions({required this.topic, super.key});

  final ContentTopic topic;

  List<String> get _cacheableIds => topic.media
      .where((m) => ContentMediaUrlRules.isCacheable(m.url))
      .map((m) => m.id)
      .toList();

  bool _isExternalVideo(String url) {
    final lower = url.toLowerCase();
    return lower.contains('youtube.com') ||
        lower.contains('youtu.be') ||
        lower.contains('vimeo.com');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final cacheableIds = _cacheableIds;
    final hasExternal = topic.media.any((m) => _isExternalVideo(m.url));

    if (cacheableIds.isEmpty && !hasExternal) {
      return const SizedBox.shrink();
    }

    final downloadAsync = ref.watch(contentMediaDownloadControllerProvider);
    final cacheAsync = ref.watch(contentMediaCacheServiceProvider);
    final controller =
        ref.read(contentMediaDownloadControllerProvider.notifier);
    final state = downloadAsync.value ?? const ContentDownloadState();
    final cachedForTopic = cacheAsync.value?.cachedCountForTopic(topic.id) ?? 0;

    final jobs = [
      for (final id in cacheableIds)
        if (state.jobs[id] != null) state.jobs[id]!,
    ];
    final downloading = jobs
        .where(
          (j) =>
              j.status == MediaDownloadStatus.downloading ||
              j.status == MediaDownloadStatus.queued,
        )
        .toList();
    final hasFailed =
        jobs.any((j) => j.status == MediaDownloadStatus.failed);
    final allCached =
        cacheableIds.isEmpty ? false : cachedForTopic >= cacheableIds.length;

    final String subtitle;
    if (cacheableIds.isEmpty) {
      subtitle = l10n.contentTopicRequiresInternet;
    } else if (downloading.isNotEmpty) {
      final avg = downloading.fold<double>(0, (sum, j) => sum + j.progress) /
          downloading.length;
      subtitle = state.waitingForWifi
          ? l10n.contentOfflineWaitingWifi
          : l10n.contentTopicOfflineDownloading((avg * 100).round());
    } else if (allCached) {
      subtitle = l10n.contentTopicOfflineDownloaded;
    } else {
      subtitle =
          l10n.contentTopicOfflineProgress(cachedForTopic, cacheableIds.length);
    }

    final row = Row(
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
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
        _TopicActionButton(
          downloading: downloading.isNotEmpty,
          allCached: allCached,
          hasFailed: hasFailed,
          downloadEnabled: cacheableIds.isNotEmpty,
          onDownload: () async {
            await controller.enqueueTopic(topic);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.contentTopicOfflineStarted)),
              );
            }
          },
          onPause: () {
            for (final job in downloading) {
              controller.pause(job.mediaId);
            }
          },
          onDelete: () => controller.removeTopicDownloads(topic.id),
        ),
      ],
    );

    return DecoratedBox(
      decoration: AppDecorations.card(color: AppColors.surfaceMuted),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final content = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (cacheableIds.isNotEmpty)
                  FutureBuilder<int?>(
                    future: ref
                        .read(contentMediaDownloadControllerProvider.notifier)
                        .estimateTopicDownloadBytes(topic),
                    builder: (context, snapshot) {
                      final bytes = snapshot.data;
                      if (bytes == null) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Text(
                          l10n.contentTopicDownloadSizeEstimate(
                            _formatMb(bytes),
                          ),
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      );
                    },
                  ),
                row,
                if (hasExternal) ...[
                  SizedBox(height: 8.h),
                  Text(
                    l10n.contentTopicRequiresInternet,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ],
            );
            if (constraints.hasBoundedWidth) {
              return content;
            }
            return ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: content,
            );
          },
        ),
      ),
    );
  }

  String _formatMb(int bytes) {
    final mb = bytes / (1024 * 1024);
    return mb < 0.1 ? '< 0.1' : mb.toStringAsFixed(1);
  }
}

class _TopicActionButton extends StatelessWidget {
  const _TopicActionButton({
    required this.downloading,
    required this.allCached,
    required this.hasFailed,
    required this.downloadEnabled,
    required this.onDownload,
    required this.onPause,
    required this.onDelete,
  });

  final bool downloading;
  final bool allCached;
  final bool hasFailed;
  final bool downloadEnabled;
  final Future<void> Function() onDownload;
  final VoidCallback onPause;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (!downloadEnabled) {
      return const SizedBox.shrink();
    }
    if (downloading) {
      return TextButton.icon(
        onPressed: onPause,
        icon: const Icon(Icons.pause_circle_outline),
        label: Text(l10n.contentTopicOfflinePause),
      );
    }
    if (allCached) {
      return TextButton.icon(
        onPressed: onDelete,
        icon: const Icon(Icons.delete_outline),
        label: Text(l10n.contentTopicOfflineDelete),
      );
    }
    return FilledButton.tonalIcon(
      onPressed: () => onDownload(),
      icon: Icon(hasFailed ? Icons.refresh : Icons.download_outlined),
      label: Text(
        hasFailed
            ? l10n.contentTopicOfflineRetry
            : l10n.contentTopicOfflineDownload,
      ),
    );
  }
}

class AdminContentMediaPreview extends StatelessWidget {
  const AdminContentMediaPreview({
    required this.media,
    super.key,
  });

  final List<EducationalMediaItem> media;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (media.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.adminContentTopicMediaPreview,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 8.h),
        EducationalMediaViewer(
          media: media,
          sectionTitle: l10n.adminContentTopicMediaPreview,
        ),
      ],
    );
  }
}
