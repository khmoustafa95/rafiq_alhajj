import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/notification_navigation.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_type.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Notification inbox — a responsive notification center (mobile + staff web).
///
/// Layout is inspired by mainstream notification centers (Gmail/iOS/Slack):
/// a compact header with an unread summary, a segmented filter, and items
/// grouped by day (Today / Yesterday / Earlier) with a clear unread emphasis.
class NotificationListScreen extends ConsumerStatefulWidget {
  const NotificationListScreen({super.key});

  @override
  ConsumerState<NotificationListScreen> createState() =>
      _NotificationListScreenState();
}

class _NotificationListScreenState
    extends ConsumerState<NotificationListScreen> {
  int _filterIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _markGuestSeen());
  }

  /// Guests have no server-side read state; opening the inbox clears the badge
  /// by recording the last-seen time locally (`GuestNotificationsSeenStore`).
  Future<void> _markGuestSeen() async {
    if (!mounted) {
      return;
    }
    final isGuest = ref.read(authAccessModeProvider) == AppAccessMode.guest;
    if (!isGuest) {
      return;
    }
    await ref.read(guestNotificationsSeenStoreProvider).markSeen();
    if (!mounted) {
      return;
    }
    ref.invalidate(unreadNotificationCountProvider);
  }

  Future<void> _onTap(
    BuildContext context,
    InboxNotification notification,
  ) async {
    final isGuest = ref.read(authAccessModeProvider) == AppAccessMode.guest;
    if (!isGuest && !notification.isRead) {
      await ref
          .read(notificationInboxProvider.notifier)
          .markAsRead(notification.id);
    }
    if (!context.mounted) {
      return;
    }
    navigateFromNotification(context, notification);
  }

  Future<void> _refresh() =>
      ref.read(notificationInboxProvider.notifier).refresh();

  @override
  Widget build(BuildContext context) {
    final inboxAsync = ref.watch(notificationInboxProvider);
    final locale = Localizations.localeOf(context).languageCode;

    final items = inboxAsync.value ?? const <InboxNotification>[];
    final unreadCount = items.where((n) => !n.isRead).length;
    final isGuest =
        ref.watch(authAccessModeProvider) == AppAccessMode.guest;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: !AppPlatform.isWeb,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _NotificationsHeader(
              total: items.length,
              unreadCount: unreadCount,
              canMarkAll: !isGuest && unreadCount > 0,
              onMarkAll: () => unawaited(
                ref.read(notificationInboxProvider.notifier).markAllAsRead(),
              ),
              onRefresh: () => unawaited(_refresh()),
            ),
            const Divider(height: 1, color: AppColors.border),
            Expanded(
              child: inboxAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (_, _) => _ErrorState(onRetry: () => unawaited(_refresh())),
                data: (data) {
                  if (data.isEmpty) {
                    return const _EmptyState();
                  }
                  return _NotificationsBody(
                    items: data,
                    filterIndex: _filterIndex,
                    onFilterChanged: (index) =>
                        setState(() => _filterIndex = index),
                    locale: locale,
                    onTap: (n) => _onTap(context, n),
                    onRefresh: _refresh,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------

class _NotificationsHeader extends StatelessWidget {
  const _NotificationsHeader({
    required this.total,
    required this.unreadCount,
    required this.canMarkAll,
    required this.onMarkAll,
    required this.onRefresh,
  });

  final int total;
  final int unreadCount;
  final bool canMarkAll;
  final VoidCallback onMarkAll;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final subtitle = unreadCount > 0
        ? l10n.notificationsUnreadCount(unreadCount)
        : l10n.notificationsAllReadSubtitle;

    return Container(
      color: AppColors.surface,
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
                            : AppColors.textSecondary,
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
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Body (filters + grouped list)
// ---------------------------------------------------------------------------

class _NotificationsBody extends StatelessWidget {
  const _NotificationsBody({
    required this.items,
    required this.filterIndex,
    required this.onFilterChanged,
    required this.locale,
    required this.onTap,
    required this.onRefresh,
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
    final filtered = _applyFilter(items, filterIndex);
    final groups = _groupByDay(filtered, l10n);

    final children = <Widget>[
      _FilterSegments(selected: filterIndex, onChanged: onFilterChanged),
      SizedBox(height: sh(16)),
      if (filtered.isEmpty)
        Padding(
          padding: EdgeInsets.only(top: sh(48)),
          child: Center(
            child: Text(
              l10n.notificationsEmpty,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: ss(14),
              ),
            ),
          ),
        )
      else
        for (final group in groups) ...[
          _GroupHeader(label: group.label, count: group.items.length),
          SizedBox(height: sh(8)),
          for (final item in group.items)
            Padding(
              padding: EdgeInsets.only(bottom: sh(10)),
              child: _NotificationTile(
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

  static List<InboxNotification> _applyFilter(
    List<InboxNotification> items,
    int filterIndex,
  ) {
    if (filterIndex == 1) {
      return items
          .where((n) => n.type == InboxNotificationType.announcement)
          .toList();
    }
    if (filterIndex == 2) {
      return items
          .where(
            (n) =>
                n.type == InboxNotificationType.system ||
                n.type == InboxNotificationType.ritualUpdate,
          )
          .toList();
    }
    return items;
  }

  static List<({String label, List<InboxNotification> items})> _groupByDay(
    List<InboxNotification> items,
    AppLocalizations l10n,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final todayItems = <InboxNotification>[];
    final yesterdayItems = <InboxNotification>[];
    final earlierItems = <InboxNotification>[];

    for (final n in items) {
      final d = n.createdAt.toLocal();
      final day = DateTime(d.year, d.month, d.day);
      if (!day.isBefore(today)) {
        todayItems.add(n);
      } else if (!day.isBefore(yesterday)) {
        yesterdayItems.add(n);
      } else {
        earlierItems.add(n);
      }
    }

    return [
      if (todayItems.isNotEmpty)
        (label: l10n.notificationsGroupToday, items: todayItems),
      if (yesterdayItems.isNotEmpty)
        (label: l10n.notificationsGroupYesterday, items: yesterdayItems),
      if (earlierItems.isNotEmpty)
        (label: l10n.notificationsGroupEarlier, items: earlierItems),
    ];
  }
}

class _FilterSegments extends StatelessWidget {
  const _FilterSegments({required this.selected, required this.onChanged});

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labels = [
      l10n.notificationsFilterAll,
      l10n.notificationsFilterGeneral,
      l10n.notificationsFilterUrgent,
    ];

    return Container(
      padding: EdgeInsets.all(sw(4)),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(sr(AppDecorations.radiusMd)),
      ),
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++)
            Expanded(
              child: _SegmentButton(
                label: labels[i],
                selected: selected == i,
                onTap: () => onChanged(i),
              ),
            ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(vertical: sh(9)),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(sr(AppDecorations.radiusSm)),
          boxShadow: selected ? AppDecorations.cardShadow : null,
        ),
        child: Center(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: selected ? AppColors.onPrimary : AppColors.chipInactiveText,
              fontWeight: FontWeight.w600,
              fontSize: ss(13),
            ),
          ),
        ),
      ),
    );
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw(4)),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
              fontSize: ss(13),
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(width: sw(8)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: sw(7), vertical: sh(1)),
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(sr(20)),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
                fontSize: ss(11),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Notification tile
// ---------------------------------------------------------------------------

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.notification,
    required this.locale,
    required this.onTap,
  });

  final InboxNotification notification;
  final String locale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final accent = _accentForType(notification.type);
    final title = notification.titleForLocale(locale);
    final body = notification.bodyForLocale(locale);
    final isRead = notification.isRead;
    final radius = BorderRadius.circular(sr(AppDecorations.radiusLg));

    return Semantics(
      label: title,
      hint: isRead ? null : l10n.notificationsNewBadge,
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Ink(
          decoration: BoxDecoration(
            color: isRead ? AppColors.surface : AppColors.notificationUnread,
            borderRadius: radius,
            border: Border.all(
              color: isRead
                  ? AppColors.border
                  : AppColors.primary.withValues(alpha: 0.35),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(sw(14)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: sw(44),
                  height: sw(44),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(sr(12)),
                  ),
                  child: Icon(
                    _iconForType(notification.type),
                    color: accent,
                    size: ss(22),
                  ),
                ),
                SizedBox(width: sw(12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight:
                                    isRead ? FontWeight.w500 : FontWeight.w700,
                                fontSize: ss(15),
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: sw(8)),
                          Text(
                            _shortTime(notification.createdAt, l10n, locale),
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: ss(11),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (!isRead) ...[
                            SizedBox(width: sw(6)),
                            Container(
                              margin: EdgeInsets.only(top: sh(5)),
                              width: sw(8),
                              height: sw(8),
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (body != null && body.isNotEmpty) ...[
                        SizedBox(height: sh(4)),
                        Text(
                          body,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: ss(13),
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      SizedBox(height: sh(8)),
                      _TypeChip(type: notification.type, accent: accent),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({required this.type, required this.accent});

  final InboxNotificationType type;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sw(8), vertical: sh(3)),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(sr(6)),
      ),
      child: Text(
        _labelForType(type, l10n),
        style: TextStyle(
          color: accent,
          fontWeight: FontWeight.w700,
          fontSize: ss(10.5),
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Empty / error states
// ---------------------------------------------------------------------------

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(sw(32)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: sw(96),
              height: sw(96),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: ss(48),
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: sh(20)),
            Text(
              l10n.notificationsEmpty,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: ss(16),
              ),
            ),
            SizedBox(height: sh(6)),
            Text(
              l10n.notificationsAllCaughtUp,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: ss(13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(sw(32)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: ss(48),
              color: AppColors.error,
            ),
            SizedBox(height: sh(16)),
            Text(
              l10n.notificationsLoadError,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: ss(14),
              ),
            ),
            SizedBox(height: sh(16)),
            FilledButton.icon(
              onPressed: onRetry,
              icon: Icon(Icons.refresh_rounded, size: ss(18)),
              label: Text(l10n.notificationsRefresh),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Type helpers
// ---------------------------------------------------------------------------

Color _accentForType(InboxNotificationType type) {
  return switch (type) {
    InboxNotificationType.announcement => AppColors.accentRed,
    InboxNotificationType.contentPublished => AppColors.accentTeal,
    InboxNotificationType.competition => AppColors.secondary,
    InboxNotificationType.ritualUpdate => AppColors.success,
    InboxNotificationType.system => AppColors.accentPurple,
  };
}

IconData _iconForType(InboxNotificationType type) {
  return switch (type) {
    InboxNotificationType.contentPublished => Icons.article_outlined,
    InboxNotificationType.competition => Icons.emoji_events_outlined,
    InboxNotificationType.ritualUpdate => Icons.check_circle_outline,
    InboxNotificationType.announcement => Icons.campaign_outlined,
    InboxNotificationType.system => Icons.directions_bus_outlined,
  };
}

String _labelForType(InboxNotificationType type, AppLocalizations l10n) {
  return switch (type) {
    InboxNotificationType.announcement => l10n.notificationsFilterGeneral,
    InboxNotificationType.contentPublished => l10n.notificationsFilterGeneral,
    InboxNotificationType.competition => l10n.notificationsFilterGeneral,
    InboxNotificationType.ritualUpdate => l10n.notificationsFilterUrgent,
    InboxNotificationType.system => l10n.notificationsFilterUrgent,
  };
}

String _shortTime(DateTime date, AppLocalizations l10n, String locale) {
  final diff = DateTime.now().difference(date.toLocal());
  if (diff.inMinutes < 1) {
    return l10n.notificationsJustNow;
  }
  if (diff.inMinutes < 60) {
    return l10n.notificationsMinutesAgoShort(diff.inMinutes);
  }
  if (diff.inHours < 24) {
    return l10n.notificationsHoursAgoShort(diff.inHours);
  }
  if (diff.inDays == 1) {
    return l10n.notificationsGroupYesterday;
  }
  return DateFormat.MMMd(locale).format(date.toLocal());
}
