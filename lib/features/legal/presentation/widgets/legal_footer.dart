import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/legal/application/services/legal_url_launcher.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Privacy policy + terms links for login, profile, and other entry screens.
class LegalFooter extends StatelessWidget {
  const LegalFooter({
    this.showDataNotice = false,
    super.key,
  });

  final bool showDataNotice;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showDataNotice) ...[
          Text(
            l10n.legalDataCollectionNotice,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 12.h),
        ],
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 4.w,
          runSpacing: 4.h,
          children: [
            if (AppConfig.hasPrivacyPolicy)
              _LegalLink(
                label: l10n.legalPrivacyPolicy,
                onTap: () async {
                  if (!await LegalUrlLauncher.openPrivacyPolicy() && context.mounted) {
                    LegalUrlLauncher.showUnavailableSnackBar(context);
                  }
                },
              ),
            if (AppConfig.hasPrivacyPolicy && AppConfig.hasTermsOfService)
              Text('·', style: theme.textTheme.bodySmall),
            if (AppConfig.hasTermsOfService)
              _LegalLink(
                label: l10n.legalTermsOfService,
                onTap: () async {
                  if (!await LegalUrlLauncher.openTermsOfService() &&
                      context.mounted) {
                    LegalUrlLauncher.showUnavailableSnackBar(context);
                  }
                },
              ),
          ],
        ),
      ],
    );
  }
}

class _LegalLink extends StatelessWidget {
  const _LegalLink({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(label),
    );
  }
}
