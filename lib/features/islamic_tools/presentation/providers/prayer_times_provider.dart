import 'package:rafiq_alhajj/features/islamic_tools/data/prayer/prayer_times_repository.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/models/prayer_times_schedule.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/providers/location_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prayer_times_provider.g.dart';

@Riverpod(keepAlive: true)
PrayerTimesRepository prayerTimesRepository(Ref ref) =>
    PrayerTimesRepository();

@riverpod
Future<PrayerTimesSchedule> prayerTimesSchedule(Ref ref) async {
  final location = await ref.watch(deviceLocationProvider.future);
  return ref
      .read(prayerTimesRepositoryProvider)
      .buildSchedule(location: location);
}
