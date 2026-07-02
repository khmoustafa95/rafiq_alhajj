import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_wifi_onboarding_prefs.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// One-time dialog explaining Wi-Fi-only downloads (Coursera-style).
class ContentWifiOnboardingDialog extends ConsumerWidget {
  const ContentWifiOnboardingDialog({super.key});

  static Future<void> showIfNeeded(BuildContext context, WidgetRef ref) async {
    if (!context.mounted) {
      return;
    }
    final shown = await ContentWifiOnboardingPrefs.wasShown();
    if (shown || !context.mounted) {
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (context) => const ContentWifiOnboardingDialog(),
    );
    await ContentWifiOnboardingPrefs.markShown();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      icon: Icon(Icons.wifi_rounded, color: AppColors.primary, size: 32.sp),
      title: Text(l10n.contentWifiOnboardingTitle),
      content: Text(
        l10n.contentWifiOnboardingBody,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.contentWifiOnboardingLater),
        ),
        FilledButton(
          onPressed: () async {
            await ref
                .read(contentMediaDownloadControllerProvider.notifier)
                .setWifiOnly(true);
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: Text(l10n.contentWifiOnboardingConfirm),
        ),
      ],
    );
  }
}
