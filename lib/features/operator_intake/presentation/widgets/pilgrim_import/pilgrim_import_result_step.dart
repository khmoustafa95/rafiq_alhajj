import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_import_models.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/pilgrim_import_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_import/pilgrim_import_shared_widgets.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class PilgrimImportResultStep extends ConsumerWidget {
  const PilgrimImportResultStep({required this.result, super.key});

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
              PilgrimImportCountChip(
                label: l10n.importResultCreated(data?.created ?? 0),
                color: Theme.of(context).colorScheme.primary,
              ),
              PilgrimImportCountChip(
                label: l10n.importResultUpdated(data?.updated ?? 0),
                color: Theme.of(context).colorScheme.tertiary,
              ),
              PilgrimImportCountChip(
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
