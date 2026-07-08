import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/pilgrim_export_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

void showPilgrimExportSnackBar(
  BuildContext context,
  AppLocalizations l10n,
  PilgrimExportOutcome? outcome,
) {
  final String message;
  if (outcome == null) {
    message = l10n.exportFailed;
  } else if (outcome.empty) {
    message = l10n.exportEmpty;
  } else if (outcome.savedPath != null) {
    message = l10n.exportSavedTo(outcome.savedPath!);
  } else {
    message = l10n.exportDownloadStarted;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
