import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/routing/root_navigator_key.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Shows a rationale dialog before the OS permission prompt (global-app pattern).
///
/// Returns `true` when notifications are (or become) authorized.
abstract final class NotificationPermissionPrompt {
  static Future<bool> ensureGranted(FirebaseMessaging messaging) async {
    final settings = await messaging.getNotificationSettings();
    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
      case AuthorizationStatus.provisional:
        return true;
      case AuthorizationStatus.denied:
        return _showOpenSettingsDialog();
      case AuthorizationStatus.notDetermined:
        final accepted = await _showRationaleDialog();
        if (!accepted) {
          return false;
        }
        final result = await messaging.requestPermission();
        if (result.authorizationStatus == AuthorizationStatus.denied) {
          return _showOpenSettingsDialog();
        }
        return result.authorizationStatus == AuthorizationStatus.authorized ||
            result.authorizationStatus == AuthorizationStatus.provisional;
    }
  }

  static Future<bool> _showRationaleDialog() async {
    final context = rootNavigatorKey.currentContext;
    if (context == null) {
      return true;
    }

    final l10n = AppLocalizations.of(context);
    final accepted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.notificationPermissionTitle),
          content: Text(l10n.notificationPermissionBody),
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
          title: Text(l10n.notificationPermissionDeniedTitle),
          content: Text(l10n.notificationPermissionDeniedBody),
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
      await AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
    return false;
  }
}
