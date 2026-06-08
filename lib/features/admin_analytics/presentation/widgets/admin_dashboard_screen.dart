import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/network/staff_connectivity.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_responsive_grid.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
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
    final isOnline = ref.watch(staffConnectivityProvider);

    return StaffWebPage(
      title: l10n.adminDashboardTitle,
      subtitle: l10n.adminDashboardSubtitle,
      scrollable: false,
      actions: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: sw(12), vertical: sh(6)),
          decoration: BoxDecoration(
            color: (isOnline ? AppColors.success : AppColors.warning)
                .withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: (isOnline ? AppColors.success : AppColors.warning)
                  .withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isOnline ? AppColors.success : AppColors.warning,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: sw(8)),
              Text(
                isOnline ? l10n.staffConnectedStatus : l10n.staffOfflineStatus,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isOnline ? AppColors.success : AppColors.warning,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
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
      skipLoadingOnReload: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: StaffErrorView.fromError(
          l10n,
          error: error,
          onRetry: () {
            unawaited(ref.read(adminDashboardProvider.notifier).refresh());
          },
        ),
      ),
      data: (stats) => RefreshIndicator(
        onRefresh: () => ref.read(adminDashboardProvider.notifier).refresh(),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            if (!AppPlatform.isWeb) ...[
              Text(
                l10n.adminDashboardSubtitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: sh(16)),
            ],
            StaffResponsiveGrid(
              spacing: sw(16),
              children: [
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
                  value: '${stats.ritualCompletionPercent.toStringAsFixed(0)}%',
                  icon: Icons.sync_rounded,
                  accentColor: AppColors.tertiary,
                  badge: l10n.staffStable,
                ),
              ],
            ),
            SizedBox(height: sh(24)),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 960;

                final pilgrimsChart = AdminBarChartCard(
                  title: l10n.adminChartPilgrimsByGroup,
                  slices: stats.pilgrimsByGroup,
                  l10n: l10n,
                );
                final statusChart = AdminPieChartCard(
                  title: l10n.adminChartFieldStatus,
                  slices: stats.fieldStatusBreakdown,
                  l10n: l10n,
                );

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: pilgrimsChart),
                      SizedBox(width: sw(16)),
                      Expanded(child: statusChart),
                    ],
                  );
                }

                return Column(
                  children: [
                    pilgrimsChart,
                    SizedBox(height: sh(16)),
                    statusChart,
                  ],
                );
              },
            ),
            SizedBox(height: sh(16)),
            AdminBarChartCard(
              title: l10n.adminChartOperatorUploads,
              slices: stats.operatorDocumentUploads,
              l10n: l10n,
            ),
            if (AppPlatform.isWeb) ...[
              SizedBox(height: sh(24)),
              _QuickActionsCard(l10n: l10n),
            ] else ...[
              SizedBox(height: sh(16)),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRoutes.adminNotificationSend),
                icon: const Icon(Icons.campaign_outlined),
                label: Text(l10n.adminSendNotification),
              ),
              SizedBox(height: sh(12)),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRoutes.adminContent),
                icon: const Icon(Icons.article_outlined),
                label: Text(l10n.adminManageContent),
              ),
              SizedBox(height: sh(12)),
              OutlinedButton.icon(
                onPressed: () => context.push(AppRoutes.adminCompetitions),
                icon: const Icon(Icons.emoji_events_outlined),
                label: Text(l10n.adminManageCompetitions),
              ),
            ],
            SizedBox(height: sh(24)),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  const _QuickActionsCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: AppDecorations.card(),
      child: Padding(
        padding: EdgeInsets.all(sw(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.homeQuickActionsTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: sh(16)),
            Wrap(
              spacing: sw(12),
              runSpacing: sh(12),
              children: [
                FilledButton.icon(
                  onPressed: () => context.go(AppRoutes.adminNotificationSend),
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
          ],
        ),
      ),
    );
  }
}
