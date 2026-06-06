import 'package:rafiq_alhajj/features/islamic_tools/domain/models/prayer_times_schedule.dart';

enum PrayerSlot { fajr, sunrise, dhuhr, asr, maghrib, isha }

class PrayerSlotInfo {
  const PrayerSlotInfo({
    required this.slot,
    required this.timeLabel,
  });

  final PrayerSlot slot;
  final String timeLabel;
}

class NextPrayerInfo {
  const NextPrayerInfo({
    required this.slot,
    required this.timeLabel,
    required this.allSlots,
  });

  final PrayerSlot slot;
  final String timeLabel;
  final List<PrayerSlotInfo> allSlots;
}

NextPrayerInfo resolveNextPrayer(PrayerTimesSchedule schedule) {
  final slots = [
    PrayerSlotInfo(slot: PrayerSlot.fajr, timeLabel: schedule.fajr),
    PrayerSlotInfo(slot: PrayerSlot.sunrise, timeLabel: schedule.sunrise),
    PrayerSlotInfo(slot: PrayerSlot.dhuhr, timeLabel: schedule.dhuhr),
    PrayerSlotInfo(slot: PrayerSlot.asr, timeLabel: schedule.asr),
    PrayerSlotInfo(slot: PrayerSlot.maghrib, timeLabel: schedule.maghrib),
    PrayerSlotInfo(slot: PrayerSlot.isha, timeLabel: schedule.isha),
  ];

  final now = DateTime.now();
  PrayerSlotInfo? next;

  for (final entry in slots) {
    final parsed = _parseTime(entry.timeLabel, now);
    if (parsed != null && !parsed.isBefore(now)) {
      next = entry;
      break;
    }
  }

  next ??= slots.first;

  return NextPrayerInfo(
    slot: next.slot,
    timeLabel: next.timeLabel,
    allSlots: slots,
  );
}

DateTime? _parseTime(String label, DateTime reference) {
  try {
    final parts = label.split(' ');
    final timeParts = parts.first.split(':');
    if (timeParts.length < 2) {
      return null;
    }

    var hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1].replaceAll(RegExp(r'[^0-9]'), ''));

    if (parts.length > 1) {
      final period = parts[1].toUpperCase();
      if (period == 'PM' && hour < 12) {
        hour += 12;
      } else if (period == 'AM' && hour == 12) {
        hour = 0;
      }
    }

    return DateTime(
      reference.year,
      reference.month,
      reference.day,
      hour,
      minute,
    );
  } on Object {
    return null;
  }
}
