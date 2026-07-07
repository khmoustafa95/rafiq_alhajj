import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/pilgrim_import_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_import/pilgrim_import_shared_widgets.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class PilgrimImportIdleStep extends ConsumerWidget {
  const PilgrimImportIdleStep({
    required this.busy,
    required this.error,
    super.key,
  });

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
            PilgrimImportErrorBanner(message: l10n.importGenericError),
            SizedBox(height: sh(12)),
          ],
          Semantics(
            button: true,
            label: l10n.importPickFile,
            enabled: !busy,
            child: FilledButton.icon(
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
          ),
        ],
      ),
    );
  }
}
