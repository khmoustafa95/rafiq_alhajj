import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/features/app_version/domain/models/app_version_policy.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class OptionalUpdateDialog extends StatelessWidget {
  const OptionalUpdateDialog({
    required this.currentVersion,
    required this.policy,
    required this.onUpdate,
    required this.onLater,
    super.key,
  });

  final String currentVersion;
  final AppVersionPolicy policy;
  final VoidCallback onUpdate;
  final VoidCallback onLater;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final notes = _releaseNotes(context, policy);

    return AlertDialog(
      icon: const Icon(Icons.new_releases_outlined),
      title: Text(l10n.appVersionOptionalTitle),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.appVersionOptionalBody(currentVersion, policy.latestVersion),
            ),
            if (notes != null && notes.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                l10n.appVersionReleaseNotes,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 6),
              Text(notes),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: onLater,
          child: Text(l10n.appVersionLater),
        ),
        FilledButton(
          onPressed: onUpdate,
          child: Text(l10n.appVersionUpdateNow),
        ),
      ],
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
