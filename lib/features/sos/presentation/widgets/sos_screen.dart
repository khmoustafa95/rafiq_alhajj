import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/providers/location_providers.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_alert.dart';
import 'package:rafiq_alhajj/features/sos/presentation/controllers/sos_controller.dart';
import 'package:rafiq_alhajj/features/sos/presentation/providers/sos_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class SosScreen extends ConsumerStatefulWidget {
  const SosScreen({super.key});

  @override
  ConsumerState<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends ConsumerState<SosScreen>
    with WidgetsBindingObserver {
  StreamSubscription<Position>? _positionSub;
  String? _trackingAlertId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopTracking();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final alert = ref.read(mySosAlertProvider).value;
      if (alert != null && alert.status == SosStatus.active) {
        _startTracking(alert.id);
      }
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _stopTracking();
    }
  }

  Future<Position?> _readPositionOrNull() {
    return ref.read(locationRepositoryProvider).readCurrentPositionOrNull();
  }

  void _startTracking(String alertId) {
    if (_trackingAlertId == alertId && _positionSub != null) {
      return;
    }
    _stopTracking();
    _trackingAlertId = alertId;
    _positionSub = ref
        .read(locationRepositoryProvider)
        .watchPosition()
        .listen(
      (position) {
        unawaited(
          ref
              .read(sosServiceProvider)
              .pushLocation(
                alertId: alertId,
                latitude: position.latitude,
                longitude: position.longitude,
                accuracy: position.accuracy,
              )
              .catchError((_) {}),
        );
      },
      onError: (_) {},
    );
  }

  void _stopTracking() {
    unawaited(_positionSub?.cancel());
    _positionSub = null;
    _trackingAlertId = null;
  }

  Future<void> _raise() async {
    final l10n = AppLocalizations.of(context);
    final position = await _readPositionOrNull();
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

    _startTracking(id);

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

    _stopTracking();
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
      backgroundColor: AppColors.background,
      appBar: RafiqAppBar(title: Text(l10n.sosTitle)),
      body: alertAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => _buildIdle(l10n, isBusy),
        data: (alert) {
          if (alert != null && alert.status == SosStatus.active) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _startTracking(alert.id);
              }
            });
            return _buildActive(l10n, alert, isBusy);
          }
          _stopTracking();
          return _buildIdle(l10n, isBusy);
        },
      ),
    );
  }

  Widget _buildIdle(AppLocalizations l10n, bool isBusy) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 24.h),
          Center(
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.sos_rounded, size: 64.sp, color: AppColors.error),
            ),
          ),
          SizedBox(height: 24.h),
          Card(
            color: AppColors.surface,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.textSecondary,
                    size: 20.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      l10n.sosEmergencyDisclaimer,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            l10n.sosIntro,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
          ),
          SizedBox(height: 32.h),
          FilledButton.icon(
            onPressed: isBusy ? null : _raise,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.onPrimary,
              padding: EdgeInsets.symmetric(vertical: 18.h),
            ),
            icon: isBusy
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.onPrimary,
                    ),
                  )
                : const Icon(Icons.campaign_rounded),
            label: Text(l10n.sosRaiseButton),
          ),
        ],
      ),
    );
  }

  Widget _buildActive(AppLocalizations l10n, SosAlert alert, bool isBusy) {
    final lastUpdate = alert.lastLocationAt;
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16.h),
          Center(
            child: Container(
              width: 110.w,
              height: 110.w,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.verified_user_rounded,
                size: 56.sp,
                color: AppColors.success,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            l10n.sosActiveTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          SizedBox(height: 12.h),
          Text(
            l10n.sosActiveBody,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
          ),
          SizedBox(height: 24.h),
          Container(
            decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.sosSharingLocation,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      if (lastUpdate != null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          l10n.sosLastUpdate(
                            TimeOfDay.fromDateTime(lastUpdate).format(context),
                          ),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ] else ...[
                        SizedBox(height: 4.h),
                        Text(
                          l10n.sosLocationPending,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          OutlinedButton.icon(
            onPressed: isBusy ? null : () => _cancel(alert.id),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.success,
              padding: EdgeInsets.symmetric(vertical: 16.h),
            ),
            icon: const Icon(Icons.check_circle_outline),
            label: Text(l10n.sosCancelButton),
          ),
        ],
      ),
    );
  }
}
