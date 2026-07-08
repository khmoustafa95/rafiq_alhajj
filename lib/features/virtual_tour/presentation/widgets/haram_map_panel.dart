import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/virtual_tour/domain/data/haram_landmarks.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class HaramMapPanel extends StatefulWidget {
  const HaramMapPanel({super.key});

  @override
  State<HaramMapPanel> createState() => _HaramMapPanelState();
}

class _HaramMapPanelState extends State<HaramMapPanel> {
  final _mapController = MapController();

  void _showLandmarkSheet(HaramLandmark landmark) {
    final lang = Localizations.localeOf(context).languageCode;
    unawaited(showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        landmark.color.withValues(alpha: 0.12),
                    child: Icon(landmark.icon, color: landmark.color),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      landmark.titleFor(lang),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                landmark.summaryFor(lang),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8.h),
              Text(
                '${AppLocalizations.of(context).toolsVirtualTourRitualLabel}: ${landmark.ritualFor(lang)}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: landmark.color,
                    ),
              ),
            ],
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
          child: Text(
            l10n.toolsVirtualTourMapHint,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: kaabaLatLng,
                  initialZoom: 16.2,
                  minZoom: 14,
                  maxZoom: 19,
                  onTap: (_, _) {},
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.rafiqalhajj.app',
                  ),
                  MarkerLayer(
                    markers: haramLandmarks
                        .map(
                          (landmark) => Marker(
                            point: landmark.location,
                            width: 44,
                            height: 44,
                            child: GestureDetector(
                              onTap: () => _showLandmarkSheet(landmark),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: landmark.color,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.shadow,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  landmark.icon,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _mapController.move(kaabaLatLng, 16.5),
                  icon: const Icon(Icons.center_focus_strong_rounded),
                  label: Text(l10n.toolsVirtualTourCenterKaaba),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
