import 'package:flutter/foundation.dart';
import 'package:rafiq_alhajj/features/app_version/domain/models/app_version_policy.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

abstract final class VersionUpdateLauncher {
  static Future<void> open(AppVersionPolicy policy) async {
    final url = policy.storeUrl?.trim();
    if (url == null || url.isEmpty) {
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      return;
    }

    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched && kDebugMode) {
      debugPrint('VersionUpdateLauncher: could not open $url');
    }
  }

  static String platformLabel(AppLocalizations l10n, String platform) {
    return switch (platform) {
      'android' => l10n.appVersionPlatformAndroid,
      'ios' => l10n.appVersionPlatformIos,
      'web' => l10n.appVersionPlatformWeb,
      _ => platform,
    };
  }
}
