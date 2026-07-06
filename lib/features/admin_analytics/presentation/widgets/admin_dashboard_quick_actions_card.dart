import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminDashboardQuickActionsCard extends StatelessWidget {
  const AdminDashboardQuickActionsCard({required this.l10n, super.key});

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
