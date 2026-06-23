import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/home_app_header.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/notification_navigation.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_type.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class NotificationListScreen extends ConsumerStatefulWidget {
  const NotificationListScreen({super.key});

  @override
  ConsumerState<NotificationListScreen> createState() =>
      _NotificationListScreenState();
}

class _NotificationListScreenState extends ConsumerState<NotificationListScreen> {
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
    final isGuest =
        ref.read(authAccessModeProvider) == AppAccessMode.guest;
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final inboxAsync = ref.watch(notificationInboxProvider);
    final locale = Localizations.localeOf(context).languageCode;
    final filters = [
      l10n.notificationsFilterAll,
      l10n.notificationsFilterGeneral,
      l10n.notificationsFilterUrgent,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeAppHeader(
              title: l10n.notificationsTitle,
              actions: const [],
            ),
            const Divider(height: 1),
            Expanded(
              child: inboxAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (_, _) =>
                    Center(child: Text(l10n.notificationsLoadError)),
                data: (items) {
                  if (items.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Text(
                          l10n.notificationsEmpty,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    );
                  }

                  final featured = items.first;
                  final filtered = _filterItems(items);

                  return RefreshIndicator(
                    onRefresh: () =>
                        ref.read(notificationInboxProvider.notifier).refresh(),
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 96.h),
                      children: [
                        _FeaturedNotificationCard(
                          notification: featured,
                          locale: locale,
                          onTap: () => _onTap(context, featured),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                l10n.notificationsLatestUpdates,
                                style:
                                    Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            const _MarkAllReadText(),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          height: 40.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: filters.length,
                            separatorBuilder: (_, _) => SizedBox(width: 8.w),
                            itemBuilder: (context, index) {
                              final selected = _filterIndex == index;
                              return FilterChip(
                                label: Text(filters[index]),
                                selected: selected,
                                onSelected: (_) {
                                  setState(() => _filterIndex = index);
                                },
                                showCheckmark: false,
                                labelStyle: TextStyle(
                                  color: selected
                                      ? AppColors.onPrimary
                                      : AppColors.chipInactiveText,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ...filtered.map(
                          (item) => Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: _NotificationCard(
                              notification: item,
                              locale: locale,
                              onTap: () => _onTap(context, item),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<InboxNotification> _filterItems(List<InboxNotification> items) {
    if (_filterIndex == 0) {
      return items;
    }
    if (_filterIndex == 1) {
      return items
          .where((n) => n.type == InboxNotificationType.announcement)
          .toList();
    }
    return items
        .where(
          (n) =>
              n.type == InboxNotificationType.system ||
              n.type == InboxNotificationType.ritualUpdate,
        )
        .toList();
  }
}

class _FeaturedNotificationCard extends StatelessWidget {
  const _FeaturedNotificationCard({
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
    final title = notification.titleForLocale(locale);
    final body = notification.bodyForLocale(locale);

    return Material(
      borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              height: 200.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1E3A5F),
                    Color(0xFF0F172A),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.75),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.fabGold,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        size: 14.sp, color: AppColors.primaryDark),
                    SizedBox(width: 4.w),
                    Text(
                      l10n.notificationsUrgentBadge,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _relativeLabel(notification.createdAt, l10n, locale),
                    style: TextStyle(
                      color: AppColors.onPrimary.withValues(alpha: 0.8),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (body != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      body,
                      style: TextStyle(
                        color: AppColors.onPrimary.withValues(alpha: 0.85),
                        fontSize: 13.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({
    required this.notification,
    required this.locale,
    required this.onTap,
  });

  final InboxNotification notification;
  final String locale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = _accentForType(notification.type);
    final title = notification.titleForLocale(locale);
    final body = notification.bodyForLocale(locale);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: DecoratedBox(
          decoration: AppDecorations.card(),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(AppDecorations.radiusMd),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(14.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            _iconForType(notification.type),
                            color: accent,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: notification.isRead
                                          ? FontWeight.w500
                                          : FontWeight.w700,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (body != null) ...[
                                SizedBox(height: 4.h),
                                Text(
                                  body,
                                  style:
                                      Theme.of(context).textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          _shortTime(notification.createdAt, locale),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MarkAllReadText extends ConsumerWidget {
  const _MarkAllReadText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGuest =
        ref.watch(authAccessModeProvider) == AppAccessMode.guest;
    if (isGuest) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context);
    final hasUnread = ref.watch(
      notificationInboxProvider.select(
        (async) => async.value?.any((item) => !item.isRead) ?? false,
      ),
    );

    if (!hasUnread) {
      return const SizedBox.shrink();
    }

    return TextButton(
      onPressed: () => unawaited(
        ref.read(notificationInboxProvider.notifier).markAllAsRead(),
      ),
      child: Text(l10n.notificationsMarkAllRead),
    );
  }
}

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

String _shortTime(DateTime date, String locale) {
  final diff = DateTime.now().difference(date.toLocal());
  if (diff.inMinutes < 60) {
    return '${diff.inMinutes.clamp(1, 59)}';
  }
  if (diff.inHours < 24) {
    return '${diff.inHours}h';
  }
  if (diff.inDays == 1) {
    return locale == 'ar' ? 'أمس' : '1d';
  }
  return DateFormat.MMMd(locale).format(date.toLocal());
}

String _relativeLabel(
  DateTime date,
  AppLocalizations l10n,
  String locale,
) {
  final diff = DateTime.now().difference(date.toLocal());
  if (diff.inMinutes < 60) {
    return l10n.notificationsMinutesAgo(diff.inMinutes.clamp(1, 59));
  }
  return DateFormat.yMMMd(locale).add_Hm().format(date.toLocal());
}
