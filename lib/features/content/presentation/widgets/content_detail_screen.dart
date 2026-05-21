import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
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
      appBar: AppBar(
        title: Text(l10n.contentDetailTitle),
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.contentLoadError)),
        data: (item) {
          if (item == null) {
            return Center(child: Text(l10n.contentNotFound));
          }

          final colorScheme = Theme.of(context).colorScheme;

          return SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  item.type == ContentType.video
                      ? Icons.play_circle_outline
                      : Icons.article_outlined,
                  size: 48.sp,
                  color: colorScheme.primary,
                ),
                SizedBox(height: 16.h),
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
                if (item.mediaUrl != null && item.mediaUrl!.isNotEmpty) ...[
                  SizedBox(height: 24.h),
                  FilledButton.icon(
                    onPressed: () => _openMediaUrl(context, item.mediaUrl!),
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
