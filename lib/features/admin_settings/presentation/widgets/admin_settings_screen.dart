import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/admin_settings/domain/models/system_settings.dart';
import 'package:rafiq_alhajj/features/admin_settings/domain/models/system_settings_input.dart';
import 'package:rafiq_alhajj/features/admin_settings/presentation/providers/system_settings_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminSettingsScreen extends ConsumerStatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  ConsumerState<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends ConsumerState<AdminSettingsScreen> {
  late final FormGroup _form;

  bool _registrationOpen = true;
  bool _maintenanceMode = false;
  bool _requireDocumentsOnIntake = true;
  bool _autoGeneratePilgrimPassword = true;
  bool _allowOperatorSelfRegistration = false;
  bool _enablePublicContentFeed = true;
  bool _enableCompetitions = true;
  bool _enablePushNotifications = true;
  bool _enableInAppNotifications = true;
  bool _pilgrimRitualTrackingEnabled = true;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'organizationName': FormControl<String>(
        value: '',
        validators: [Validators.required],
      ),
      'hajjSeason': FormControl<String>(value: ''),
      'supportEmail': FormControl<String>(value: ''),
      'supportPhone': FormControl<String>(value: ''),
      'maintenanceMessage': FormControl<String>(value: ''),
      'maxPilgrims': FormControl<String>(
        value: '',
        validators: [Validators.delegate(_validateMaxPilgrims)],
      ),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  Map<String, dynamic>? _validateMaxPilgrims(AbstractControl<dynamic> control) {
    final text = (control.value as String?)?.trim() ?? '';
    if (text.isEmpty) {
      return null;
    }
    final parsed = int.tryParse(text);
    if (parsed == null || parsed < 1) {
      return {'invalidMaxPilgrims': true};
    }
    return null;
  }

  void _bindSettings(SystemSettings settings) {
    if (_loaded) {
      return;
    }

    _form.control('organizationName').updateValue(settings.organizationName);
    _form.control('supportEmail').updateValue(settings.supportEmail ?? '');
    _form.control('supportPhone').updateValue(settings.supportPhone ?? '');
    _form.control('hajjSeason').updateValue(settings.hajjSeasonLabel ?? '');
    _form
        .control('maintenanceMessage')
        .updateValue(settings.maintenanceMessage ?? '');
    _form
        .control('maxPilgrims')
        .updateValue(settings.maxPilgrimsPerGroup?.toString() ?? '');

    _registrationOpen = settings.registrationOpen;
    _maintenanceMode = settings.maintenanceMode;
    _requireDocumentsOnIntake = settings.requireDocumentsOnIntake;
    _autoGeneratePilgrimPassword = settings.autoGeneratePilgrimPassword;
    _allowOperatorSelfRegistration = settings.allowOperatorSelfRegistration;
    _enablePublicContentFeed = settings.enablePublicContentFeed;
    _enableCompetitions = settings.enableCompetitions;
    _enablePushNotifications = settings.enablePushNotifications;
    _enableInAppNotifications = settings.enableInAppNotifications;
    _pilgrimRitualTrackingEnabled = settings.pilgrimRitualTrackingEnabled;
    _loaded = true;
  }

  int? _parseMaxPilgrims() {
    final text = (_form.control('maxPilgrims').value as String? ?? '').trim();
    if (text.isEmpty) {
      return null;
    }
    return int.tryParse(text);
  }

  SystemSettingsInput _buildInput() {
    return SystemSettingsInput(
      organizationName: _form.control('organizationName').value as String,
      supportEmail: _form.control('supportEmail').value as String,
      supportPhone: _form.control('supportPhone').value as String,
      hajjSeasonLabel: _form.control('hajjSeason').value as String,
      registrationOpen: _registrationOpen,
      maintenanceMode: _maintenanceMode,
      maintenanceMessage: _form.control('maintenanceMessage').value as String,
      requireDocumentsOnIntake: _requireDocumentsOnIntake,
      autoGeneratePilgrimPassword: _autoGeneratePilgrimPassword,
      allowOperatorSelfRegistration: _allowOperatorSelfRegistration,
      enablePublicContentFeed: _enablePublicContentFeed,
      enableCompetitions: _enableCompetitions,
      enablePushNotifications: _enablePushNotifications,
      enableInAppNotifications: _enableInAppNotifications,
      pilgrimRitualTrackingEnabled: _pilgrimRitualTrackingEnabled,
      maxPilgrimsPerGroup: _parseMaxPilgrims(),
    );
  }

  Future<void> _submit() async {
    if (!_form.valid) {
      _form.markAllAsTouched();
      return;
    }

    final maxPilgrims = _parseMaxPilgrims();
    if ((_form.control('maxPilgrims').value as String? ?? '')
            .trim()
            .isNotEmpty &&
        maxPilgrims == null) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final ok = await ref
        .read(systemSettingsSaveProvider.notifier)
        .save(_buildInput());

    if (!mounted) {
      return;
    }

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminSettingsSaveSuccess)),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.adminSettingsSaveError)),
    );
  }

  Widget _settingSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool enabled,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: enabled ? onChanged : null,
    );
  }

  Widget _statusRow({
    required String label,
    required bool isConfigured,
    required AppLocalizations l10n,
  }) {
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

  Widget _quickLink({
    required String label,
    required String route,
    required IconData icon,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.go(route),
    );
  }

  Widget _buildForm(AppLocalizations l10n, bool isSaving, SystemSettings? settings) {
    return ReactiveForm(
      formGroup: _form,
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
                _settingSwitch(
                  title: l10n.adminSettingsRegistrationOpen,
                  subtitle: l10n.adminSettingsRegistrationOpenHint,
                  value: _registrationOpen,
                  enabled: !isSaving,
                  onChanged: (value) =>
                      setState(() => _registrationOpen = value),
                ),
                const Divider(height: 1),
                _settingSwitch(
                  title: l10n.adminSettingsMaintenanceMode,
                  subtitle: l10n.adminSettingsMaintenanceModeHint,
                  value: _maintenanceMode,
                  enabled: !isSaving,
                  onChanged: (value) =>
                      setState(() => _maintenanceMode = value),
                ),
                if (_maintenanceMode) ...[
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
                _settingSwitch(
                  title: l10n.adminSettingsRequireDocuments,
                  subtitle: l10n.adminSettingsRequireDocumentsHint,
                  value: _requireDocumentsOnIntake,
                  enabled: !isSaving,
                  onChanged: (value) =>
                      setState(() => _requireDocumentsOnIntake = value),
                ),
                const Divider(height: 1),
                _settingSwitch(
                  title: l10n.adminSettingsAutoGeneratePassword,
                  subtitle: l10n.adminSettingsAutoGeneratePasswordHint,
                  value: _autoGeneratePilgrimPassword,
                  enabled: !isSaving,
                  onChanged: (value) =>
                      setState(() => _autoGeneratePilgrimPassword = value),
                ),
                const Divider(height: 1),
                _settingSwitch(
                  title: l10n.adminSettingsOperatorSelfRegistration,
                  subtitle: l10n.adminSettingsOperatorSelfRegistrationHint,
                  value: _allowOperatorSelfRegistration,
                  enabled: !isSaving,
                  onChanged: (value) =>
                      setState(() => _allowOperatorSelfRegistration = value),
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
                _settingSwitch(
                  title: l10n.adminSettingsPublicContentFeed,
                  subtitle: l10n.adminSettingsPublicContentFeedHint,
                  value: _enablePublicContentFeed,
                  enabled: !isSaving,
                  onChanged: (value) =>
                      setState(() => _enablePublicContentFeed = value),
                ),
                const Divider(height: 1),
                _settingSwitch(
                  title: l10n.adminSettingsCompetitions,
                  subtitle: l10n.adminSettingsCompetitionsHint,
                  value: _enableCompetitions,
                  enabled: !isSaving,
                  onChanged: (value) =>
                      setState(() => _enableCompetitions = value),
                ),
                const Divider(height: 1),
                _settingSwitch(
                  title: l10n.adminSettingsRitualTracking,
                  subtitle: l10n.adminSettingsRitualTrackingHint,
                  value: _pilgrimRitualTrackingEnabled,
                  enabled: !isSaving,
                  onChanged: (value) =>
                      setState(() => _pilgrimRitualTrackingEnabled = value),
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
                _settingSwitch(
                  title: l10n.adminSettingsInAppNotifications,
                  subtitle: l10n.adminSettingsInAppNotificationsHint,
                  value: _enableInAppNotifications,
                  enabled: !isSaving,
                  onChanged: (value) =>
                      setState(() => _enableInAppNotifications = value),
                ),
                const Divider(height: 1),
                _settingSwitch(
                  title: l10n.adminSettingsPushNotifications,
                  subtitle: l10n.adminSettingsPushNotificationsHint,
                  value: _enablePushNotifications,
                  enabled: !isSaving && AppConfig.hasFirebase,
                  onChanged: (value) =>
                      setState(() => _enablePushNotifications = value),
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
                _quickLink(
                  label: l10n.adminOperatorsTitle,
                  route: AppRoutes.adminOperators,
                  icon: Icons.badge_outlined,
                ),
                const Divider(height: 1),
                _quickLink(
                  label: l10n.adminGroupsTitle,
                  route: AppRoutes.adminGroups,
                  icon: Icons.groups_outlined,
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
                _statusRow(
                  label: l10n.adminSettingsSupabaseStatus,
                  isConfigured: AppConfig.hasSupabase,
                  l10n: l10n,
                ),
                _statusRow(
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
                onPrimary: _submit,
                isLoading: isSaving,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settingsAsync = ref.watch(systemSettingsProvider);
    final isSaving = ref.watch(
      systemSettingsSaveProvider.select((state) => state.isLoading),
    );

    ref.listen(
      systemSettingsSaveProvider.select((state) => state.isLoading),
      (previous, isLoading) {
        if (isLoading) {
          _form.markAsDisabled();
        } else {
          _form.markAsEnabled();
        }
      },
    );

    return settingsAsync.when(
      skipLoadingOnReload: true,
      loading: () => StaffAdaptivePage(
        web: StaffWebPage(
          title: l10n.adminSettingsTitle,
          subtitle: l10n.adminSettingsSubtitle,
          body: const Center(child: CircularProgressIndicator()),
        ),
        mobile: Scaffold(
          appBar: RafiqAppBar(title: Text(l10n.adminSettingsTitle)),
          body: const Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, _) => StaffAdaptivePage(
        web: StaffWebPage(
          title: l10n.adminSettingsTitle,
          subtitle: l10n.adminSettingsSubtitle,
          body: StaffErrorView.fromError(
            l10n,
            error: error,
            onRetry: () => ref.invalidate(systemSettingsProvider),
          ),
        ),
        mobile: Scaffold(
          appBar: RafiqAppBar(title: Text(l10n.adminSettingsTitle)),
          body: StaffErrorView.fromError(
            l10n,
            error: error,
            onRetry: () => ref.invalidate(systemSettingsProvider),
          ),
        ),
      ),
      data: (settings) {
        _bindSettings(settings);
        final form = _buildForm(l10n, isSaving, settings);

        return StaffAdaptivePage(
          web: StaffWebPage(
            title: l10n.adminSettingsTitle,
            subtitle: l10n.adminSettingsSubtitle,
            body: form,
            bottomBar: StaffFormActionsBar(
              primaryLabel: l10n.adminSettingsSave,
              onPrimary: _submit,
              isLoading: isSaving,
            ),
          ),
          mobile: Scaffold(
            appBar: RafiqAppBar(title: Text(l10n.adminSettingsTitle)),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: form,
            ),
          ),
        );
      },
    );
  }
}
