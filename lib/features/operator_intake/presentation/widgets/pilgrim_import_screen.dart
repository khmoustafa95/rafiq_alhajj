import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_import_models.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/forms/pilgrim_field_catalog.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/pilgrim_import_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/states/pilgrim_import_state.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Excel/CSV import wizard: pick file -> map columns -> preview -> commit.
class PilgrimImportScreen extends ConsumerWidget {
  const PilgrimImportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(pilgrimImportControllerProvider);

    final body = _ImportBody(state: state);

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.importTitle,
        subtitle: l10n.importSubtitle,
        body: body,
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(l10n.importTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go(AppRoutes.operatorPilgrims),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(sw(16)),
          child: body,
        ),
      ),
    );
  }
}

class _ImportBody extends StatelessWidget {
  const _ImportBody({required this.state});

  final PilgrimImportState state;

  @override
  Widget build(BuildContext context) {
    return switch (state.stage) {
      PilgrimImportStage.idle =>
        _IdleStep(busy: state.busy, error: state.error),
      PilgrimImportStage.mapping ||
      PilgrimImportStage.committing =>
        _MappingStep(state: state),
      PilgrimImportStage.done => _ResultStep(result: state.result),
    };
  }
}

class _IdleStep extends ConsumerWidget {
  const _IdleStep({required this.busy, required this.error});

  final bool busy;
  final String? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return StaffFormSection(
      icon: Icons.upload_file_outlined,
      title: l10n.importPickTitle,
      subtitle: l10n.importPickDescription,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (error != null) ...[
            _ErrorBanner(message: l10n.importGenericError),
            SizedBox(height: sh(12)),
          ],
          FilledButton.icon(
            onPressed: busy
                ? null
                : () => unawaited(
                      ref
                          .read(pilgrimImportControllerProvider.notifier)
                          .pickFile(),
                    ),
            icon: busy
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.attach_file),
            label: Text(l10n.importPickFile),
          ),
        ],
      ),
    );
  }
}

class _MappingStep extends ConsumerWidget {
  const _MappingStep({required this.state});

  final PilgrimImportState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final preview = state.preview;
    if (preview == null) {
      return const SizedBox.shrink();
    }
    final controller = ref.read(pilgrimImportControllerProvider.notifier);
    final committing = state.stage == PilgrimImportStage.committing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (state.error != null) ...[
          _ErrorBanner(message: state.error!),
          SizedBox(height: sh(12)),
        ],
        Row(
          children: [
            Expanded(
              child: Text(
                state.fileName ?? '',
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton.icon(
              onPressed: committing
                  ? null
                  : () => unawaited(controller.pickFile()),
              icon: const Icon(Icons.swap_horiz, size: 18),
              label: Text(l10n.importChangeFile),
            ),
          ],
        ),
        SizedBox(height: sh(16)),
        StaffFormSection(
          icon: Icons.swap_horizontal_circle_outlined,
          title: l10n.importMappingTitle,
          subtitle: l10n.importMappingDescription,
          child: _ColumnMappingList(
            columns: preview.columns,
            enabled: !committing,
            onChanged: (index, key) =>
                unawaited(controller.setColumnField(index, key)),
          ),
        ),
        SizedBox(height: sh(16)),
        StaffFormSection(
          icon: Icons.preview_outlined,
          title: l10n.importPreviewTitle,
          child: _PreviewContent(preview: preview, busy: state.busy),
        ),
        SizedBox(height: sh(20)),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: FilledButton.icon(
            onPressed: preview.importableCount == 0 || committing
                ? null
                : () => unawaited(controller.commit()),
            icon: committing
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.cloud_upload_outlined),
            label: Text(l10n.importConfirmButton(preview.importableCount)),
          ),
        ),
      ],
    );
  }
}

class _ColumnMappingList extends StatelessWidget {
  const _ColumnMappingList({
    required this.columns,
    required this.enabled,
    required this.onChanged,
  });

  final List<PilgrimImportColumn> columns;
  final bool enabled;
  final void Function(int index, String? fieldKey) onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = _fieldMenuItems(l10n);

    return Column(
      children: [
        for (final column in columns)
          Padding(
            padding: EdgeInsets.only(bottom: sh(10)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    column.header.trim().isEmpty ? '—' : column.header,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.arrow_right_alt, size: ss(18), color: AppColors.textSecondary),
                SizedBox(width: sw(8)),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: column.fieldKey ?? _ignoreValue,
                    decoration: const InputDecoration(isDense: true),
                    items: items,
                    onChanged: enabled
                        ? (value) => onChanged(
                              column.index,
                              value == _ignoreValue ? null : value,
                            )
                        : null,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  static const String _ignoreValue = '__ignore__';

  List<DropdownMenuItem<String>> _fieldMenuItems(AppLocalizations l10n) {
    return [
      DropdownMenuItem(value: _ignoreValue, child: Text(l10n.importColumnIgnore)),
      DropdownMenuItem(value: 'email', child: Text(l10n.importEmailColumnLabel)),
      for (final field in pilgrimFields)
        DropdownMenuItem(value: field.key, child: Text(field.label(l10n))),
    ];
  }
}

class _PreviewContent extends StatelessWidget {
  const _PreviewContent({required this.preview, required this.busy});

  final PilgrimImportPreview preview;
  final bool busy;

  static const int _maxRows = 100;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rows = preview.rows.take(_maxRows).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: sw(8),
          runSpacing: sh(8),
          children: [
            _CountChip(
              label: l10n.importNewCount(preview.createCount),
              color: Theme.of(context).colorScheme.primary,
            ),
            _CountChip(
              label: l10n.importUpdateCount(preview.updateCount),
              color: Theme.of(context).colorScheme.tertiary,
            ),
            _CountChip(
              label: l10n.importErrorCount(preview.errorCount),
              color: Theme.of(context).colorScheme.error,
            ),
            if (preview.ignoredHeaders.isNotEmpty)
              _CountChip(
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
              for (final row in rows) _PreviewRow(row: row),
            ],
          ),
        ),
        if (preview.rows.length > _maxRows) ...[
          SizedBox(height: sh(8)),
          Text(
            '+${preview.rows.length - _maxRows}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ],
    );
  }
}

class _PreviewRow extends StatelessWidget {
  const _PreviewRow({required this.row});

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
          _ActionChip(action: row.action),
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

class _ActionChip extends StatelessWidget {
  const _ActionChip({required this.action});

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
    return _CountChip(label: label, color: color);
  }
}

class _CountChip extends StatelessWidget {
  const _CountChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sw(10), vertical: sh(4)),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppDecorations.radiusSm),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _ResultStep extends ConsumerWidget {
  const _ResultStep({required this.result});

  final PilgrimImportResult? result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final data = result;

    return StaffFormSection(
      icon: Icons.task_alt_outlined,
      title: l10n.importResultTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: sw(8),
            runSpacing: sh(8),
            children: [
              _CountChip(
                label: l10n.importResultCreated(data?.created ?? 0),
                color: Theme.of(context).colorScheme.primary,
              ),
              _CountChip(
                label: l10n.importResultUpdated(data?.updated ?? 0),
                color: Theme.of(context).colorScheme.tertiary,
              ),
              _CountChip(
                label: l10n.importResultFailed(data?.failed ?? 0),
                color: Theme.of(context).colorScheme.error,
              ),
            ],
          ),
          if (data != null && data.errors.isNotEmpty) ...[
            SizedBox(height: sh(16)),
            Text(
              l10n.importResultErrorsTitle,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: sh(8)),
            for (final error in data.errors.take(50))
              Padding(
                padding: EdgeInsets.only(bottom: sh(4)),
                child: Text(
                  error,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ),
          ],
          SizedBox(height: sh(20)),
          Row(
            children: [
              FilledButton.icon(
                onPressed: () => ref
                    .read(pilgrimImportControllerProvider.notifier)
                    .reset(),
                icon: const Icon(Icons.refresh),
                label: Text(l10n.importAnother),
              ),
              SizedBox(width: sw(12)),
              OutlinedButton(
                onPressed: () => context.go(AppRoutes.operatorPilgrims),
                child: Text(l10n.dialogCancel),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(sw(12)),
      decoration: BoxDecoration(
        color: scheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDecorations.radiusSm),
        border: Border.all(color: scheme.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: scheme.error, size: ss(20)),
          SizedBox(width: sw(8)),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: scheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
