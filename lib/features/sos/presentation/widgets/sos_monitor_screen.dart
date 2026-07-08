import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
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

  void _refresh() {
    ref.invalidate(activeSosAlertsProvider);
    final id = _selectedId;
    if (id != null) {
      ref.invalidate(sosAlertPingsProvider(id));
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
    final activeCount = alertsAsync.value?.length ?? 0;

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
          padding: EdgeInsets.all(sw(16)),
          itemCount: alerts.length,
          separatorBuilder: (_, _) => SizedBox(height: sh(10)),
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
                  Expanded(child: map),
                  SizedBox(width: sw(360), child: list),
                ],
              );
            }
            return Column(
              children: [
                SizedBox(height: sh(300), child: map),
                Expanded(child: list),
              ],
            );
          },
        );
      },
    );

    final actions = <Widget>[
      if (activeCount > 0) _LiveBadge(count: activeCount),
      IconButton(
        tooltip: l10n.sosMonitorRefresh,
        onPressed: _refresh,
        icon: const Icon(Icons.refresh_rounded),
      ),
    ];

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.sosMonitorTitle,
        subtitle: l10n.sosMonitorSubtitle,
        scrollable: false,
        actions: actions,
        body: body,
      ),
      mobile: Scaffold(
        backgroundColor: AppColors.background,
        appBar: RafiqAppBar(
          title: Text(l10n.sosMonitorTitle),
          actions: actions,
        ),
        body: body,
      ),
    );
  }
}

/// Pulsing "live" indicator with the active alert count.
class _LiveBadge extends StatelessWidget {
  const _LiveBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsetsDirectional.only(end: sw(8)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: sw(10), vertical: sh(6)),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: ss(8),
              height: ss(8),
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: sw(6)),
            Text(
              '${l10n.sosMonitorLive} · ${l10n.sosMonitorActiveCount(count)}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
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
    final l10n = AppLocalizations.of(context);
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
      padding: EdgeInsets.all(sw(16)),
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
              userAgentPackageName: 'com.rafiqalhajj.app',
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
                    width: 200,
                    height: 86,
                    alignment: Alignment.topCenter,
                    child: _PilgrimMarker(
                      name: alert.pilgrimName ?? l10n.sosUnknownPilgrim,
                      group: alert.groupName ?? l10n.sosNoGroup,
                      selected: alert.id == selected.id,
                      onTap: () => onSelect(alert),
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

/// Map flag: a callout pill showing pilgrim name + group above the location pin.
class _PilgrimMarker extends StatelessWidget {
  const _PilgrimMarker({
    required this.name,
    required this.group,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final String group;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final pinColor = selected ? AppColors.error : AppColors.accentRed;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 184),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: selected ? AppColors.error : AppColors.border,
                  width: selected ? 1.5 : 1,
                ),
                boxShadow: const [
                  BoxShadow(color: AppColors.shadow, blurRadius: 6),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.person_pin_circle,
                          size: 14, color: pinColor),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.1,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  Text(
                    group,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10.5,
                      height: 1.1,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Icon(
            Icons.location_on,
            size: 34,
            color: pinColor,
            shadows: const [
              Shadow(color: AppColors.shadow, blurRadius: 4),
            ],
          ),
        ],
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
          decoration:
              AppDecorations.card(radius: AppDecorations.radiusLg).copyWith(
            border: Border.all(
              color: selected ? AppColors.error : AppColors.border,
              width: selected ? 1.5 : 1,
            ),
          ),
          padding: EdgeInsets.all(sw(14)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: ss(40),
                    height: ss(40),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.sos_rounded,
                        color: AppColors.error, size: ss(22)),
                  ),
                  SizedBox(width: sw(12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          group,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
              SizedBox(height: sh(10)),
              Row(
                children: [
                  Icon(
                    lastUpdate != null
                        ? Icons.my_location
                        : Icons.location_searching,
                    size: ss(15),
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: sw(6)),
                  Expanded(
                    child: Text(
                      lastUpdate != null
                          ? l10n.sosLastUpdate(
                              TimeOfDay.fromDateTime(lastUpdate).format(context))
                          : l10n.sosNoLocationYet,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: sh(12)),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: alert.hasLocation ? onOpenMaps : null,
                      icon: const Icon(Icons.map_outlined, size: 18),
                      label: Text(
                        l10n.sosOpenInMaps,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(width: sw(10)),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: onResolve,
                      icon: const Icon(Icons.check_circle_outline, size: 18),
                      label: Text(
                        l10n.sosResolveButton,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
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
        padding: EdgeInsets.all(sw(32)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified_user_outlined,
                size: ss(48), color: AppColors.success),
            SizedBox(height: sh(16)),
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
