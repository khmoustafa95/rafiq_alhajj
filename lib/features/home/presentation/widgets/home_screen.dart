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

import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';

import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/public_content_feed_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_media_widgets.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_section.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_stale_indicator.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_topics_section.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_wifi_onboarding_dialog.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/continue_learning_card.dart';

import 'package:rafiq_alhajj/features/home/presentation/widgets/journey_cta_card.dart';

import 'package:rafiq_alhajj/features/home/presentation/widgets/prayer_times_hero_card.dart';

import 'package:rafiq_alhajj/features/home/presentation/widgets/quick_action_tiles.dart';

import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_bell_button.dart';

import 'package:rafiq_alhajj/l10n/app_localizations.dart';



abstract final class HomeFeedPreviewLimits {

  static const int topics = 4;

  static const int news = 2;

  static const int announcements = 2;

}



/// Home — US-01 public content + redesigned Hajj Companion layout.

class HomeScreen extends ConsumerWidget {

  const HomeScreen({super.key});



  void _openContent(BuildContext context, ContentItem item) {

    unawaited(context.push(AppRoutes.contentDetailPath(item.id)));

  }

  void _openTopic(BuildContext context, ContentTopic topic) {

    unawaited(context.push(AppRoutes.contentTopicDetailPath(topic.id)));

  }



  @override

  Widget build(BuildContext context, WidgetRef ref) {

    final l10n = AppLocalizations.of(context);

    final sessionAsync = ref.watch(authSessionProvider);

    final isPilgrim =

        ref.watch(authAccessModeProvider) == AppAccessMode.pilgrim;

    final pilgrimName = ref.watch(authProfileFullNameProvider);



    if (sessionAsync.hasError && !sessionAsync.hasValue) {

      return Scaffold(

        body: Center(child: Text(l10n.authErrorUnknown)),

      );

    }



    return _HomeBody(

      isPilgrim: isPilgrim,

      pilgrimName: pilgrimName,

      onContentTap: (item) => _openContent(context, item),

      onTopicTap: (topic) => _openTopic(context, topic),

    );

  }

}



class _HomeBody extends ConsumerStatefulWidget {
  const _HomeBody({
    required this.isPilgrim,
    required this.pilgrimName,
    required this.onContentTap,
    required this.onTopicTap,
  });

  final bool isPilgrim;
  final String? pilgrimName;
  final void Function(ContentItem item) onContentTap;
  final void Function(ContentTopic topic) onTopicTap;

  @override
  ConsumerState<_HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends ConsumerState<_HomeBody> {
  @override
  void initState() {
    super.initState();
    if (widget.isPilgrim) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(ContentWifiOnboardingDialog.showIfNeeded(context, ref));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final accessMode =
        widget.isPilgrim ? AppAccessMode.pilgrim : AppAccessMode.guest;
    final feedAsync = ref.watch(homeContentFeedProvider(accessMode));
    final feedSnapshot = feedAsync.value;
    final feed = feedSnapshot?.data;
    final isFeedLoading = feedAsync.isLoading && feed == null;

    return Scaffold(

      backgroundColor: AppColors.background,

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

                            if (widget.isPilgrim && widget.pilgrimName != null) ...[
                              Text(
                                l10n.homePilgrimGreeting(widget.pilgrimName!),

                                style:

                                    Theme.of(context).textTheme.titleLarge,

                              ),

                              SizedBox(height: 4.h),

                            ],

                            const PrayerTimesHeroCard(),

                            SizedBox(height: 16.h),

                            const QuickActionTiles(),

                            SizedBox(height: 16.h),

                            if (widget.isPilgrim) ...[
                              const _SosHomeCard(),
                              SizedBox(height: 16.h),
                            ],

                            JourneyCtaCard(isPilgrim: widget.isPilgrim),

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

                    if (widget.isPilgrim)
                      const SliverToBoxAdapter(
                        child: ContinueLearningCard(),
                      ),
                    SliverToBoxAdapter(
                      child: ContentStaleIndicator(snapshot: feedSnapshot),
                    ),
                    SliverToBoxAdapter(
                      child: ContentSection(
                        title: l10n.contentAnnouncementsSection,
                        items: feed?.announcements ?? const [],
                        emptyMessage: l10n.contentAnnouncementsEmpty,
                        onItemTap: widget.onContentTap,
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
                        onItemTap: widget.onContentTap,
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
                              onTopicTap: widget.onTopicTap,
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

class _SosHomeCard extends StatelessWidget {
  const _SosHomeCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Material(
      color: AppColors.error,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: () => unawaited(context.push(AppRoutes.sos)),
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: AppColors.onPrimary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  Icons.sos_rounded,
                  color: AppColors.onPrimary,
                  size: 28.sp,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.sosHomeButton,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      l10n.sosHomeSubtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.onPrimary.withValues(alpha: 0.9),
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.onPrimary.withValues(alpha: 0.9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

