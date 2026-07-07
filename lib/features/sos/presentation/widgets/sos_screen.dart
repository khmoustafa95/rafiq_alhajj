import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/providers/location_providers.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_alert.dart';
import 'package:rafiq_alhajj/features/sos/presentation/controllers/sos_controller.dart';
import 'package:rafiq_alhajj/features/sos/presentation/controllers/sos_location_ping_controller.dart';
import 'package:rafiq_alhajj/features/sos/presentation/providers/sos_providers.dart';
import 'package:rafiq_alhajj/features/sos/presentation/widgets/sos_active_view.dart';
import 'package:rafiq_alhajj/features/sos/presentation/widgets/sos_idle_view.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class SosScreen extends ConsumerStatefulWidget {
  const SosScreen({super.key});

  @override
  ConsumerState<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends ConsumerState<SosScreen>
    with WidgetsBindingObserver {
  late final SosLocationPingController _pingController;

  @override
  void initState() {
    super.initState();
    _pingController = SosLocationPingController(ref);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pingController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final alert = ref.read(mySosAlertProvider).value;
      if (alert != null && alert.status == SosStatus.active) {
        _pingController.start(alert.id);
      }
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _pingController.stop();
    }
  }

  Future<void> _raise() async {
    final l10n = AppLocalizations.of(context);
    final position =
        await ref.read(locationRepositoryProvider).readCurrentPositionOrNull();
    final id = await ref.read(sosRaiseProvider.notifier).raise(
          latitude: position?.latitude,
          longitude: position?.longitude,
          accuracy: position?.accuracy,
        );

    if (!mounted) {
      return;
    }

    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.sosRaiseError)),
      );
      return;
    }

    _pingController.start(id);

    if (position == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.sosLocationPermissionNeeded)),
      );
    }
  }

  Future<void> _cancel(String alertId) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.sosCancelConfirmTitle),
        content: Text(l10n.sosCancelConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.dialogCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.sosCancelConfirm),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    _pingController.stop();
    final ok = await ref.read(sosRaiseProvider.notifier).cancel(alertId);
    if (mounted && !ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).sosCancelError)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final alertAsync = ref.watch(mySosAlertProvider);
    final isBusy = ref.watch(sosRaiseProvider.select((s) => s.isLoading));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: RafiqAppBar(title: Text(l10n.sosTitle)),
      body: alertAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => SosIdleView(isBusy: isBusy, onRaise: _raise),
        data: (alert) {
          if (alert != null && alert.status == SosStatus.active) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _pingController.start(alert.id);
              }
            });
            return SosActiveView(
              alert: alert,
              isBusy: isBusy,
              onCancel: () => _cancel(alert.id),
            );
          }
          _pingController.stop();
          return SosIdleView(isBusy: isBusy, onRaise: _raise);
        },
      ),
    );
  }
}
