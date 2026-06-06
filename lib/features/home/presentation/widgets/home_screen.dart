import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/home_app_header.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/public_content_feed_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_section.dart';
import 'package:rafiq_alhajj/features/home/presentation/widgets/journey_cta_card.dart';
import 'package:rafiq_alhajj/features/home/presentation/widgets/prayer_times_hero_card.dart';
import 'package:rafiq_alhajj/features/home/presentation/widgets/quick_action_tiles.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_bell_button.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Home — US-01 public content + redesigned Hajj Companion layout.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _openContent(BuildContext context, ContentItem item) {
    unawaited(context.push(AppRoutes.contentDetailPath(item.id)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final sessionAsync = ref.watch(authSessionProvider);
    final isPilgrim =
        ref.watch(authAccessModeProvider) == AppAccessMode.pilgrim;
    final pilgrimName = ref.watch(authProfileFullNameProvider);

    if (sessionAsync.isLoading && !sessionAsync.hasValue) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (sessionAsync.hasError && !sessionAsync.hasValue) {
      return Scaffold(
        body: Center(child: Text(l10n.authErrorUnknown)),
      );
    }

    return _HomeBody(
      isPilgrim: isPilgrim,
      pilgrimName: pilgrimName,
      onContentTap: (item) => _openContent(context, item),
    );
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody({
    required this.isPilgrim,
    required this.pilgrimName,
    required this.onContentTap,
  });

  final bool isPilgrim;
  final String? pilgrimName;
  final void Function(ContentItem item) onContentTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final accessMode =
        isPilgrim ? AppAccessMode.pilgrim : AppAccessMode.guest;
    final feedAsync = ref.watch(homeContentFeedProvider(accessMode));

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
              child: feedAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, _) => Center(child: Text(l10n.contentLoadError)),
                data: (feed) {
                  return RefreshIndicator(
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(height: 4.h),
                                ],
                                const PrayerTimesHeroCard(),
                                SizedBox(height: 16.h),
                                const QuickActionTiles(),
                                SizedBox(height: 16.h),
                                JourneyCtaCard(isPilgrim: isPilgrim),
                                if (!AppPlatform.isWeb && !isPilgrim) ...[
                                  SizedBox(height: 12.h),
                                  TextButton(
                                    onPressed: () => unawaited(
                                      context.push(AppRoutes.fieldOperatorLogin),
                                    ),
                                    child: Text(l10n.homeFieldOperatorSignIn),
                                  ),
                                ],
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
                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: ContentSection(
                            title: l10n.contentVideosSection,
                            items: feed.videos,
                            emptyMessage: l10n.contentVideosEmpty,
                            onItemTap: onContentTap,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: ContentSection(
                            title: l10n.contentNewsSection,
                            items: feed.newsAndAnnouncements,
                            emptyMessage: l10n.contentNewsEmpty,
                            onItemTap: onContentTap,
                            seeAllLabel: l10n.homeNewsSeeAll,
                            layout: ContentSectionLayout.featured,
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
