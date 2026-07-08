import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class NotificationInboxHeader extends StatelessWidget {
  const NotificationInboxHeader({
    required this.unreadCount,
    required this.canMarkAll,
    required this.onMarkAll,
    required this.onRefresh,
    super.key,
  });

  final int unreadCount;
  final bool canMarkAll;
  final VoidCallback onMarkAll;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final subtitle = unreadCount > 0
        ? l10n.notificationsUnreadCount(unreadCount)
        : l10n.notificationsAllReadSubtitle;

    return Container(
      color: colorScheme.surface,
      padding: EdgeInsets.fromLTRB(sw(16), sh(14), sw(12), sh(14)),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: sw(820)),
          child: Row(
            children: [
              Container(
                width: sw(44),
                height: sw(44),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(sr(14)),
                ),
                child: Icon(
                  Icons.notifications_rounded,
                  color: AppColors.primary,
                  size: ss(24),
                ),
              ),
              SizedBox(width: sw(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.notificationsTitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: ss(20),
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: sh(2)),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: unreadCount > 0
                            ? AppColors.primary
                            : colorScheme.onSurfaceVariant,
                        fontSize: ss(13),
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (canMarkAll)
                TextButton.icon(
                  onPressed: onMarkAll,
                  icon: Icon(Icons.done_all_rounded, size: ss(18)),
                  label: Text(
                    l10n.notificationsMarkAllRead,
                    style: TextStyle(fontSize: ss(13)),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: sw(10)),
                  ),
                ),
              IconButton(
                onPressed: onRefresh,
                tooltip: l10n.notificationsRefresh,
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  Icons.refresh_rounded,
                  size: ss(22),
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
