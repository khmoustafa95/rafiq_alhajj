import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_alert.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_ping.dart';
import 'package:rafiq_alhajj/features/sos/presentation/widgets/sos_pilgrim_marker.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

const sosMonitorDefaultCenter = LatLng(21.422487, 39.826206); // Makkah

/// OpenStreetMap view with pilgrim markers and optional location trail.
class SosMonitorMap extends StatelessWidget {
  const SosMonitorMap({
    required this.controller,
    required this.alerts,
    required this.selected,
    required this.pings,
    required this.onSelect,
    super.key,
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
            : sosMonitorDefaultCenter);

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
                    width: 200,
                    height: 86,
                    alignment: Alignment.topCenter,
                    child: SosPilgrimMarker(
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
