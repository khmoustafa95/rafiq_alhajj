import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/providers/location_providers.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/providers/prayer_times_provider.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/utils/location_error_l10n.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class PrayerTimesScreen extends ConsumerWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheduleAsync = ref.watch(prayerTimesScheduleProvider);

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.toolsPrayerTimesTitle),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(deviceLocationProvider.notifier).refreshFromGps();
              ref.invalidate(prayerTimesScheduleProvider);
            },
            icon: const Icon(Icons.my_location),
            tooltip: l10n.toolsRefreshLocation,
          ),
        ],
      ),
      body: scheduleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Text(locationErrorMessage(l10n, error)),
          ),
        ),
        data: (schedule) {
          final rows = [
            (l10n.prayerFajr, schedule.fajr),
            (l10n.prayerSunrise, schedule.sunrise),
            (l10n.prayerDhuhr, schedule.dhuhr),
            (l10n.prayerAsr, schedule.asr),
            (l10n.prayerMaghrib, schedule.maghrib),
            (l10n.prayerIsha, schedule.isha),
          ];

          return ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              if (schedule.fromCachedLocation)
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Text(
                      l10n.toolsUsingCachedLocation,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              SizedBox(height: 8.h),
              Text(
                l10n.toolsCoordinates(
                  schedule.latitude.toStringAsFixed(4),
                  schedule.longitude.toStringAsFixed(4),
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 16.h),
              ...rows.map(
                (row) => Card(
                  child: ListTile(
                    title: Text(row.$1),
                    trailing: Text(
                      row.$2,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
