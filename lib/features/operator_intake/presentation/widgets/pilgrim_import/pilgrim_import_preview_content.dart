import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_import_models.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_import/pilgrim_import_shared_widgets.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class PilgrimImportPreviewContent extends StatelessWidget {
  const PilgrimImportPreviewContent({
    required this.preview,
    required this.busy,
    super.key,
  });

  final PilgrimImportPreview preview;
  final bool busy;

  static const int maxRows = 100;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rows = preview.rows.take(maxRows).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: sw(8),
          runSpacing: sh(8),
          children: [
            PilgrimImportCountChip(
              label: l10n.importNewCount(preview.createCount),
              color: Theme.of(context).colorScheme.primary,
            ),
            PilgrimImportCountChip(
              label: l10n.importUpdateCount(preview.updateCount),
              color: Theme.of(context).colorScheme.tertiary,
            ),
            PilgrimImportCountChip(
              label: l10n.importErrorCount(preview.errorCount),
              color: Theme.of(context).colorScheme.error,
            ),
            if (preview.ignoredHeaders.isNotEmpty)
              PilgrimImportCountChip(
                label: l10n.importIgnoredColumns(preview.ignoredHeaders.length),
                color: AppColors.textSecondary,
              ),
          ],
        ),
        SizedBox(height: sh(12)),
        if (busy) const LinearProgressIndicator(),
        SizedBox(height: sh(8)),
        DecoratedBox(
          decoration: AppDecorations.card(),
          child: Column(
            children: [
              for (final row in rows) PilgrimImportPreviewRow(row: row),
            ],
          ),
        ),
        if (preview.rows.length > maxRows) ...[
          SizedBox(height: sh(8)),
          Text(
            '+${preview.rows.length - maxRows}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ],
    );
  }
}

class PilgrimImportPreviewRow extends StatelessWidget {
  const PilgrimImportPreviewRow({required this.row, super.key});

  final PilgrimImportRow row;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw(12), vertical: sh(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: sw(36),
            child: Text(
              '${row.rowNumber}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.displayName,
                  style: theme.textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (row.issues.isNotEmpty) ...[
                  SizedBox(height: sh(2)),
                  Text(
                    row.issues.map((i) => _issueLabel(l10n, i)).join(' · '),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: sw(8)),
          PilgrimImportActionChip(action: row.action),
        ],
      ),
    );
  }

  String _issueLabel(AppLocalizations l10n, PilgrimImportIssue issue) {
    return switch (issue.code) {
      PilgrimImportIssueCode.missingName => l10n.importIssueMissingName,
      PilgrimImportIssueCode.invalidDate => l10n.importIssueInvalidDate,
      PilgrimImportIssueCode.invalidGender => l10n.importIssueInvalidGender,
      PilgrimImportIssueCode.invalidBoolean => l10n.importIssueInvalidBoolean,
      PilgrimImportIssueCode.duplicatePassport =>
        l10n.importIssueDuplicatePassport,
    };
  }
}

class PilgrimImportActionChip extends StatelessWidget {
  const PilgrimImportActionChip({required this.action, super.key});

  final PilgrimImportAction action;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final (label, color) = switch (action) {
      PilgrimImportAction.create => (l10n.importActionCreate, scheme.primary),
      PilgrimImportAction.update => (l10n.importActionUpdate, scheme.tertiary),
      PilgrimImportAction.error => (l10n.importActionError, scheme.error),
    };
    return PilgrimImportCountChip(label: label, color: color);
  }
}
