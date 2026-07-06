import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_responsive_grid.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_shell.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/admin_dashboard_stats.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/providers/admin_analytics_providers.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_bar_chart_card.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_dashboard_quick_actions_card.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_dashboard_section_title.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_pie_chart_card.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_trip_scope_card.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_urgent_alerts_banner.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminDashboardContent extends ConsumerWidget {
  const AdminDashboardContent({super.key});

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
              AdminUrgentAlertsBanner(stats: stats, l10n: l10n),
              SizedBox(height: sh(16)),
            ],
            AdminTripScopeCard(stats: stats, l10n: l10n),
            SizedBox(height: sh(20)),
            AdminDashboardSectionTitle(
              title: l10n.adminDashboardOperationsSection,
            ),
            SizedBox(height: sh(12)),
            _OperationsStatsGrid(stats: stats, l10n: l10n),
            SizedBox(height: sh(24)),
            AdminDashboardSectionTitle(
              title: l10n.adminDashboardReadinessSection,
            ),
            SizedBox(height: sh(12)),
            _ReadinessStatsGrid(stats: stats, l10n: l10n),
            SizedBox(height: sh(24)),
            _DashboardChartsRow(stats: stats, l10n: l10n),
            SizedBox(height: sh(24)),
            AdminDashboardSectionTitle(
              title: l10n.adminDashboardEngagementSection,
            ),
            SizedBox(height: sh(12)),
            _EngagementStatsGrid(stats: stats, l10n: l10n),
            SizedBox(height: sh(16)),
            AdminBarChartCard(
              title: l10n.adminChartOperatorUploads,
              slices: stats.operatorDocumentUploads,
              l10n: l10n,
            ),
            if (AppPlatform.isWeb) ...[
              SizedBox(height: sh(24)),
              AdminDashboardQuickActionsCard(l10n: l10n),
            ] else ...[
              SizedBox(height: sh(16)),
              _MobileQuickActions(l10n: l10n),
            ],
            SizedBox(height: sh(24)),
          ],
        ),
      ),
    );
  }
}

class _OperationsStatsGrid extends StatelessWidget {
  const _OperationsStatsGrid({required this.stats, required this.l10n});

  final AdminDashboardStats stats;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return StaffResponsiveGrid(
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
    );
  }
}

class _ReadinessStatsGrid extends StatelessWidget {
  const _ReadinessStatsGrid({required this.stats, required this.l10n});

  final AdminDashboardStats stats;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return StaffResponsiveGrid(
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
    );
  }
}

class _EngagementStatsGrid extends StatelessWidget {
  const _EngagementStatsGrid({required this.stats, required this.l10n});

  final AdminDashboardStats stats;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return StaffResponsiveGrid(
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
    );
  }
}

class _DashboardChartsRow extends StatelessWidget {
  const _DashboardChartsRow({required this.stats, required this.l10n});

  final AdminDashboardStats stats;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
    );
  }
}

class _MobileQuickActions extends StatelessWidget {
  const _MobileQuickActions({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
    );
  }
}
