import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/app_version/presentation/widgets/version_update_launcher.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminAppVersionPlatformCard extends StatelessWidget {
  const AdminAppVersionPlatformCard({
    required this.platform,
    required this.form,
    required this.isSaving,
    required this.onSave,
    super.key,
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
                ValidationMessage.required: (_) =>
                    l10n.appVersionAdminFieldRequired,
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
                ValidationMessage.required: (_) =>
                    l10n.appVersionAdminFieldRequired,
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
              child: Semantics(
                button: true,
                label: l10n.appVersionAdminSavePlatform,
                enabled: !isSaving,
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
            ),
          ],
        ),
      ),
    );
  }
}
