import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/pilgrim_import_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/states/pilgrim_import_state.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_import/pilgrim_import_column_mapping_list.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_import/pilgrim_import_preview_content.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_import/pilgrim_import_shared_widgets.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class PilgrimImportMappingStep extends ConsumerWidget {
  const PilgrimImportMappingStep({required this.state, super.key});

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
          PilgrimImportErrorBanner(message: state.error!),
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
          child: PilgrimImportColumnMappingList(
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
          child: PilgrimImportPreviewContent(
            preview: preview,
            busy: state.busy,
          ),
        ),
        SizedBox(height: sh(20)),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Semantics(
            button: true,
            label: l10n.importConfirmButton(preview.importableCount),
            enabled: preview.importableCount > 0 && !committing,
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
        ),
      ],
    );
  }
}
