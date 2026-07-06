import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/platform/app_runtime_platform.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/utils/semantic_version.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/app_version/domain/models/app_version_policy.dart';
import 'package:rafiq_alhajj/features/app_version/domain/models/app_version_policy_input.dart';
import 'package:rafiq_alhajj/features/app_version/presentation/providers/app_version_providers.dart';
import 'package:rafiq_alhajj/features/app_version/presentation/widgets/version_update_launcher.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminAppVersionScreen extends ConsumerStatefulWidget {
  const AdminAppVersionScreen({super.key});

  @override
  ConsumerState<AdminAppVersionScreen> createState() =>
      _AdminAppVersionScreenState();
}

class _AdminAppVersionScreenState extends ConsumerState<AdminAppVersionScreen> {
  static const _platforms = ['android', 'ios', 'web'];
  final Map<String, FormGroup> _forms = {};
  bool _bound = false;

  @override
  void dispose() {
    for (final form in _forms.values) {
      form.dispose();
    }
    super.dispose();
  }

  FormGroup _formFor(String platform) {
    return _forms.putIfAbsent(
      platform,
      () => FormGroup({
        'minVersion': FormControl<String>(
          value: '1.0.0',
          validators: [
            Validators.required,
            Validators.delegate(_validateSemver),
          ],
        ),
        'latestVersion': FormControl<String>(
          value: '1.0.0',
          validators: [
            Validators.required,
            Validators.delegate(_validateSemver),
          ],
        ),
        'storeUrl': FormControl<String>(value: ''),
        'releaseNotesAr': FormControl<String>(value: ''),
        'releaseNotesEn': FormControl<String>(value: ''),
      }),
    );
  }

  Map<String, dynamic>? _validateSemver(AbstractControl<dynamic> control) {
    final value = (control.value as String?)?.trim() ?? '';
    if (!SemanticVersion.isValid(value)) {
      return {'invalidSemver': true};
    }
    return null;
  }

  void _bindPolicies(List<AppVersionPolicy> policies) {
    if (_bound) {
      return;
    }
    final byPlatform = {for (final p in policies) p.platform: p};
    for (final platform in _platforms) {
      final policy = byPlatform[platform];
      final form = _formFor(platform);
      form.control('minVersion').updateValue(policy?.minVersion ?? '1.0.0');
      form.control('latestVersion').updateValue(policy?.latestVersion ?? '1.0.0');
      form.control('storeUrl').updateValue(policy?.storeUrl ?? '');
      form.control('releaseNotesAr').updateValue(policy?.releaseNotesAr ?? '');
      form.control('releaseNotesEn').updateValue(policy?.releaseNotesEn ?? '');
    }
    _bound = true;
  }

  AppVersionPolicyInput _inputFor(String platform) {
    final form = _formFor(platform);
    return AppVersionPolicyInput(
      platform: platform,
      minVersion: form.control('minVersion').value as String,
      latestVersion: form.control('latestVersion').value as String,
      storeUrl: form.control('storeUrl').value as String?,
      releaseNotesAr: form.control('releaseNotesAr').value as String?,
      releaseNotesEn: form.control('releaseNotesEn').value as String?,
    );
  }

  Future<void> _savePlatform(String platform) async {
    final form = _formFor(platform);
    form.markAllAsTouched();
    if (!form.valid) {
      return;
    }

    final min = (form.control('minVersion').value as String).trim();
    final latest = (form.control('latestVersion').value as String).trim();
    if (SemanticVersion.compare(min, latest) > 0) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).appVersionMinGreaterThanLatest)),
      );
      return;
    }

    final ok = await ref
        .read(appVersionPolicySaveProvider.notifier)
        .save(_inputFor(platform));
    if (!mounted) {
      return;
    }
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? l10n.appVersionAdminSaveSuccess : l10n.appVersionAdminSaveError,
        ),
      ),
    );
  }

  Widget _buildBody(
    AppLocalizations l10n,
    AsyncValue<String> currentVersionAsync,
    bool isSaving,
  ) {
    final currentPlatform = AppRuntimePlatform.current.storageKey;
    final currentVersion = currentVersionAsync.asData?.value ?? '—';

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: Padding(
            padding: EdgeInsets.all(sw(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.appVersionAdminHint,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: sh(8)),
                Text(
                  l10n.appVersionAdminCurrentBuild(
                    VersionUpdateLauncher.platformLabel(l10n, currentPlatform),
                    currentVersion,
                  ),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: sh(20)),
        for (final platform in _platforms) ...[
          _PlatformPolicyCard(
            platform: platform,
            form: _formFor(platform),
            isSaving: isSaving,
            onSave: () => _savePlatform(platform),
          ),
          SizedBox(height: sh(16)),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final policiesAsync = ref.watch(appVersionPoliciesProvider);
    final currentVersionAsync = ref.watch(appCurrentVersionProvider);
    final isSaving = ref.watch(
      appVersionPolicySaveProvider.select((s) => s.isLoading),
    );

    return policiesAsync.when(
      loading: () => StaffAdaptivePage(
        web: StaffWebPage(
          title: l10n.appVersionAdminTitle,
          subtitle: l10n.appVersionAdminSubtitle,
          body: const Center(child: CircularProgressIndicator()),
        ),
        mobile: Scaffold(
          appBar: RafiqAppBar(title: Text(l10n.appVersionAdminTitle)),
          body: const Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, _) => StaffAdaptivePage(
        web: StaffWebPage(
          title: l10n.appVersionAdminTitle,
          subtitle: l10n.appVersionAdminSubtitle,
          body: StaffErrorView.fromError(
            l10n,
            error: error,
            onRetry: () => ref.invalidate(appVersionPoliciesProvider),
          ),
        ),
        mobile: Scaffold(
          appBar: RafiqAppBar(title: Text(l10n.appVersionAdminTitle)),
          body: StaffErrorView.fromError(
            l10n,
            error: error,
            onRetry: () => ref.invalidate(appVersionPoliciesProvider),
          ),
        ),
      ),
      data: (policies) {
        _bindPolicies(policies);
        final body = _buildBody(l10n, currentVersionAsync, isSaving);

        return StaffAdaptivePage(
          web: StaffWebPage(
            title: l10n.appVersionAdminTitle,
            subtitle: l10n.appVersionAdminSubtitle,
            body: body,
          ),
          mobile: Scaffold(
            appBar: RafiqAppBar(title: Text(l10n.appVersionAdminTitle)),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: body,
            ),
          ),
        );
      },
    );
  }
}

class _PlatformPolicyCard extends StatelessWidget {
  const _PlatformPolicyCard({
    required this.platform,
    required this.form,
    required this.isSaving,
    required this.onSave,
  });

  final String platform;
  final FormGroup form;
  final bool isSaving;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return StaffFormSection(
      icon: switch (platform) {
        'android' => Icons.android_rounded,
        'ios' => Icons.phone_iphone_rounded,
        _ => Icons.language_rounded,
      },
      title: VersionUpdateLauncher.platformLabel(l10n, platform),
      subtitle: l10n.appVersionAdminPlatformHint,
      child: ReactiveForm(
        formGroup: form,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReactiveTextField<String>(
              formControlName: 'minVersion',
              decoration: InputDecoration(
                labelText: l10n.appVersionAdminMinVersion,
                helperText: l10n.appVersionAdminMinVersionHint,
              ),
              validationMessages: {
                ValidationMessage.required: (_) => l10n.appVersionAdminFieldRequired,
                'invalidSemver': (_) => l10n.appVersionAdminInvalidSemver,
              },
            ),
            SizedBox(height: sh(12)),
            ReactiveTextField<String>(
              formControlName: 'latestVersion',
              decoration: InputDecoration(
                labelText: l10n.appVersionAdminLatestVersion,
                helperText: l10n.appVersionAdminLatestVersionHint,
              ),
              validationMessages: {
                ValidationMessage.required: (_) => l10n.appVersionAdminFieldRequired,
                'invalidSemver': (_) => l10n.appVersionAdminInvalidSemver,
              },
            ),
            SizedBox(height: sh(12)),
            ReactiveTextField<String>(
              formControlName: 'storeUrl',
              decoration: InputDecoration(
                labelText: l10n.appVersionAdminStoreUrl,
                helperText: l10n.appVersionAdminStoreUrlHint,
              ),
            ),
            SizedBox(height: sh(12)),
            ReactiveTextField<String>(
              formControlName: 'releaseNotesAr',
              decoration: InputDecoration(
                labelText: l10n.appVersionAdminReleaseNotesAr,
              ),
              maxLines: 3,
            ),
            SizedBox(height: sh(12)),
            ReactiveTextField<String>(
              formControlName: 'releaseNotesEn',
              decoration: InputDecoration(
                labelText: l10n.appVersionAdminReleaseNotesEn,
              ),
              maxLines: 3,
            ),
            SizedBox(height: sh(16)),
            Align(
              alignment: Alignment.centerLeft,
              child: FilledButton.icon(
                onPressed: isSaving ? null : onSave,
                icon: isSaving
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    : const Icon(Icons.save_outlined),
                label: Text(l10n.appVersionAdminSavePlatform),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
