import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/content/application/services/content_media_cache_service.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/utils/content_cover_utils.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Saves an article cover image for offline reading when offline mode is on.
class ContentArticleOfflineAction extends ConsumerWidget {
  const ContentArticleOfflineAction({
    required this.contentId,
    required this.coverUrl,
    super.key,
  });

  final String contentId;
  final String coverUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    if (!isContentCoverImageUrl(coverUrl)) {
      return const SizedBox.shrink();
    }

    final downloadState =
        ref.watch(contentMediaDownloadControllerProvider).asData?.value;
    if (!(downloadState?.offlineEnabled ?? false)) {
      return const SizedBox.shrink();
    }

    final mediaId =
        ContentMediaDownloadController.contentCoverMediaId(contentId);
    final job = downloadState?.jobs[mediaId];
    final isDone = job?.status == MediaDownloadStatus.completed;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: OutlinedButton.icon(
        onPressed: isDone
            ? null
            : () => ref
                .read(contentMediaDownloadControllerProvider.notifier)
                .enqueueMedia(
                  mediaId: mediaId,
                  url: coverUrl,
                  topicId: contentId,
                  mediaType: EducationalMediaType.image,
                ),
        icon: Icon(
          isDone ? Icons.offline_pin_rounded : Icons.download_outlined,
          color: isDone ? AppColors.success : null,
        ),
        label: Text(
          isDone
              ? l10n.contentArticleOfflineSaved
              : l10n.contentArticleOfflineSave,
        ),
      ),
    );
  }
}
