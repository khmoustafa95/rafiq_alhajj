import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/providers/prayer_times_provider.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/utils/prayer_times_utils.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class PrayerTimesHeroCard extends ConsumerWidget {
  const PrayerTimesHeroCard({super.key});

  String _slotLabel(AppLocalizations l10n, PrayerSlot slot) {
    return switch (slot) {
      PrayerSlot.fajr => l10n.prayerFajr,
      PrayerSlot.sunrise => l10n.prayerSunrise,
      PrayerSlot.dhuhr => l10n.prayerDhuhr,
      PrayerSlot.asr => l10n.prayerAsr,
      PrayerSlot.maghrib => l10n.prayerMaghrib,
      PrayerSlot.isha => l10n.prayerIsha,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final scheduleAsync = ref.watch(prayerTimesScheduleProvider);

    return scheduleAsync.when(
      loading: () => Container(
        height: 180.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.onPrimary),
        ),
      ),
      error: (_, _) => const SizedBox.shrink(),
      data: (schedule) {
        final next = resolveNextPrayer(schedule);
        final displaySlots = next.allSlots
            .where((s) => s.slot != PrayerSlot.maghrib && s.slot != PrayerSlot.isha)
            .take(4)
            .toList();

        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryDark, AppColors.primary],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -10,
                child: Icon(
                  Icons.hexagon_outlined,
                  size: 140.sp,
                  color: AppColors.onPrimary.withValues(alpha: 0.06),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.homeNextPrayer,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: AppColors.textMutedOnDark),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                _slotLabel(l10n, next.slot),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(color: AppColors.textOnDark),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              l10n.homePrayerLocation,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: AppColors.textMutedOnDark),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              next.timeLabel,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: AppColors.textOnDark),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: displaySlots.map((entry) {
                        final isActive = entry.slot == next.slot;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: entry == displaySlots.last ? 0 : 6.w,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.h,
                                horizontal: 4.w,
                              ),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.secondary
                                    : AppColors.onPrimary
                                        .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(10),
                                border: isActive
                                    ? null
                                    : Border.all(
                                        color: AppColors.onPrimary
                                            .withValues(alpha: 0.25),
                                      ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    _slotLabel(l10n, entry.slot),
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: isActive
                                          ? AppColors.primaryDark
                                          : AppColors.textOnDark,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    entry.timeLabel,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: isActive
                                          ? AppColors.primaryDark
                                          : AppColors.textMutedOnDark,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
