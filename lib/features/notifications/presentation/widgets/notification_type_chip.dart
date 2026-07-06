import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_type.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_inbox_utils.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class NotificationTypeChip extends StatelessWidget {
  const NotificationTypeChip({
    required this.type,
    required this.accent,
    super.key,
  });

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
        notificationLabelForType(type, l10n),
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
