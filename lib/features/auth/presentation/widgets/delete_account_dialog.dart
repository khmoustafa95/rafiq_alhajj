import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/delete_account_controller.dart';
import 'package:rafiq_alhajj/features/legal/application/services/legal_url_launcher.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Confirmation flow before permanently deleting a pilgrim account.
Future<void> showDeleteAccountDialog(
  BuildContext context,
  WidgetRef ref,
) async {
  final l10n = AppLocalizations.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(l10n.deleteAccountTitle),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.deleteAccountBody),
              if (AppConfig.accountDeletionInfoUrl.isNotEmpty) ...[
                SizedBox(height: 12.h),
                TextButton(
                  onPressed: () async {
                    await LegalUrlLauncher.openAccountDeletionInfo();
                  },
                  child: Text(l10n.deleteAccountLearnMore),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.deleteAccountCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.deleteAccountConfirm),
          ),
        ],
      );
    },
  );

  if (confirmed != true || !context.mounted) {
    return;
  }

  final success = await ref
      .read(deleteAccountControllerProvider.notifier)
      .deleteAccount(context);

  if (!context.mounted) {
    return;
  }

  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.deleteAccountSuccess)),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.deleteAccountError)),
    );
  }
}
