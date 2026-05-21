import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/models/geo_location.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/models/prayer_times_schedule.dart';

class PrayerTimesRepository {
  PrayerTimesSchedule buildSchedule({
    required GeoLocation location,
    DateTime? forDate,
  }) {
    final date = forDate ?? DateTime.now();
    final coordinates = Coordinates(location.latitude, location.longitude);
    final params = CalculationMethod.umm_al_qura.getParameters();
    final components = DateComponents(date.year, date.month, date.day);
    final prayerTimes = PrayerTimes(coordinates, components, params);
    final formatter = DateFormat.jm();

    return PrayerTimesSchedule(
      date: DateTime(date.year, date.month, date.day),
      fajr: formatter.format(prayerTimes.fajr),
      sunrise: formatter.format(prayerTimes.sunrise),
      dhuhr: formatter.format(prayerTimes.dhuhr),
      asr: formatter.format(prayerTimes.asr),
      maghrib: formatter.format(prayerTimes.maghrib),
      isha: formatter.format(prayerTimes.isha),
      latitude: location.latitude,
      longitude: location.longitude,
      fromCachedLocation: location.fromCache,
    );
  }
}
