import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_data_table.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_column_visibility.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/pilgrim_export_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/pilgrim_table_column_visibility_provider.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_export_snackbar.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_mobile_list.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_table_definitions.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_web_table.dart';
import 'package:rafiq_alhajj/features/trips/presentation/widgets/trip_selector.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class OperatorPilgrimListScreen extends ConsumerStatefulWidget {
  const OperatorPilgrimListScreen({super.key});

  @override
  ConsumerState<OperatorPilgrimListScreen> createState() =>
      _OperatorPilgrimListScreenState();
}

class _OperatorPilgrimListScreenState
    extends ConsumerState<OperatorPilgrimListScreen> {
  StaffTableQuery _query = const StaffTableQuery(
    sortColumnId: 'full_name',
  );

  Object? _cachedFilterKey;
  List<StaffTableFilter>? _cachedFilters;

  List<StaffTableFilter> _filtersFor(
    AppLocalizations l10n,
    List<PilgrimGroupOption> groups,
  ) {
    final key = groups.map((g) => g.id).join('|');
    if (_cachedFilterKey == key && _cachedFilters != null) {
      return _cachedFilters!;
    }
    _cachedFilterKey = key;
    _cachedFilters = OperatorPilgrimTableDefinitions.buildFilters(l10n, groups);
    return _cachedFilters!;
  }

  void _onQueryChanged(StaffTableQuery query) {
    setState(() => _query = query);
  }

  void _openPilgrim(OperatorPilgrimSummary item) {
    final path = AppRoutes.operatorPilgrimDetailPath(item.pilgrimId);
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
    }
  }

  void _openIntake() {
    if (AppPlatform.isWeb) {
      context.go(AppRoutes.operatorIntake);
    } else {
      unawaited(context.push(AppRoutes.operatorIntake));
    }
  }

  void _openImport() {
    if (AppPlatform.isWeb) {
      context.go(AppRoutes.operatorPilgrimsImport);
    } else {
      unawaited(context.push(AppRoutes.operatorPilgrimsImport));
    }
  }

  Future<void> _exportPilgrims(AppLocalizations l10n) async {
    final outcome =
        await ref.read(pilgrimExportControllerProvider.notifier).exportPilgrims(l10n);
    if (!mounted) {
      return;
    }
    showPilgrimExportSnackBar(context, l10n, outcome);
  }

  Future<void> _downloadTemplate(AppLocalizations l10n) async {
    final outcome = await ref
        .read(pilgrimExportControllerProvider.notifier)
        .downloadTemplate(l10n);
    if (!mounted) {
      return;
    }
    showPilgrimExportSnackBar(context, l10n, outcome);
  }

  Future<void> _openColumnPicker(
    AppLocalizations l10n,
    Set<String> hiddenColumnIds,
  ) async {
    await showStaffTableColumnPicker(
      context: context,
      options: OperatorPilgrimTableDefinitions.columnPickerOptions(l10n),
      hiddenColumnIds: hiddenColumnIds,
      onChanged: (hidden) {
        unawaited(
          ref.read(pilgrimTableColumnVisibilityProvider.notifier).setHidden(hidden),
        );
        if (hidden.contains(_query.sortColumnId)) {
          _onQueryChanged(
            _query.copyWith(sortColumnId: 'full_name', sortAscending: true),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isAdmin = ref.watch(
      authAccessModeProvider.select((mode) => mode == AppAccessMode.admin),
    );
    final pageAsync = ref.watch(operatorPilgrimRegistryPageProvider(_query));
    final groupsAsync = ref.watch(pilgrimGroupFilterOptionsProvider);
    final hiddenColumnIds = ref.watch(pilgrimTableColumnVisibilityProvider);
    final visibleColumns = OperatorPilgrimTableDefinitions.visibleColumns(
      context,
      l10n,
      hiddenColumnIds,
    );

    Widget listBody;
    if (groupsAsync.hasError && !groupsAsync.hasValue) {
      listBody = StaffEmptyState(
        message: l10n.adminGroupsLoadError,
        actionLabel: l10n.retry,
        onAction: () => ref.invalidate(pilgrimGroupFilterOptionsProvider),
      );
    } else if (groupsAsync.isLoading && !groupsAsync.hasValue) {
      listBody = AppPlatform.isWeb
          ? OperatorPilgrimWebTable(
              query: _query,
              onQueryChanged: _onQueryChanged,
              columns: visibleColumns,
              isAdmin: isAdmin,
              groups: const [],
              filters: const [],
              onOpenPilgrim: _openPilgrim,
              onOpenImport: _openImport,
              onOpenIntake: _openIntake,
              onCustomizeColumns: () =>
                  unawaited(_openColumnPicker(l10n, hiddenColumnIds)),
              onDownloadTemplate: () => unawaited(_downloadTemplate(l10n)),
              onExport: () => unawaited(_exportPilgrims(l10n)),
              isLoading: true,
            )
          : const Center(child: CircularProgressIndicator());
    } else {
      final groups = groupsAsync.value ?? const <PilgrimGroupOption>[];
      listBody = AppPlatform.isWeb
          ? OperatorPilgrimWebTable(
              query: _query,
              onQueryChanged: _onQueryChanged,
              columns: visibleColumns,
              isAdmin: isAdmin,
              groups: groups,
              filters: _filtersFor(l10n, groups),
              onOpenPilgrim: _openPilgrim,
              onOpenImport: _openImport,
              onOpenIntake: _openIntake,
              onCustomizeColumns: () =>
                  unawaited(_openColumnPicker(l10n, hiddenColumnIds)),
              onDownloadTemplate: () => unawaited(_downloadTemplate(l10n)),
              onExport: () => unawaited(_exportPilgrims(l10n)),
            )
          : pageAsync.when(
              skipLoadingOnReload: true,
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => StaffErrorView.fromError(
                l10n,
                error: error,
                onRetry: () {
                  ref.invalidate(operatorPilgrimRegistryPageProvider(_query));
                },
              ),
              data: (page) => OperatorPilgrimMobileList(
                items: page.items,
                onTap: _openPilgrim,
                onAddPilgrim: _openIntake,
              ),
            );
    }

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.operatorPilgrimListTitle,
        subtitle: l10n.operatorPilgrimListSubtitle,
        scrollable: false,
        body: listBody,
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(l10n.operatorPilgrimListTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go(
              isAdmin ? AppRoutes.adminDashboard : AppRoutes.operatorIntake,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _openIntake,
              icon: const Icon(Icons.person_add_outlined),
              tooltip: isAdmin ? l10n.adminPilgrimAdd : l10n.operatorIntakeTitle,
            ),
            IconButton(
              onPressed: ref.read(signOutControllerProvider.notifier).signOut,
              tooltip: l10n.signOut,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sw(16), vertical: sh(8)),
              child: const Align(
                alignment: AlignmentDirectional.centerStart,
                child: TripSelector(),
              ),
            ),
            Expanded(child: listBody),
          ],
        ),
      ),
    );
  }
}
