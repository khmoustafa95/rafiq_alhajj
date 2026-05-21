import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/providers/location_providers.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/providers/qibla_provider.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/utils/location_error_l10n.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/widgets/qibla_compass_widget.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class QiblaScreen extends ConsumerWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locationAsync = ref.watch(deviceLocationProvider);
    final qiblaAsync = ref.watch(qiblaStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.toolsQiblaTitle),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(deviceLocationProvider.notifier).refreshFromGps();
              ref.invalidate(qiblaStateProvider);
            },
            icon: const Icon(Icons.my_location),
            tooltip: l10n.toolsRefreshLocation,
          ),
        ],
      ),
      body: locationAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Text(locationErrorMessage(l10n, error)),
          ),
        ),
        data: (location) {
          return qiblaAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => Center(child: Text(l10n.toolsQiblaCompassUnavailable)),
            data: (state) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QiblaCompassWidget(state: state),
                      SizedBox(height: 24.h),
                      Text(
                        l10n.toolsQiblaBearing(
                          state.qiblaBearing.toStringAsFixed(1),
                        ),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (state.compassHeading != null) ...[
                        SizedBox(height: 8.h),
                        Text(
                          l10n.toolsCompassHeading(
                            state.compassHeading!.toStringAsFixed(1),
                          ),
                        ),
                      ],
                      SizedBox(height: 8.h),
                      Text(
                        l10n.toolsCoordinates(
                          location.latitude.toStringAsFixed(4),
                          location.longitude.toStringAsFixed(4),
                        ),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      if (location.fromCache) ...[
                        SizedBox(height: 8.h),
                        Text(
                          l10n.toolsUsingCachedLocation,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                      SizedBox(height: 8.h),
                      Text(
                        l10n.toolsQiblaHint,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
