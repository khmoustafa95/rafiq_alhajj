import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_alert.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_ping.dart';
import 'package:rafiq_alhajj/features/sos/presentation/controllers/sos_controller.dart';
import 'package:rafiq_alhajj/features/sos/presentation/providers/sos_providers.dart';
import 'package:rafiq_alhajj/features/sos/presentation/widgets/sos_monitor_alert_card.dart';
import 'package:rafiq_alhajj/features/sos/presentation/widgets/sos_monitor_empty_state.dart';
import 'package:rafiq_alhajj/features/sos/presentation/widgets/sos_monitor_live_badge.dart';
import 'package:rafiq_alhajj/features/sos/presentation/widgets/sos_monitor_map.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

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
      _mapController.move(
        LatLng(alert.latitude!, alert.longitude!),
        16,
      );
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
          return SosMonitorEmptyState(message: l10n.sosMonitorEmpty);
        }

        final selected = alerts.firstWhere(
          (a) => a.id == _selectedId,
          orElse: () => alerts.first,
        );

        final map = SosMonitorMap(
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
            return SosMonitorAlertCard(
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
      if (activeCount > 0) SosMonitorLiveBadge(count: activeCount),
      Semantics(
        button: true,
        label: l10n.sosMonitorRefresh,
        child: IconButton(
          tooltip: l10n.sosMonitorRefresh,
          onPressed: _refresh,
          icon: const Icon(Icons.refresh_rounded),
        ),
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
