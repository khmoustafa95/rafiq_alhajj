import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/home_app_header.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/public_content_feed_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_media_widgets.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_section.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_topics_section.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/continue_learning_card.dart';
import 'package:rafiq_alhajj/features/home/presentation/widgets/journey_cta_card.dart';
import 'package:rafiq_alhajj/features/home/presentation/widgets/prayer_times_hero_card.dart';
import 'package:rafiq_alhajj/features/home/presentation/widgets/quick_action_tiles.dart';
import 'package:rafiq_alhajj/features/home/presentation/widgets/sos_home_card.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_bell_button.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

abstract final class HomeFeedPreviewLimits {
  static const int topics = 4;
  static const int news = 2;
  static const int announcements = 2;
}

/// Scrollable home feed below the app header.
class HomeBody extends ConsumerWidget {
  const HomeBody({
    required this.isPilgrim,
    required this.pilgrimName,
    required this.onContentTap,
    required this.onTopicTap,
    super.key,
  });

  final bool isPilgrim;
  final String? pilgrimName;
  final void Function(ContentItem item) onContentTap;
  final void Function(ContentTopic topic) onTopicTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final accessMode =
        isPilgrim ? AppAccessMode.pilgrim : AppAccessMode.guest;
    final feedAsync = ref.watch(homeContentFeedProvider(accessMode));
    final feed = feedAsync.value;
    final isFeedLoading = feedAsync.isLoading && feed == null;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HomeAppHeader(
              actions: [NotificationBellButton()],
            ),
            const Divider(height: 1),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(homeContentFeedProvider(accessMode));
                  await ref.read(homeContentFeedProvider(accessMode).future);
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (isPilgrim && pilgrimName != null) ...[
                              Text(
                                l10n.homePilgrimGreeting(pilgrimName!),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(height: 4.h),
                            ],
                            const PrayerTimesHeroCard(),
                            SizedBox(height: 16.h),
                            const QuickActionTiles(),
                            SizedBox(height: 16.h),
                            if (isPilgrim) ...[
                              const SosHomeCard(),
                              SizedBox(height: 16.h),
                            ],
                            JourneyCtaCard(isPilgrim: isPilgrim),
                            if (!AppConfig.hasSupabase) ...[
                              SizedBox(height: 12.h),
                              Text(
                                l10n.contentSupabaseRequired,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.error),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            if (isFeedLoading) ...[
                              SizedBox(height: 16.h),
                              const LinearProgressIndicator(),
                            ],
                            if (feedAsync.hasError && feed == null) ...[
                              SizedBox(height: 16.h),
                              Text(
                                l10n.contentLoadError,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.error),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                    if (isPilgrim)
                      const SliverToBoxAdapter(
                        child: ContinueLearningCard(),
                      ),
                    SliverToBoxAdapter(
                      child: ContentSection(
                        title: l10n.contentAnnouncementsSection,
                        items: feed?.announcements ?? const [],
                        emptyMessage: l10n.contentAnnouncementsEmpty,
                        onItemTap: onContentTap,
                        maxItems: HomeFeedPreviewLimits.announcements,
                        seeAllLabel: l10n.homeSeeAll,
                        onSeeAll: feed == null
                            ? null
                            : () => unawaited(
                                  context.push(
                                    AppRoutes.contentAnnouncementsList,
                                  ),
                                ),
                        layout: ContentSectionLayout.featured,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ContentSection(
                        title: l10n.contentNewsSectionTitle,
                        items: feed?.news ?? const [],
                        emptyMessage: l10n.contentNewsEmpty,
                        onItemTap: onContentTap,
                        maxItems: HomeFeedPreviewLimits.news,
                        seeAllLabel: l10n.homeSeeAll,
                        onSeeAll: feed == null
                            ? null
                            : () => unawaited(
                                  context.push(AppRoutes.contentNewsList),
                                ),
                        layout: ContentSectionLayout.featured,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: isFeedLoading
                          ? const ContentTopicsSectionSkeleton()
                          : ContentTopicsSection(
                              title: l10n.contentLibrarySection,
                              topics: feed?.topics ?? const [],
                              emptyMessage: l10n.contentTopicsEmpty,
                              onTopicTap: onTopicTap,
                              maxItems: HomeFeedPreviewLimits.topics,
                              seeAllLabel: l10n.homeSeeAll,
                              onSeeAll: feed == null
                                  ? null
                                  : () => unawaited(
                                        context
                                            .push(AppRoutes.contentTopicsList),
                                      ),
                            ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
