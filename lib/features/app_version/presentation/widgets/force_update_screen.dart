import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/app_version/domain/models/app_version_policy.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({
    required this.currentVersion,
    required this.policy,
    required this.onUpdate,
    super.key,
  });

  final String currentVersion;
  final AppVersionPolicy policy;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final notes = _releaseNotes(context, policy);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: sw(420)),
              child: Padding(
                padding: EdgeInsets.all(sw(24)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.system_update_alt_rounded,
                      size: ss(64),
                      color: AppColors.primary,
                    ),
                    SizedBox(height: sh(20)),
                    Text(
                      l10n.appVersionForceTitle,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: sh(12)),
                    Text(
                      l10n.appVersionForceBody(
                        currentVersion,
                        policy.latestVersion,
                      ),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    if (notes != null && notes.isNotEmpty) ...[
                      SizedBox(height: sh(20)),
                      DecoratedBox(
                        decoration: AppDecorations.themedCard(context),
                        child: Padding(
                          padding: EdgeInsets.all(sw(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                l10n.appVersionReleaseNotes,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: sh(8)),
                              Text(notes),
                            ],
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: sh(28)),
                    FilledButton.icon(
                      onPressed: policy.storeUrl?.trim().isNotEmpty == true
                          ? onUpdate
                          : null,
                      icon: const Icon(Icons.download_rounded),
                      label: Text(l10n.appVersionUpdateNow),
                    ),
                    if (policy.storeUrl?.trim().isEmpty ?? true) ...[
                      SizedBox(height: sh(12)),
                      Text(
                        l10n.appVersionStoreUrlMissing,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.warning,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _releaseNotes(BuildContext context, AppVersionPolicy policy) {
    final locale = Localizations.localeOf(context).languageCode;
    if (locale == 'ar') {
      return policy.releaseNotesAr ?? policy.releaseNotesEn;
    }
    return policy.releaseNotesEn ?? policy.releaseNotesAr;
  }
}
