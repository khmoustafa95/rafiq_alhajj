import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_detail_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/utils/content_cover_utils.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_article_offline_action.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_offline_banner.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/resolved_cover_image.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentDetailScreen extends ConsumerWidget {
  const ContentDetailScreen({
    required this.contentId,
    super.key,
  });

  final String contentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final detailAsync = ref.watch(contentDetailProvider(contentId));

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.contentDetailTitle),
      ),
      body: Column(
        children: [
          const ContentOfflineBanner(),
          Expanded(
            child: detailAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(l10n.contentLoadError, textAlign: TextAlign.center),
                      SizedBox(height: 16.h),
                      FilledButton(
                        onPressed: () =>
                            ref.invalidate(contentDetailProvider(contentId)),
                        child: Text(l10n.retry),
                      ),
                    ],
                  ),
                ),
              ),
              data: (item) {
                if (item == null) {
                  return Center(child: Text(l10n.contentNotFound));
                }

                final locale = Localizations.localeOf(context).languageCode;
                final title = item.localizedTitle(locale);
                final description = item.localizedDescription(locale);
                final mediaUrl = item.mediaUrl;
                final hasMedia = mediaUrl != null && mediaUrl.isNotEmpty;
                final showInlineImage =
                    hasMedia && isContentCoverImageUrl(mediaUrl);

                return SingleChildScrollView(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (showInlineImage) ...[
                        ResolvedCoverImage(
                          cacheMediaId: ContentMediaDownloadController
                              .contentCoverMediaId(item.id),
                          remoteUrl: mediaUrl,
                          fit: BoxFit.cover,
                          height: 200.h,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        SizedBox(height: 12.h),
                        ContentArticleOfflineAction(
                          contentId: item.id,
                          coverUrl: mediaUrl,
                        ),
                        SizedBox(height: 8.h),
                      ],
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      if (description != null && description.isNotEmpty) ...[
                        SizedBox(height: 16.h),
                        MarkdownBody(
                          data: description,
                          selectable: true,
                          styleSheet: MarkdownStyleSheet.fromTheme(
                            Theme.of(context),
                          ),
                        ),
                      ],
                      if (hasMedia && !showInlineImage) ...[
                        SizedBox(height: 24.h),
                        FilledButton.icon(
                          onPressed: () => _openMediaUrl(context, mediaUrl),
                          icon: const Icon(Icons.open_in_new),
                          label: Text(l10n.contentOpenMedia),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openMediaUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null ||
        !await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).contentOpenMediaFailed),
          ),
        );
      }
    }
  }
}
