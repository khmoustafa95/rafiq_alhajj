import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_detail_provider.dart';
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
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.contentLoadError)),
        data: (item) {
          if (item == null) {
            return Center(child: Text(l10n.contentNotFound));
          }

          final mediaUrl = item.mediaUrl;
          final hasMedia = mediaUrl != null && mediaUrl.isNotEmpty;
          final showInlineImage = hasMedia && _isImageUrl(mediaUrl);

          return SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showInlineImage) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      mediaUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) =>
                          progress == null
                              ? child
                              : SizedBox(
                                  height: 200.h,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                      errorBuilder: (_, _, _) => const SizedBox.shrink(),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                if (item.description != null &&
                    item.description!.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  Text(
                    item.description!,
                    style: Theme.of(context).textTheme.bodyLarge,
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
    );
  }

  /// True when the URL points at a renderable raster image (by extension).
  /// Non-image links (e.g. YouTube) fall back to the external open button.
  bool _isImageUrl(String url) {
    final path = Uri.tryParse(url)?.path.toLowerCase() ?? url.toLowerCase();
    return path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.png') ||
        path.endsWith('.webp') ||
        path.endsWith('.gif');
  }

  Future<void> _openMediaUrl(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null || !await launchUrl(uri, mode: LaunchMode.externalApplication)) {
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
