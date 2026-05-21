import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/features/pilgrim/presentation/providers/pilgrim_providers.dart';
import 'package:rafiq_alhajj/features/pilgrim/presentation/widgets/pilgrim_logistics_card.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class PilgrimDashboardScreen extends ConsumerWidget {
  const PilgrimDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final dashboardAsync = ref.watch(pilgrimDashboardStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.pilgrimDashboardTitle),
      ),
      body: dashboardAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) {
          if (error is PilgrimAccessDeniedException) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.pilgrimSignInRequired),
                    SizedBox(height: 16.h),
                    FilledButton(
                      onPressed: () => context.go(AppRoutes.login),
                      child: Text(l10n.homeSignInAsPilgrim),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: Text(l10n.pilgrimLoadError));
        },
        data: (dashboard) {
          final progress = dashboard.totalCount == 0
              ? 0.0
              : dashboard.completedCount / dashboard.totalCount;

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(pilgrimDashboardStateProvider.notifier).refresh(),
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                if (dashboard.hasPendingSync)
                  Card(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    child: Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Text(
                        l10n.pilgrimSyncPending,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                SizedBox(height: 8.h),
                Text(
                  l10n.pilgrimRitualsProgress(
                    dashboard.completedCount,
                    dashboard.totalCount,
                  ),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 8.h),
                LinearProgressIndicator(value: progress),
                SizedBox(height: 16.h),
                ...dashboard.rituals.map((ritual) {
                  final title = isArabic
                      ? ritual.definition.titleAr
                      : ritual.definition.titleEn;
                  return Card(
                    child: CheckboxListTile(
                      value: ritual.isCompleted,
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        unawaited(
                          ref
                              .read(pilgrimDashboardStateProvider.notifier)
                              .toggleRitual(ritual.definition.key, value),
                        );
                      },
                      title: Text(title),
                      subtitle: ritual.pendingSync
                          ? Text(l10n.pilgrimRitualPendingSync)
                          : ritual.completedAt != null
                              ? Text(
                                  l10n.pilgrimRitualCompletedAt(
                                    MaterialLocalizations.of(context)
                                        .formatMediumDate(ritual.completedAt!),
                                  ),
                                )
                              : null,
                      secondary: ritual.isCompleted
                          ? Icon(
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : Icon(
                              Icons.radio_button_unchecked,
                              color:
                                  Theme.of(context).colorScheme.outline,
                            ),
                    ),
                  );
                }),
                SizedBox(height: 24.h),
                Text(
                  l10n.pilgrimLogisticsTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 8.h),
                PilgrimLogisticsCard(details: dashboard.logistics),
              ],
            ),
          );
        },
      ),
    );
  }
}
