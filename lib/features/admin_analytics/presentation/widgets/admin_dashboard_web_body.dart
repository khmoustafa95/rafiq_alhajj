import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/network/staff_connectivity.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/providers/admin_analytics_providers.dart';
import 'package:rafiq_alhajj/features/admin_analytics/presentation/widgets/admin_dashboard_content.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminDashboardWebBody extends ConsumerWidget {
  const AdminDashboardWebBody({super.key});

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
      body: const AdminDashboardContent(),
    );
  }
}
