import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_alert.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_ping.dart';
import 'package:rafiq_alhajj/features/sos/presentation/controllers/sos_controller.dart';
import 'package:rafiq_alhajj/features/sos/presentation/providers/sos_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

const _defaultCenter = LatLng(21.422487, 39.826206); // Makkah

class SosMonitorScreen extends ConsumerStatefulWidget {
  const SosMonitorScreen({super.key});

  @override
  ConsumerState<SosMonitorScreen> createState() => _SosMonitorScreenState();
}

class _SosMonitorScreenState extends ConsumerState<SosMonitorScreen> {
  final _mapController = MapController();
  String? _selectedId;

  void _select(SosAlert alert) {
    setState(() => _selectedId = alert.id);
    if (alert.hasLocation) {
      _mapController.move(LatLng(alert.latitude!, alert.longitude!), 16);
    }
  }

  Future<void> _openInMaps(SosAlert alert) async {
    if (!alert.hasLocation) {
      return;
    }
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${alert.latitude},${alert.longitude}',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _resolve(SosAlert alert) async {
    final l10n = AppLocalizations.of(context);
    final name = alert.pilgrimName ?? l10n.sosUnknownPilgrim;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.sosResolveConfirmTitle),
        content: Text(l10n.sosResolveConfirmMessage(name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.dialogCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.sosResolveConfirm),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) {
      return;
    }

    final ok = await ref.read(sosResolveProvider.notifier).resolve(alert.id);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? l10n.sosResolvedSuccess : l10n.sosResolveError),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final alertsAsync = ref.watch(activeSosAlertsProvider);

    final body = alertsAsync.when(
      skipLoadingOnReload: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => StaffErrorView.fromError(
        l10n,
        error: error,
        onRetry: () => ref.invalidate(activeSosAlertsProvider),
      ),
      data: (alerts) {
        if (alerts.isEmpty) {
          return _EmptyState(message: l10n.sosMonitorEmpty);
        }

        final selected = alerts.firstWhere(
          (a) => a.id == _selectedId,
          orElse: () => alerts.first,
        );

        final map = _SosMap(
          controller: _mapController,
          alerts: alerts,
          selected: selected,
          pings: selected.hasLocation
              ? ref.watch(sosAlertPingsProvider(selected.id)).value ??
                  const <SosPing>[]
              : const <SosPing>[],
          onSelect: _select,
        );

        final list = ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: alerts.length,
          separatorBuilder: (_, _) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            final alert = alerts[index];
            return _AlertCard(
              alert: alert,
              selected: alert.id == selected.id,
              onTap: () => _select(alert),
              onResolve: () => unawaited(_resolve(alert)),
              onOpenMaps: () => unawaited(_openInMaps(alert)),
            );
          },
        );

        return LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 900) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 3, child: map),
                  SizedBox(
                    width: 380,
                    child: list,
                  ),
                ],
              );
            }
            return Column(
              children: [
                SizedBox(height: 280.h, child: map),
                Expanded(child: list),
              ],
            );
          },
        );
      },
    );

    if (AppPlatform.isWeb) {
      return StaffWebPage(
        title: l10n.sosMonitorTitle,
        subtitle: l10n.sosMonitorSubtitle,
        scrollable: false,
        body: body,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RafiqAppBar(title: Text(l10n.sosMonitorTitle)),
      body: body,
    );
  }
}

class _SosMap extends StatelessWidget {
  const _SosMap({
    required this.controller,
    required this.alerts,
    required this.selected,
    required this.pings,
    required this.onSelect,
  });

  final MapController controller;
  final List<SosAlert> alerts;
  final SosAlert selected;
  final List<SosPing> pings;
  final ValueChanged<SosAlert> onSelect;

  @override
  Widget build(BuildContext context) {
    final located = alerts.where((a) => a.hasLocation).toList();
    final center = selected.hasLocation
        ? LatLng(selected.latitude!, selected.longitude!)
        : (located.isNotEmpty
            ? LatLng(located.first.latitude!, located.first.longitude!)
            : _defaultCenter);

    final trail = pings
        .map((p) => LatLng(p.latitude, p.longitude))
        .toList(growable: false);

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: FlutterMap(
          mapController: controller,
          options: MapOptions(
            initialCenter: center,
            initialZoom: 15,
            minZoom: 3,
            maxZoom: 19,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.rafiq_alhajj',
            ),
            if (trail.length >= 2)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: trail,
                    strokeWidth: 4,
                    color: AppColors.info,
                  ),
                ],
              ),
            MarkerLayer(
              markers: [
                for (final alert in located)
                  Marker(
                    point: LatLng(alert.latitude!, alert.longitude!),
                    width: 44,
                    height: 44,
                    child: GestureDetector(
                      onTap: () => onSelect(alert),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: alert.id == selected.id
                              ? AppColors.error
                              : AppColors.accentRed,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: alert.id == selected.id ? 3 : 2,
                          ),
                          boxShadow: const [
                            BoxShadow(color: AppColors.shadow, blurRadius: 4),
                          ],
                        ),
                        child: const Icon(
                          Icons.person_pin_circle,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({
    required this.alert,
    required this.selected,
    required this.onTap,
    required this.onResolve,
    required this.onOpenMaps,
  });

  final SosAlert alert;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onResolve;
  final VoidCallback onOpenMaps;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final name = alert.pilgrimName ?? l10n.sosUnknownPilgrim;
    final group = alert.groupName ?? l10n.sosNoGroup;
    final lastUpdate = alert.lastLocationAt;

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
        child: Container(
          decoration: AppDecorations.card(radius: AppDecorations.radiusLg).copyWith(
            border: Border.all(
              color: selected ? AppColors.error : AppColors.border,
              width: selected ? 1.5 : 1,
            ),
          ),
          padding: EdgeInsets.all(14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.sos_rounded,
                        color: AppColors.error, size: 22.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          group,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                lastUpdate != null
                    ? l10n.sosLastUpdate(
                        TimeOfDay.fromDateTime(lastUpdate).format(context))
                    : l10n.sosNoLocationYet,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: alert.hasLocation ? onOpenMaps : null,
                      icon: const Icon(Icons.map_outlined, size: 18),
                      label: Text(l10n.sosOpenInMaps),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: onResolve,
                      icon: const Icon(Icons.check_circle_outline, size: 18),
                      label: Text(l10n.sosResolveButton),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified_user_outlined,
                size: 48.sp, color: AppColors.success),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
