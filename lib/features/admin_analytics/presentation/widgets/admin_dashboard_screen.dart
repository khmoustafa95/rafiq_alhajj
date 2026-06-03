import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
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
    final l10n = AppLocalizations.of(context);
    final statsAsync = ref.watch(adminDashboardProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminDashboardTitle),
        actions: [
          const NotificationBellButton(),
          IconButton(
            onPressed: () {
              unawaited(
                ref.read(adminDashboardProvider.notifier).refresh(),
              );
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
      body: statsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.adminDashboardLoadError),
              SizedBox(height: 12.h),
              FilledButton(
                onPressed: () {
                  unawaited(
                    ref.read(adminDashboardProvider.notifier).refresh(),
                  );
                },
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        data: (stats) => RefreshIndicator(
          onRefresh: () =>
              ref.read(adminDashboardProvider.notifier).refresh(),
          child: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              Text(
                l10n.adminDashboardSubtitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  _StatCard(
                    label: l10n.adminStatPilgrims,
                    value: '${stats.pilgrimCount}',
                    icon: Icons.people_outline,
                    color: colorScheme.primary,
                  ),
                  _StatCard(
                    label: l10n.adminStatOperators,
                    value: '${stats.operatorCount}',
                    icon: Icons.engineering_outlined,
                    color: colorScheme.secondary,
                  ),
                  _StatCard(
                    label: l10n.adminStatRitualProgress,
                    value:
                        '${stats.ritualCompletionPercent.toStringAsFixed(0)}%',
                    icon: Icons.check_circle_outline,
                    color: colorScheme.tertiary,
                  ),
                ],
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
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color, size: 28.sp),
              SizedBox(height: 8.h),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(label, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
