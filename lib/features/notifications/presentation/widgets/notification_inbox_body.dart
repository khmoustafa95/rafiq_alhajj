import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_filter_segments.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_inbox_group_header.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_inbox_utils.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_list_tile.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class NotificationInboxBody extends StatelessWidget {
  const NotificationInboxBody({
    required this.items,
    required this.filterIndex,
    required this.onFilterChanged,
    required this.locale,
    required this.onTap,
    required this.onRefresh,
    super.key,
  });

  final List<InboxNotification> items;
  final int filterIndex;
  final ValueChanged<int> onFilterChanged;
  final String locale;
  final ValueChanged<InboxNotification> onTap;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final filtered = filterNotificationsBySegment(items, filterIndex);
    final groups = groupNotificationsByDay(filtered, l10n);

    final children = <Widget>[
      NotificationFilterSegments(
        selected: filterIndex,
        onChanged: onFilterChanged,
      ),
      SizedBox(height: sh(16)),
      if (filtered.isEmpty)
        Padding(
          padding: EdgeInsets.only(top: sh(48)),
          child: Center(
            child: Text(
              l10n.notificationsEmpty,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: ss(14),
              ),
            ),
          ),
        )
      else
        for (final group in groups) ...[
          NotificationInboxGroupHeader(
            label: group.label,
            count: group.items.length,
          ),
          SizedBox(height: sh(8)),
          for (final item in group.items)
            Padding(
              padding: EdgeInsets.only(bottom: sh(10)),
              child: NotificationListTile(
                notification: item,
                locale: locale,
                onTap: () => onTap(item),
              ),
            ),
          SizedBox(height: sh(8)),
        ],
    ];

    final list = RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primary,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(sw(16), sh(16), sw(16), sh(32)),
        children: children,
      ),
    );

    if (AppPlatform.isWeb) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: sw(820)),
          child: list,
        ),
      );
    }
    return list;
  }
}
