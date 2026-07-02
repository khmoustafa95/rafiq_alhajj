import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_preferences.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_preferences_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Pilgrim notification preferences (global-app pattern: master toggle + categories).
class NotificationSettingsCard extends ConsumerWidget {
  const NotificationSettingsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final prefsAsync = ref.watch(notificationPreferencesProvider);
    final saving = ref.watch(notificationPreferencesSaveProvider).isLoading;

    return DecoratedBox(
      decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: prefsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Text(l10n.notificationSettingsLoadError),
          data: (prefs) => _PreferencesBody(
            preferences: prefs,
            saving: saving,
            onChanged: (updated) async {
              final ok = await ref
                  .read(notificationPreferencesSaveProvider.notifier)
                  .save(updated);
              if (!context.mounted) {
                return;
              }
              if (!ok) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.notificationSettingsSaveError)),
                );
              }
            },
            onOpenSystemSettings: () {
              unawaited(
                AppSettings.openAppSettings(type: AppSettingsType.notification),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PreferencesBody extends StatefulWidget {
  const _PreferencesBody({
    required this.preferences,
    required this.saving,
    required this.onChanged,
    required this.onOpenSystemSettings,
  });

  final NotificationPreferences preferences;
  final bool saving;
  final Future<void> Function(NotificationPreferences preferences) onChanged;
  final VoidCallback onOpenSystemSettings;

  @override
  State<_PreferencesBody> createState() => _PreferencesBodyState();
}

class _PreferencesBodyState extends State<_PreferencesBody> {
  AuthorizationStatus? _authStatus;

  @override
  void initState() {
    super.initState();
    if (AppConfig.hasFirebase && !AppPlatform.isWeb) {
      unawaited(_loadAuthStatus());
    }
  }

  Future<void> _loadAuthStatus() async {
    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    if (!mounted) {
      return;
    }
    setState(() => _authStatus = settings.authorizationStatus);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final prefs = widget.preferences;
    final disabled = widget.saving || !prefs.pushEnabled;
    final denied = _authStatus == AuthorizationStatus.denied;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.notificationSettingsTitle,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        SizedBox(height: 6.h),
        Text(
          l10n.notificationSettingsSubtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        if (denied) ...[
          SizedBox(height: 12.h),
          Text(
            l10n.notificationPermissionDeniedBody,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.error,
                ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: widget.onOpenSystemSettings,
              child: Text(l10n.notificationPermissionOpenSettings),
            ),
          ),
        ],
        SizedBox(height: 8.h),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: prefs.pushEnabled,
          onChanged: widget.saving
              ? null
              : (value) => widget.onChanged(prefs.copyWith(pushEnabled: value)),
          title: Text(l10n.notificationSettingsPushMaster),
          subtitle: Text(l10n.notificationSettingsPushMasterHint),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: prefs.pushAnnouncements,
          onChanged: disabled
              ? null
              : (value) =>
                  widget.onChanged(prefs.copyWith(pushAnnouncements: value)),
          title: Text(l10n.notificationSettingsCategoryAnnouncements),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: prefs.pushContent,
          onChanged: disabled
              ? null
              : (value) => widget.onChanged(prefs.copyWith(pushContent: value)),
          title: Text(l10n.notificationSettingsCategoryContent),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: prefs.pushCompetitions,
          onChanged: disabled
              ? null
              : (value) =>
                  widget.onChanged(prefs.copyWith(pushCompetitions: value)),
          title: Text(l10n.notificationSettingsCategoryCompetitions),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: prefs.pushUrgent,
          onChanged: disabled
              ? null
              : (value) => widget.onChanged(prefs.copyWith(pushUrgent: value)),
          title: Text(l10n.notificationSettingsCategoryUrgent),
          subtitle: Text(l10n.notificationSettingsCategoryUrgentHint),
        ),
      ],
    );
  }
}
