import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/public_content_feed_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_card.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

enum ContentListCategory { news, announcements }

class ContentListScreen extends ConsumerWidget {
  const ContentListScreen({
    required this.category,
    super.key,
  });

  final ContentListCategory category;

  void _openContent(BuildContext context, ContentItem item) {
    unawaited(context.push(AppRoutes.contentDetailPath(item.id)));
  }

  String _title(AppLocalizations l10n) => switch (category) {
        ContentListCategory.news => l10n.contentNewsSectionTitle,
        ContentListCategory.announcements => l10n.contentAnnouncementsSection,
      };

  String _emptyMessage(AppLocalizations l10n) => switch (category) {
        ContentListCategory.news => l10n.contentNewsEmpty,
        ContentListCategory.announcements => l10n.contentAnnouncementsEmpty,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final accessMode =
        ref.watch(authAccessModeProvider) == AppAccessMode.pilgrim
            ? AppAccessMode.pilgrim
            : AppAccessMode.guest;
    final feedAsync = ref.watch(homeContentFeedProvider(accessMode));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RafiqAppBar(title: Text(_title(l10n))),
      body: feedAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.contentLoadError)),
        data: (feed) {
          final items = switch (category) {
            ContentListCategory.news => feed.news,
            ContentListCategory.announcements => feed.announcements,
          };

          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Text(
                  _emptyMessage(l10n),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: items.length,
            separatorBuilder: (_, _) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final item = items[index];
              final layout = index == 0
                  ? ContentCardLayout.featured
                  : ContentCardLayout.horizontal;

              return ContentCard(
                item: item,
                layout: layout,
                onTap: () => _openContent(context, item),
              );
            },
          );
        },
      ),
    );
  }
}
