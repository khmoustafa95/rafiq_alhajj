import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_operator_stats.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/providers/field_operator_providers.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_stat_card.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class FieldOperatorDashboardScreen extends ConsumerWidget {
  const FieldOperatorDashboardScreen({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    ref.invalidate(fieldOperatorStatsProvider);
    ref.invalidate(fieldOperatorSearchProvider);
    await ref.read(fieldOperatorStatsProvider.future);
  }

  void _openPilgrimsWithFilter(
    BuildContext context,
    WidgetRef ref,
    String? status,
  ) {
    unawaited(
      ref.read(fieldOperatorSearchProvider.notifier).filterByStatus(status),
    );
    context.go(AppRoutes.fieldOperatorPilgrims);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final statsAsync = ref.watch(fieldOperatorStatsProvider);
    final operatorName = ref.watch(authProfileFullNameProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: RafiqAppBar(
        title: Text(l10n.fieldOperatorDashboardTitle),
        actions: [
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
              Text(l10n.fieldOperatorLoadError),
              SizedBox(height: 12.h),
              FilledButton(
                onPressed: () => _refresh(ref),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
        data: (stats) => RefreshIndicator(
          onRefresh: () => _refresh(ref),
          child: ListView(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
            children: [
              _WelcomeCard(
                name: operatorName,
                total: stats.total,
              ),
              SizedBox(height: 20.h),
              Text(
                l10n.fieldOperatorStatsTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: 4.h),
              Text(
                l10n.fieldOperatorStatsHint,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              SizedBox(height: 14.h),
              FieldOperatorStatCard(
                label: l10n.fieldOperatorStatsTotal,
                value: stats.total,
                color: AppColors.primary,
                icon: Icons.groups_outlined,
                onTap: () => _openPilgrimsWithFilter(context, ref, null),
              ),
              SizedBox(height: 12.h),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth >= 360 ? 2 : 1;
                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                    childAspectRatio: crossAxisCount == 2 ? 1.35 : 2.4,
                    children: [
                      FieldOperatorStatCard(
                        label: l10n.fieldStatusPending,
                        value: stats.pending,
                        color: AppColors.warning,
                        icon: Icons.hourglass_empty,
                        compact: true,
                        onTap: () => _openPilgrimsWithFilter(
                          context,
                          ref,
                          FieldPilgrimStatus.pending,
                        ),
                      ),
                      FieldOperatorStatCard(
                        label: l10n.fieldStatusMedicalDone,
                        value: stats.medicalDone,
                        color: AppColors.info,
                        icon: Icons.medical_services_outlined,
                        compact: true,
                        onTap: () => _openPilgrimsWithFilter(
                          context,
                          ref,
                          FieldPilgrimStatus.medicalDone,
                        ),
                      ),
                      FieldOperatorStatCard(
                        label: l10n.fieldStatusArrivedHotel,
                        value: stats.arrivedHotel,
                        color: AppColors.accentTeal,
                        icon: Icons.hotel_outlined,
                        compact: true,
                        onTap: () => _openPilgrimsWithFilter(
                          context,
                          ref,
                          FieldPilgrimStatus.arrivedHotel,
                        ),
                      ),
                      FieldOperatorStatCard(
                        label: l10n.fieldStatusInTransit,
                        value: stats.inTransit,
                        color: AppColors.accentPurple,
                        icon: Icons.directions_bus_outlined,
                        compact: true,
                        onTap: () => _openPilgrimsWithFilter(
                          context,
                          ref,
                          FieldPilgrimStatus.inTransit,
                        ),
                      ),
                      FieldOperatorStatCard(
                        label: l10n.fieldStatusCompleted,
                        value: stats.completed,
                        color: AppColors.success,
                        icon: Icons.check_circle_outline,
                        compact: true,
                        onTap: () => _openPilgrimsWithFilter(
                          context,
                          ref,
                          FieldPilgrimStatus.completed,
                        ),
                      ),
                      FieldOperatorStatCard(
                        label: l10n.fieldOperatorStatsWheelchair,
                        value: stats.needsWheelchair,
                        color: AppColors.tertiary,
                        icon: Icons.accessible_outlined,
                        compact: true,
                        onTap: () => context.go(AppRoutes.fieldOperatorPilgrims),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20.h),
              _ProgressSummary(stats: stats, l10n: l10n),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({
    required this.name,
    required this.total,
  });

  final String? name;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.fieldOperatorWelcome(name ?? l10n.fieldOperatorNavHome),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.fieldOperatorWelcomeSubtitle(total),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textMutedOnDark,
                ),
          ),
        ],
      ),
    );
  }
}

class _ProgressSummary extends StatelessWidget {
  const _ProgressSummary({
    required this.stats,
    required this.l10n,
  });

  final FieldOperatorStats stats;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (stats.total == 0) {
      return const SizedBox.shrink();
    }

    final completedRatio = stats.completed / stats.total;
    final inProgress = stats.total - stats.pending;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.fieldOperatorProgressTitle,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 12.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: LinearProgressIndicator(
                value: completedRatio,
                minHeight: 10.h,
                backgroundColor: colorScheme.surfaceContainerHighest,
                color: AppColors.success,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              l10n.fieldOperatorProgressSummary(
                stats.completed,
                inProgress,
                stats.total,
              ),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
