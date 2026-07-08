import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rafiq_alhajj/core/routing/root_navigator_key.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Rationale dialog before the OS location permission prompt (store policy).
abstract final class LocationPermissionPrompt {
  static Future<bool> ensureGranted({
    required LocationPermissionPurpose purpose,
  }) async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    }

    if (permission == LocationPermission.deniedForever) {
      return _showOpenSettingsDialog();
    }

    if (permission == LocationPermission.denied) {
      final accepted = await _showRationaleDialog(purpose);
      if (!accepted) {
        return false;
      }
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return _showOpenSettingsDialog();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  static Future<bool> _showRationaleDialog(
    LocationPermissionPurpose purpose,
  ) async {
    final context = rootNavigatorKey.currentContext;
    if (context == null) {
      return true;
    }

    final l10n = AppLocalizations.of(context);
    final (title, body) = switch (purpose) {
      LocationPermissionPurpose.sos => (
          l10n.locationPermissionSosTitle,
          l10n.locationPermissionSosBody,
        ),
      LocationPermissionPurpose.tools => (
          l10n.locationPermissionToolsTitle,
          l10n.locationPermissionToolsBody,
        ),
    };

    final accepted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.notificationPermissionNotNow),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.notificationPermissionAllow),
            ),
          ],
        );
      },
    );

    return accepted ?? false;
  }

  static Future<bool> _showOpenSettingsDialog() async {
    final context = rootNavigatorKey.currentContext;
    if (context == null) {
      return false;
    }

    final l10n = AppLocalizations.of(context);
    final open = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.locationPermissionDeniedTitle),
          content: Text(l10n.locationPermissionDeniedBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.notificationPermissionNotNow),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.notificationPermissionOpenSettings),
            ),
          ],
        );
      },
    );

    if (open == true) {
      await AppSettings.openAppSettings(type: AppSettingsType.location);
    }
    return false;
  }
}

enum LocationPermissionPurpose {
  tools,
  sos,
}
