import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_shell.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/providers/admin_analytics_providers.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_bar_chart_card.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_pie_chart_card.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_bell_button.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (AppPlatform.isWeb) {
      return const _AdminDashboardWebBody();
    }
    return _AdminDashboardMobileScaffold(ref: ref);
  }
}

class _AdminDashboardMobileScaffold extends StatelessWidget {
  const _AdminDashboardMobileScaffold({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.adminDashboardTitle),
        actions: [
          const NotificationBellButton(),
          IconButton(
            onPressed: () {
              unawaited(ref.read(adminDashboardProvider.notifier).refresh());
            },
            tooltip: l10n.retry,
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: ref.read(signOutControllerProvider.notifier).signOut,
            tooltip: l10n.signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const _AdminDashboardContent(),
    );
  }
}

class _AdminDashboardWebBody extends ConsumerWidget {
  const _AdminDashboardWebBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return StaffWebPage(
      title: l10n.adminDashboardTitle,
      subtitle: l10n.adminDashboardSubtitle,
      scrollable: false,
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                l10n.staffConnectedStatus,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        IconButton(
          onPressed: () {
            unawaited(ref.read(adminDashboardProvider.notifier).refresh());
          },
          icon: const Icon(Icons.refresh_rounded),
          tooltip: l10n.retry,
        ),
      ],
      body: const _AdminDashboardContent(),
    );
  }
}

class _AdminDashboardContent extends ConsumerWidget {
  const _AdminDashboardContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final statsAsync = ref.watch(adminDashboardProvider);

    return statsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.adminDashboardLoadError),
            SizedBox(height: 12.h),
            FilledButton(
              onPressed: () {
                unawaited(ref.read(adminDashboardProvider.notifier).refresh());
              },
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
      data: (stats) => RefreshIndicator(
        onRefresh: () => ref.read(adminDashboardProvider.notifier).refresh(),
        child: ListView(
          padding: EdgeInsets.all(AppPlatform.isWeb ? 24.w : 16.w),
          children: [
            if (!AppPlatform.isWeb) ...[
              Text(
                l10n.adminDashboardSubtitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 16.h),
            ],
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 700;
                final cards = [
                  StaffStatCard(
                    label: l10n.adminStatPilgrims,
                    value: '${stats.pilgrimCount}',
                    icon: Icons.people_outline_rounded,
                    accentColor: AppColors.success,
                    badge: '+12%',
                  ),
                  StaffStatCard(
                    label: l10n.adminStatOperators,
                    value: '${stats.operatorCount}',
                    icon: Icons.engineering_outlined,
                    accentColor: AppColors.secondary,
                    badge: l10n.staffActiveNow,
                  ),
                  StaffStatCard(
                    label: l10n.adminStatRitualProgress,
                    value:
                        '${stats.ritualCompletionPercent.toStringAsFixed(0)}%',
                    icon: Icons.sync_rounded,
                    accentColor: AppColors.tertiary,
                    badge: l10n.staffStable,
                  ),
                ];

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cards
                        .map(
                          (card) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: card == cards.last ? 0 : 12.w,
                              ),
                              child: card,
                            ),
                          ),
                        )
                        .toList(),
                  );
                }

                return Column(
                  children: cards
                      .map(
                        (card) => Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: card,
                        ),
                      )
                      .toList(),
                );
              },
            ),
            SizedBox(height: 20.h),
            if (AppPlatform.isWeb)
              Container(
                decoration: AppDecorations.card(),
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.adminChartPilgrimsByGroup,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 16.h),
                    ...stats.pilgrimsByGroup.map(
                      (slice) => Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                slice.label,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Text(
                              '${slice.value.toInt()}',
                              style:
                                  Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 16.h),
            AdminBarChartCard(
              title: l10n.adminChartPilgrimsByGroup,
              slices: stats.pilgrimsByGroup,
              l10n: l10n,
            ),
            SizedBox(height: 16.h),
            AdminPieChartCard(
              title: l10n.adminChartFieldStatus,
              slices: stats.fieldStatusBreakdown,
              l10n: l10n,
            ),
            SizedBox(height: 16.h),
            AdminBarChartCard(
              title: l10n.adminChartOperatorUploads,
              slices: stats.operatorDocumentUploads,
              l10n: l10n,
            ),
            SizedBox(height: 16.h),
            if (AppPlatform.isWeb) ...[
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  FilledButton.icon(
                    onPressed: () =>
                        context.go(AppRoutes.adminNotificationSend),
                    icon: const Icon(Icons.campaign_outlined),
                    label: Text(l10n.adminSendNotification),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => context.go(AppRoutes.adminContent),
                    icon: const Icon(Icons.article_outlined),
                    label: Text(l10n.adminManageContent),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => context.go(AppRoutes.adminCompetitions),
                    icon: const Icon(Icons.emoji_events_outlined),
                    label: Text(l10n.adminManageCompetitions),
                  ),
                ],
              ),
            ] else ...[
              OutlinedButton.icon(
                onPressed: () => context.push(AppRoutes.adminNotificationSend),
                icon: const Icon(Icons.campaign_outlined),
                label: Text(l10n.adminSendNotification),
              ),
              SizedBox(height: 12.h),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRoutes.adminContent),
                icon: const Icon(Icons.article_outlined),
                label: Text(l10n.adminManageContent),
              ),
              SizedBox(height: 12.h),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRoutes.adminCompetitions),
                icon: const Icon(Icons.emoji_events_outlined),
                label: Text(l10n.adminManageCompetitions),
              ),
            ],
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
