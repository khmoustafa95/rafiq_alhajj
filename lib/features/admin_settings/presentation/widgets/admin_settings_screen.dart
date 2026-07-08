import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/staff_navigation.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/admin_settings/domain/models/system_settings.dart';
import 'package:rafiq_alhajj/features/admin_settings/domain/models/system_settings_input.dart';
import 'package:rafiq_alhajj/features/admin_settings/presentation/providers/system_settings_providers.dart';
import 'package:rafiq_alhajj/features/admin_settings/presentation/widgets/admin_settings_form.dart';
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

  static Map<String, dynamic>? _validateMaxPilgrims(
    AbstractControl<dynamic> control,
  ) {
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

  void _cancel() {
    staffNavigateBack(context, fallbackRoute: AppRoutes.adminDashboard);
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

  Widget _buildForm(AppLocalizations l10n, bool isSaving, SystemSettings? settings) {
    return AdminSettingsForm(
      form: _form,
      settings: settings,
      isSaving: isSaving,
      registrationOpen: _registrationOpen,
      maintenanceMode: _maintenanceMode,
      requireDocumentsOnIntake: _requireDocumentsOnIntake,
      autoGeneratePilgrimPassword: _autoGeneratePilgrimPassword,
      allowOperatorSelfRegistration: _allowOperatorSelfRegistration,
      enablePublicContentFeed: _enablePublicContentFeed,
      enableCompetitions: _enableCompetitions,
      enablePushNotifications: _enablePushNotifications,
      enableInAppNotifications: _enableInAppNotifications,
      pilgrimRitualTrackingEnabled: _pilgrimRitualTrackingEnabled,
      onRegistrationOpenChanged: (value) =>
          setState(() => _registrationOpen = value),
      onMaintenanceModeChanged: (value) =>
          setState(() => _maintenanceMode = value),
      onRequireDocumentsChanged: (value) =>
          setState(() => _requireDocumentsOnIntake = value),
      onAutoGeneratePasswordChanged: (value) =>
          setState(() => _autoGeneratePilgrimPassword = value),
      onOperatorSelfRegistrationChanged: (value) =>
          setState(() => _allowOperatorSelfRegistration = value),
      onPublicContentFeedChanged: (value) =>
          setState(() => _enablePublicContentFeed = value),
      onCompetitionsChanged: (value) =>
          setState(() => _enableCompetitions = value),
      onPushNotificationsChanged: (value) =>
          setState(() => _enablePushNotifications = value),
      onInAppNotificationsChanged: (value) =>
          setState(() => _enableInAppNotifications = value),
      onRitualTrackingChanged: (value) =>
          setState(() => _pilgrimRitualTrackingEnabled = value),
      onSubmit: _submit,
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
              secondaryLabel: l10n.dialogCancel,
              onSecondary: isSaving ? null : _cancel,
              isLoading: isSaving,
            ),
          ),
          mobile: Scaffold(
            appBar: RafiqAppBar(title: Text(l10n.adminSettingsTitle)),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: form,
            ),
            bottomNavigationBar: StaffFormMobileActionsBar(
              primaryLabel: l10n.adminSettingsSave,
              onPrimary: _submit,
              secondaryLabel: l10n.dialogCancel,
              onSecondary: isSaving ? null : _cancel,
              isLoading: isSaving,
            ),
          ),
        );
      },
    );
  }
}
