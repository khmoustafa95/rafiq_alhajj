import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens hosted legal documents configured via `--dart-define`.
abstract final class LegalUrlLauncher {
  static Future<bool> openPrivacyPolicy() =>
      _open(AppConfig.privacyPolicyUrl);

  static Future<bool> openTermsOfService() =>
      _open(AppConfig.termsOfServiceUrl);

  static Future<bool> openAccountDeletionInfo() =>
      _open(AppConfig.accountDeletionInfoUrl);

  static Future<bool> _open(String url) async {
    if (url.isEmpty) {
      return false;
    }
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return false;
    }
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static void showUnavailableSnackBar(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.legalLinkUnavailable)),
    );
  }
}
