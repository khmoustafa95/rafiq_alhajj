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

  int get _cacheableCount => topic.media
      .where((m) => ContentMediaUrlRules.isCacheable(m.url))
      .length;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (_cacheableCount == 0) {
      return const SizedBox.shrink();
    }

    final downloadAsync = ref.watch(contentMediaDownloadControllerProvider);
    final cacheAsync = ref.watch(contentMediaCacheServiceProvider);
    final cachedForTopic = cacheAsync.value?.cachedCountForTopic(topic.id) ?? 0;
    final isProcessing = downloadAsync.value?.isProcessing ?? false;

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
                    l10n.contentTopicOfflineProgress(cachedForTopic, _cacheableCount),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            FilledButton.tonalIcon(
              onPressed: isProcessing
                  ? null
                  : () async {
                      await ref
                          .read(contentMediaDownloadControllerProvider.notifier)
                          .enqueueTopic(topic);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.contentTopicOfflineStarted)),
                        );
                      }
                    },
              icon: const Icon(Icons.download_outlined),
              label: Text(l10n.contentTopicOfflineDownload),
            ),
          ],
        ),
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
