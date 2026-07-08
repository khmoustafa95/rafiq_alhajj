import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Short relative freshness label for staff SOS map/cards.
String formatSosLocationFreshness(DateTime lastUpdate, AppLocalizations l10n) {
  final diff = DateTime.now().difference(lastUpdate.toLocal());
  if (diff.inMinutes < 1) {
    return l10n.notificationsJustNow;
  }
  if (diff.inMinutes < 60) {
    return l10n.notificationsMinutesAgoShort(diff.inMinutes);
  }
  if (diff.inHours < 24) {
    return l10n.notificationsHoursAgoShort(diff.inHours);
  }
  return l10n.sosLastUpdate(
    '${lastUpdate.toLocal().hour.toString().padLeft(2, '0')}:'
    '${lastUpdate.toLocal().minute.toString().padLeft(2, '0')}',
  );
}
