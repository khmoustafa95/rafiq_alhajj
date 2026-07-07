import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/pilgrim_import_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/states/pilgrim_import_state.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_import/pilgrim_import_idle_step.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_import/pilgrim_import_mapping_step.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_import/pilgrim_import_result_step.dart';
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
        PilgrimImportIdleStep(busy: state.busy, error: state.error),
      PilgrimImportStage.mapping ||
      PilgrimImportStage.committing =>
        PilgrimImportMappingStep(state: state),
      PilgrimImportStage.done => PilgrimImportResultStep(result: state.result),
    };
  }
}
