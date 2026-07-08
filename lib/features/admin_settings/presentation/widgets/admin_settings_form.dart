import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/admin_settings/domain/models/system_settings.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Reactive form body for the admin system settings screen.
class AdminSettingsForm extends StatelessWidget {
  const AdminSettingsForm({
    required this.form,
    required this.settings,
    required this.isSaving,
    required this.registrationOpen,
    required this.maintenanceMode,
    required this.requireDocumentsOnIntake,
    required this.autoGeneratePilgrimPassword,
    required this.allowOperatorSelfRegistration,
    required this.enablePublicContentFeed,
    required this.enableCompetitions,
    required this.enablePushNotifications,
    required this.enableInAppNotifications,
    required this.pilgrimRitualTrackingEnabled,
    required this.onRegistrationOpenChanged,
    required this.onMaintenanceModeChanged,
    required this.onRequireDocumentsChanged,
    required this.onAutoGeneratePasswordChanged,
    required this.onOperatorSelfRegistrationChanged,
    required this.onPublicContentFeedChanged,
    required this.onCompetitionsChanged,
    required this.onPushNotificationsChanged,
    required this.onInAppNotificationsChanged,
    required this.onRitualTrackingChanged,
    required this.onSubmit,
    super.key,
  });

  final FormGroup form;
  final SystemSettings? settings;
  final bool isSaving;
  final bool registrationOpen;
  final bool maintenanceMode;
  final bool requireDocumentsOnIntake;
  final bool autoGeneratePilgrimPassword;
  final bool allowOperatorSelfRegistration;
  final bool enablePublicContentFeed;
  final bool enableCompetitions;
  final bool enablePushNotifications;
  final bool enableInAppNotifications;
  final bool pilgrimRitualTrackingEnabled;
  final ValueChanged<bool> onRegistrationOpenChanged;
  final ValueChanged<bool> onMaintenanceModeChanged;
  final ValueChanged<bool> onRequireDocumentsChanged;
  final ValueChanged<bool> onAutoGeneratePasswordChanged;
  final ValueChanged<bool> onOperatorSelfRegistrationChanged;
  final ValueChanged<bool> onPublicContentFeedChanged;
  final ValueChanged<bool> onCompetitionsChanged;
  final ValueChanged<bool> onPushNotificationsChanged;
  final ValueChanged<bool> onInAppNotificationsChanged;
  final ValueChanged<bool> onRitualTrackingChanged;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ReactiveForm(
      formGroup: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StaffFormSection(
            icon: Icons.apartment_outlined,
            title: l10n.adminSettingsOrganizationSection,
            subtitle: l10n.adminSettingsOrganizationSectionHint,
            child: ResponsiveFormGrid(
              children: [
                ReactiveTextField<String>(
                  formControlName: 'organizationName',
                  decoration: InputDecoration(
                    labelText: l10n.adminSettingsOrganizationName,
                  ),
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        l10n.adminSettingsOrganizationNameRequired,
                  },
                ),
                ReactiveTextField<String>(
                  formControlName: 'hajjSeason',
                  decoration: InputDecoration(
                    labelText: l10n.adminSettingsHajjSeason,
                  ),
                ),
                ReactiveTextField<String>(
                  formControlName: 'supportEmail',
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: l10n.adminSettingsSupportEmail,
                  ),
                ),
                ReactiveTextField<String>(
                  formControlName: 'supportPhone',
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: l10n.adminSettingsSupportPhone,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          StaffFormSection(
            icon: Icons.tune_outlined,
            title: l10n.adminSettingsOperationsSection,
            subtitle: l10n.adminSettingsOperationsSectionHint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SettingSwitch(
                  title: l10n.adminSettingsRegistrationOpen,
                  subtitle: l10n.adminSettingsRegistrationOpenHint,
                  value: registrationOpen,
                  enabled: !isSaving,
                  onChanged: onRegistrationOpenChanged,
                ),
                const Divider(height: 1),
                _SettingSwitch(
                  title: l10n.adminSettingsMaintenanceMode,
                  subtitle: l10n.adminSettingsMaintenanceModeHint,
                  value: maintenanceMode,
                  enabled: !isSaving,
                  onChanged: onMaintenanceModeChanged,
                ),
                if (maintenanceMode) ...[
                  SizedBox(height: 12.h),
                  ReactiveTextField<String>(
                    formControlName: 'maintenanceMessage',
                    decoration: InputDecoration(
                      labelText: l10n.adminSettingsMaintenanceMessage,
                    ),
                    maxLines: 3,
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 20.h),
          StaffFormSection(
            icon: Icons.person_add_alt_1_outlined,
            title: l10n.adminSettingsIntakeSection,
            subtitle: l10n.adminSettingsIntakeSectionHint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SettingSwitch(
                  title: l10n.adminSettingsRequireDocuments,
                  subtitle: l10n.adminSettingsRequireDocumentsHint,
                  value: requireDocumentsOnIntake,
                  enabled: !isSaving,
                  onChanged: onRequireDocumentsChanged,
                ),
                const Divider(height: 1),
                _SettingSwitch(
                  title: l10n.adminSettingsAutoGeneratePassword,
                  subtitle: l10n.adminSettingsAutoGeneratePasswordHint,
                  value: autoGeneratePilgrimPassword,
                  enabled: !isSaving,
                  onChanged: onAutoGeneratePasswordChanged,
                ),
                const Divider(height: 1),
                _SettingSwitch(
                  title: l10n.adminSettingsOperatorSelfRegistration,
                  subtitle: l10n.adminSettingsOperatorSelfRegistrationHint,
                  value: allowOperatorSelfRegistration,
                  enabled: !isSaving,
                  onChanged: onOperatorSelfRegistrationChanged,
                ),
                SizedBox(height: 12.h),
                ReactiveTextField<String>(
                  formControlName: 'maxPilgrims',
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: l10n.adminSettingsMaxPilgrimsPerGroup,
                    helperText: l10n.adminSettingsMaxPilgrimsPerGroupHint,
                  ),
                  validationMessages: {
                    'invalidMaxPilgrims': (_) =>
                        l10n.adminSettingsMaxPilgrimsInvalid,
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          StaffFormSection(
            icon: Icons.extension_outlined,
            title: l10n.adminSettingsFeaturesSection,
            subtitle: l10n.adminSettingsFeaturesSectionHint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SettingSwitch(
                  title: l10n.adminSettingsPublicContentFeed,
                  subtitle: l10n.adminSettingsPublicContentFeedHint,
                  value: enablePublicContentFeed,
                  enabled: !isSaving,
                  onChanged: onPublicContentFeedChanged,
                ),
                const Divider(height: 1),
                _SettingSwitch(
                  title: l10n.adminSettingsCompetitions,
                  subtitle: l10n.adminSettingsCompetitionsHint,
                  value: enableCompetitions,
                  enabled: !isSaving,
                  onChanged: onCompetitionsChanged,
                ),
                const Divider(height: 1),
                _SettingSwitch(
                  title: l10n.adminSettingsRitualTracking,
                  subtitle: l10n.adminSettingsRitualTrackingHint,
                  value: pilgrimRitualTrackingEnabled,
                  enabled: !isSaving,
                  onChanged: onRitualTrackingChanged,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          StaffFormSection(
            icon: Icons.notifications_outlined,
            title: l10n.adminSettingsNotificationsSection,
            subtitle: l10n.adminSettingsNotificationsSectionHint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SettingSwitch(
                  title: l10n.adminSettingsInAppNotifications,
                  subtitle: l10n.adminSettingsInAppNotificationsHint,
                  value: enableInAppNotifications,
                  enabled: !isSaving,
                  onChanged: onInAppNotificationsChanged,
                ),
                const Divider(height: 1),
                _SettingSwitch(
                  title: l10n.adminSettingsPushNotifications,
                  subtitle: l10n.adminSettingsPushNotificationsHint,
                  value: enablePushNotifications,
                  enabled: !isSaving && AppConfig.hasFirebase,
                  onChanged: onPushNotificationsChanged,
                ),
                if (!AppConfig.hasFirebase) ...[
                  SizedBox(height: 8.h),
                  Text(
                    l10n.adminSettingsPushNotificationsUnavailable,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 20.h),
          StaffFormSection(
            icon: Icons.admin_panel_settings_outlined,
            title: l10n.adminSettingsManagementSection,
            subtitle: l10n.adminSettingsManagementSectionHint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _QuickLink(
                  label: l10n.adminOperatorsTitle,
                  route: AppRoutes.adminOperators,
                  icon: Icons.badge_outlined,
                ),
                const Divider(height: 1),
                _QuickLink(
                  label: l10n.adminGroupsTitle,
                  route: AppRoutes.adminGroups,
                  icon: Icons.groups_outlined,
                ),
                const Divider(height: 1),
                _QuickLink(
                  label: l10n.appVersionAdminTitle,
                  route: AppRoutes.adminAppVersions,
                  icon: Icons.system_update_alt_rounded,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          StaffFormSection(
            icon: Icons.cloud_outlined,
            title: l10n.adminSettingsIntegrationsSection,
            subtitle: l10n.adminSettingsIntegrationsSectionHint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _StatusRow(
                  label: l10n.adminSettingsSupabaseStatus,
                  isConfigured: AppConfig.hasSupabase,
                  l10n: l10n,
                ),
                _StatusRow(
                  label: l10n.adminSettingsFirebaseStatus,
                  isConfigured: AppConfig.hasFirebase,
                  l10n: l10n,
                ),
                if (settings?.updatedAt != null) ...[
                  SizedBox(height: 12.h),
                  Text(
                    l10n.adminSettingsLastUpdated(
                      MaterialLocalizations.of(context).formatMediumDate(
                        settings!.updatedAt!.toLocal(),
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ],
            ),
          ),
          if (!AppPlatform.isWeb) ...[
            SizedBox(height: 24.h),
            Align(
              alignment: Alignment.centerLeft,
              child: StaffFormActionButtons(
                primaryLabel: l10n.adminSettingsSave,
                onPrimary: onSubmit,
                isLoading: isSaving,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SettingSwitch extends StatelessWidget {
  const _SettingSwitch({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: enabled ? onChanged : null,
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.label,
    required this.isConfigured,
    required this.l10n,
  });

  final String label;
  final bool isConfigured;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final color = isConfigured ? AppColors.success : AppColors.textSecondary;
    final status = isConfigured
        ? l10n.adminSettingsStatusConfigured
        : l10n.adminSettingsStatusNotConfigured;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(
            isConfigured ? Icons.check_circle_outline : Icons.info_outline,
            color: color,
            size: 20.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            status,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _QuickLink extends StatelessWidget {
  const _QuickLink({
    required this.label,
    required this.route,
    required this.icon,
  });

  final String label;
  final String route;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.go(route),
    );
  }
}
