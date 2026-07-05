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
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/admin_dashboard_stats.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/providers/admin_analytics_providers.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_bar_chart_card.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_pie_chart_card.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_bell_button.dart';
import 'package:rafiq_alhajj/features/trips/presentation/widgets/trip_selector.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StaffAdaptivePage(
      web: const _AdminDashboardWebBody(),
      mobile: _AdminDashboardMobileScaffold(ref: ref),
    );
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
            if (stats.activeSosCount > 0 || stats.pushFailureCount > 0) ...[
              _AdminUrgentAlertsBanner(stats: stats, l10n: l10n),
              SizedBox(height: sh(16)),
            ],
            _AdminTripScopeCard(stats: stats, l10n: l10n),
            SizedBox(height: sh(20)),
            _AdminDashboardSectionTitle(
              title: l10n.adminDashboardOperationsSection,
            ),
            SizedBox(height: sh(12)),
            StaffResponsiveGrid(
              spacing: sw(16),
              children: [
                StaffStatCard(
                  label: l10n.adminStatPilgrims,
                  value: '${stats.pilgrimCount}',
                  icon: Icons.people_outline_rounded,
                  accentColor: AppColors.success,
                  onTap: () => context.go(AppRoutes.operatorPilgrims),
                ),
                StaffStatCard(
                  label: l10n.adminStatArrivedHotel,
                  value: '${stats.arrivedHotelCount}',
                  icon: Icons.hotel_outlined,
                  accentColor: AppColors.primary,
                ),
                StaffStatCard(
                  label: l10n.adminStatInTransit,
                  value: '${stats.inTransitCount}',
                  icon: Icons.directions_walk_outlined,
                  accentColor: AppColors.secondary,
                ),
                StaffStatCard(
                  label: l10n.adminStatPendingField,
                  value: '${stats.pendingFieldCount}',
                  icon: Icons.hourglass_empty_rounded,
                  accentColor: AppColors.warning,
                ),
                StaffStatCard(
                  label: l10n.adminStatActiveSos,
                  value: '${stats.activeSosCount}',
                  icon: Icons.sos_rounded,
                  accentColor: AppColors.error,
                  onTap: stats.activeSosCount > 0
                      ? () => context.go(AppRoutes.adminSos)
                      : null,
                ),
                StaffStatCard(
                  label: l10n.adminStatUnassigned,
                  value: '${stats.unassignedPilgrimCount}',
                  icon: Icons.group_off_outlined,
                  accentColor: AppColors.tertiary,
                  onTap: () => context.go(AppRoutes.operatorPilgrims),
                ),
              ],
            ),
            SizedBox(height: sh(24)),
            _AdminDashboardSectionTitle(
              title: l10n.adminDashboardReadinessSection,
            ),
            SizedBox(height: sh(12)),
            StaffResponsiveGrid(
              spacing: sw(16),
              children: [
                StaffStatCard(
                  label: l10n.adminStatMissingTravelPermit,
                  value: '${stats.missingTravelPermitCount}',
                  icon: Icons.assignment_late_outlined,
                  accentColor: AppColors.warning,
                ),
                StaffStatCard(
                  label: l10n.adminStatMissingMedicalTest,
                  value: '${stats.missingMedicalTestCount}',
                  icon: Icons.medical_services_outlined,
                  accentColor: AppColors.warning,
                ),
                StaffStatCard(
                  label: l10n.adminStatWithoutAppLogin,
                  value: '${stats.pilgrimsWithoutLoginCount}',
                  icon: Icons.person_off_outlined,
                  accentColor: AppColors.textSecondary,
                ),
                StaffStatCard(
                  label: l10n.adminStatSpecialNeeds,
                  value: '${stats.specialNeedsCount}',
                  icon: Icons.accessible_outlined,
                  accentColor: AppColors.info,
                ),
              ],
            ),
            SizedBox(height: sh(24)),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 960;

                final statusChart = AdminPieChartCard(
                  title: l10n.adminChartFieldStatus,
                  slices: stats.fieldStatusBreakdown,
                  l10n: l10n,
                );
                final pilgrimsChart = AdminBarChartCard(
                  title: l10n.adminChartPilgrimsByGroup,
                  slices: stats.pilgrimsByGroup,
                  l10n: l10n,
                );

                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: statusChart),
                      SizedBox(width: sw(16)),
                      Expanded(child: pilgrimsChart),
                    ],
                  );
                }

                return Column(
                  children: [
                    statusChart,
                    SizedBox(height: sh(16)),
                    pilgrimsChart,
                  ],
                );
              },
            ),
            SizedBox(height: sh(24)),
            _AdminDashboardSectionTitle(
              title: l10n.adminDashboardEngagementSection,
            ),
            SizedBox(height: sh(12)),
            StaffResponsiveGrid(
              spacing: sw(16),
              children: [
                StaffStatCard(
                  label: l10n.adminStatPushReach,
                  value: '${stats.pushReachPercent}%',
                  icon: Icons.notifications_active_outlined,
                  accentColor: AppColors.primary,
                  badge: l10n.adminStatPushReachBadge(stats.pushReachPercent),
                  onTap: stats.pushFailureCount > 0
                      ? () => context.go(AppRoutes.adminPushFailures)
                      : null,
                ),
                StaffStatCard(
                  label: l10n.adminStatActiveCompetitions,
                  value: '${stats.activeCompetitionCount}',
                  icon: Icons.emoji_events_outlined,
                  accentColor: AppColors.tertiary,
                  onTap: () => context.go(AppRoutes.adminCompetitions),
                ),
                StaffStatCard(
                  label: l10n.adminStatCompetitionParticipants,
                  value: '${stats.competitionParticipantCount}',
                  icon: Icons.quiz_outlined,
                  accentColor: AppColors.secondary,
                ),
                StaffStatCard(
                  label: l10n.adminStatPublishedContent,
                  value: '${stats.publishedContentCount}',
                  icon: Icons.article_outlined,
                  accentColor: AppColors.success,
                  onTap: () => context.go(AppRoutes.adminContent),
                ),
                StaffStatCard(
                  label: l10n.adminStatOperators,
                  value: '${stats.operatorCount}',
                  icon: Icons.engineering_outlined,
                  accentColor: AppColors.secondary,
                  onTap: () => context.go(AppRoutes.adminOperators),
                ),
                StaffStatCard(
                  label: l10n.adminStatGroups,
                  value: '${stats.groupCount}',
                  icon: Icons.groups_outlined,
                  accentColor: AppColors.primary,
                  onTap: () => context.go(AppRoutes.adminGroups),
                ),
              ],
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
                onPressed: () => context.go(AppRoutes.adminSos),
                icon: const Icon(Icons.sos_rounded),
                label: Text(l10n.sosMonitorTitle),
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

class _AdminUrgentAlertsBanner extends StatelessWidget {
  const _AdminUrgentAlertsBanner({
    required this.stats,
    required this.l10n,
  });

  final AdminDashboardStats stats;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasSos = stats.activeSosCount > 0;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: (hasSos ? AppColors.error : AppColors.warning)
            .withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        border: Border.all(
          color: (hasSos ? AppColors.error : AppColors.warning)
              .withValues(alpha: 0.35),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(sw(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasSos) ...[
              Row(
                children: [
                  Icon(Icons.sos_rounded, color: AppColors.error, size: ss(22)),
                  SizedBox(width: sw(8)),
                  Expanded(
                    child: Text(
                      l10n.adminDashboardUrgentSos(stats.activeSosCount),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.error,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.adminSos),
                    child: Text(l10n.adminDashboardViewDetails),
                  ),
                ],
              ),
            ],
            if (stats.pushFailureCount > 0) ...[
              if (hasSos) SizedBox(height: sh(8)),
              Row(
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    color: AppColors.warning,
                    size: ss(22),
                  ),
                  SizedBox(width: sw(8)),
                  Expanded(
                    child: Text(
                      l10n.adminDashboardUrgentPushFailures(
                        stats.pushFailureCount,
                      ),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.adminPushFailures),
                    child: Text(l10n.adminDashboardViewDetails),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AdminTripScopeCard extends StatelessWidget {
  const _AdminTripScopeCard({
    required this.stats,
    required this.l10n,
  });

  final AdminDashboardStats stats;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final scopeLabel = stats.scopedTripLabel ?? l10n.adminDashboardAllTripsScope;

    return DecoratedBox(
      decoration: AppDecorations.themedCard(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sw(16), vertical: sh(14)),
        child: Row(
          children: [
            Icon(
              Icons.flight_takeoff_rounded,
              color: AppColors.primary,
              size: ss(24),
            ),
            SizedBox(width: sw(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.adminDashboardTripScopeLabel,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  SizedBox(height: sh(2)),
                  Text(
                    scopeLabel,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const TripSelector(),
          ],
        ),
      ),
    );
  }
}

class _AdminDashboardSectionTitle extends StatelessWidget {
  const _AdminDashboardSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
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
      decoration: AppDecorations.themedCard(context),
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
                  onPressed: () => context.go(AppRoutes.adminSos),
                  icon: const Icon(Icons.sos_rounded),
                  label: Text(l10n.sosMonitorTitle),
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
