import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/admin_dashboard_stats.dart';
import 'package:rafiq_alhajj/features/trips/presentation/widgets/trip_selector.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminTripScopeCard extends StatelessWidget {
  const AdminTripScopeCard({
    required this.stats,
    required this.l10n,
    super.key,
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
