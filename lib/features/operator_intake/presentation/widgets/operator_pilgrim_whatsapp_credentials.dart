import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

/// Resets a pilgrim password and opens WhatsApp with the new credentials.
abstract final class OperatorPilgrimWhatsappCredentials {
  static bool canSend(OperatorPilgrimSummary item) {
    return item.profileId != null &&
        (item.whatsappNumber?.trim().isNotEmpty ?? false);
  }

  static Future<void> send({
    required BuildContext context,
    required WidgetRef ref,
    required AppLocalizations l10n,
    required OperatorPilgrimSummary item,
  }) async {
    final profileId = item.profileId;
    final whatsapp = item.whatsappNumber?.trim() ?? '';
    if (profileId == null) {
      return;
    }
    if (whatsapp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.operatorWhatsappNoNumber)),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.operatorResetSendConfirmTitle),
        content: Text(l10n.operatorResetSendConfirmBody(item.fullName)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.dialogCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.operatorResetSendConfirm),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final credentials =
        await ref.read(pilgrimPasswordResetProvider.notifier).reset(profileId);

    if (!context.mounted) {
      return;
    }
    if (credentials == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.operatorResetFailed)),
      );
      return;
    }

    final digits = whatsapp.replaceAll(RegExp(r'[^\d]'), '');
    final message = Uri.encodeComponent(
      l10n.operatorCredentialsWhatsappMessage(
        credentials.email,
        credentials.password,
      ),
    );
    final uri = Uri.parse('https://wa.me/$digits?text=$message');
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.operatorWhatsappOpenFailed)),
      );
    }
  }
}
