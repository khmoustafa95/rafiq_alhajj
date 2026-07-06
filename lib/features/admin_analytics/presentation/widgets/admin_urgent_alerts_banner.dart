import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/admin_dashboard_stats.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminUrgentAlertsBanner extends StatelessWidget {
  const AdminUrgentAlertsBanner({
    required this.stats,
    required this.l10n,
    super.key,
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
