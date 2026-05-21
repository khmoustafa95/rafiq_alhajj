import 'package:freezed_annotation/freezed_annotation.dart';

part 'prayer_times_schedule.freezed.dart';

@freezed
abstract class PrayerTimesSchedule with _$PrayerTimesSchedule {
  const factory PrayerTimesSchedule({
    required DateTime date,
    required String fajr,
    required String sunrise,
    required String dhuhr,
    required String asr,
    required String maghrib,
    required String isha,
    required double latitude,
    required double longitude,
    required bool fromCachedLocation,
  }) = _PrayerTimesSchedule;
}
