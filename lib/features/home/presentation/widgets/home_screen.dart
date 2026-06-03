import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/public_content_feed_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_section.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_bell_button.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Home — US-01 public content + US-03 guest/pilgrim header.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _openContent(BuildContext context, ContentItem item) {
    unawaited(context.push(AppRoutes.contentDetailPath(item.id)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final sessionAsync = ref.watch(authSessionProvider);

    return sessionAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => Scaffold(
        body: Center(child: Text(l10n.authErrorUnknown)),
      ),
      data: (session) => _HomeBody(
        isPilgrim: session.accessMode == AppAccessMode.pilgrim,
        pilgrimName: session.profileOrNull?.fullName,
        onContentTap: (item) => _openContent(context, item),
      ),
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
    final colorScheme = Theme.of(context).colorScheme;
    final accessMode =
        isPilgrim ? AppAccessMode.pilgrim : AppAccessMode.guest;
    final feedAsync = ref.watch(homeContentFeedProvider(accessMode));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        actions: [
          const NotificationBellButton(),
          if (isPilgrim)
            IconButton(
              onPressed: ref.read(signOutControllerProvider.notifier).signOut,
              tooltip: l10n.signOut,
              icon: const Icon(Icons.logout),
            ),
        ],
      ),
      body: feedAsync.when(
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
                    padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 8.h),
                    child: Column(
                      children: [
                        Icon(
                          isPilgrim
                              ? Icons.verified_user_outlined
                              : Icons.mosque_outlined,
                          size: 56.sp,
                          color: colorScheme.primary,
                        ),
                        SizedBox(height: 12.h),
                        if (isPilgrim && pilgrimName != null)
                          Text(
                            l10n.homePilgrimGreeting(pilgrimName!),
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                        SizedBox(height: 8.h),
                        Text(
                          isPilgrim
                              ? l10n.homePilgrimWelcome
                              : l10n.homeWelcome,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        if (isPilgrim)
                          FilledButton.icon(
                            onPressed: () => unawaited(
                              context.push(AppRoutes.pilgrimDashboard),
                            ),
                            icon: const Icon(Icons.hiking),
                            label: Text(l10n.homeMyHajjJourney),
                          ),
                        SizedBox(height: 12.h),
                        OutlinedButton.icon(
                          onPressed: () =>
                              unawaited(context.push(AppRoutes.tools)),
                          icon: const Icon(Icons.mosque),
                          label: Text(l10n.homeIslamicTools),
                        ),
                        SizedBox(height: 12.h),
                        OutlinedButton.icon(
                          onPressed: () =>
                              unawaited(context.push(AppRoutes.competitions)),
                          icon: const Icon(Icons.emoji_events_outlined),
                          label: Text(l10n.homeCompetitions),
                        ),
                        if (!isPilgrim) ...[
                          SizedBox(height: 12.h),
                          FilledButton.icon(
                            onPressed: () =>
                                unawaited(context.push(AppRoutes.login)),
                            icon: const Icon(Icons.login),
                            label: Text(l10n.homeSignInAsPilgrim),
                          ),
                          if (!AppPlatform.isWeb) ...[
                            SizedBox(height: 8.h),
                            TextButton(
                              onPressed: () => unawaited(
                                context.push(AppRoutes.fieldOperatorLogin),
                              ),
                              child: Text(l10n.homeFieldOperatorSignIn),
                            ),
                          ],
                        ],
                        if (!AppConfig.hasSupabase) ...[
                          SizedBox(height: 12.h),
                          Text(
                            l10n.contentSupabaseRequired,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colorScheme.error),
                            textAlign: TextAlign.center,
                          ),
                        ],
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
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              ],
            ),
          );
        },
      ),
    );
  }
}
