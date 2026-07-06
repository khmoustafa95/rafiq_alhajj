import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_async_table_body.dart';
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
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_list_toolbar.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_mobile_card.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/operator_pilgrim_table_definitions.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/widgets/pilgrim_bulk_edit_dialog.dart';
import 'package:rafiq_alhajj/features/trips/presentation/widgets/trip_selector.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

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
    _cachedFilters = _buildFilters(l10n, groups);
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
    _showExportResult(l10n, outcome);
  }

  Future<void> _downloadTemplate(AppLocalizations l10n) async {
    final outcome = await ref
        .read(pilgrimExportControllerProvider.notifier)
        .downloadTemplate(l10n);
    if (!mounted) {
      return;
    }
    _showExportResult(l10n, outcome);
  }

  void _showExportResult(AppLocalizations l10n, PilgrimExportOutcome? outcome) {
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

  List<StaffTableColumn<OperatorPilgrimSummary>> _visibleColumns(
    BuildContext context,
    AppLocalizations l10n,
    Set<String> hiddenColumnIds,
  ) {
    return OperatorPilgrimTableDefinitions.visibleColumns(
      context,
      l10n,
      hiddenColumnIds,
    );
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

  List<Widget> _toolbarActions(
    AppLocalizations l10n,
    bool isAdmin,
    Set<String> hiddenColumnIds,
  ) {
    return OperatorPilgrimListToolbar.buildActions(
      l10n: l10n,
      isAdmin: isAdmin,
      onCustomizeColumns: () => unawaited(_openColumnPicker(l10n, hiddenColumnIds)),
      onDownloadTemplate: () => unawaited(_downloadTemplate(l10n)),
      onExport: () => unawaited(_exportPilgrims(l10n)),
      onImport: _openImport,
      onAddPilgrim: _openIntake,
    );
  }

  List<StaffTableFilter> _buildFilters(
    AppLocalizations l10n,
    List<PilgrimGroupOption> groups,
  ) {
    return OperatorPilgrimTableDefinitions.buildFilters(l10n, groups);
  }

  List<StaffTableBulkAction<OperatorPilgrimSummary>> _bulkActions(
    AppLocalizations l10n,
    List<PilgrimGroupOption> groups,
  ) {
    return [
      StaffTableBulkAction(
        label: l10n.bulkEditAction,
        icon: Icons.edit_note_outlined,
        onPressed: (items) => unawaited(
          PilgrimBulkEditDialog.show(
            context,
            items.map((item) => item.pilgrimId).toList(),
          ),
        ),
      ),
      StaffTableBulkAction(
        label: l10n.adminPilgrimBulkAssignGroup,
        icon: Icons.groups_outlined,
        onPressed: (items) => unawaited(
          _showAssignGroupDialog(l10n, groups, items),
        ),
      ),
      StaffTableBulkAction(
        label: l10n.adminPilgrimBulkClearGroup,
        icon: Icons.group_off_outlined,
        onPressed: (items) => unawaited(
          _bulkAssignGroup(
            l10n,
            items.map((item) => item.pilgrimId).toList(),
            groupId: null,
          ),
        ),
      ),
    ];
  }

  Future<void> _showAssignGroupDialog(
    AppLocalizations l10n,
    List<PilgrimGroupOption> groups,
    List<OperatorPilgrimSummary> items,
  ) async {
    if (groups.isEmpty) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminPilgrimNoGroups)),
      );
      return;
    }

    var selectedGroupId = groups.first.id;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminPilgrimAssignGroupTitle),
        content: DropdownButtonFormField<String>(
          initialValue: selectedGroupId,
          decoration: InputDecoration(labelText: l10n.staffTableFilterGroup),
          items: groups
              .map(
                (group) => DropdownMenuItem(
                  value: group.id,
                  child: Text(group.name),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              selectedGroupId = value;
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.dialogCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.adminPilgrimAssignGroupConfirm),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) {
      return;
    }

    await _bulkAssignGroup(
      l10n,
      items.map((item) => item.pilgrimId).toList(),
      groupId: selectedGroupId,
    );
  }

  Future<void> _bulkAssignGroup(
    AppLocalizations l10n,
    List<String> pilgrimIds, {
    required String? groupId,
  }) async {
    final ok = await ref.read(pilgrimBulkAssignGroupProvider.notifier).assign(
          pilgrimIds: pilgrimIds,
          groupId: groupId,
        );

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? l10n.adminPilgrimAssignGroupSuccess : l10n.adminPilgrimAssignGroupError,
        ),
      ),
    );
  }

  bool _canSendCredentials(OperatorPilgrimSummary item) {
    return item.profileId != null &&
        (item.whatsappNumber?.trim().isNotEmpty ?? false);
  }

  /// Resets the pilgrim's password and opens WhatsApp pre-filled with the new
  /// credentials. Passwords are never stored, so we always issue a fresh one.
  Future<void> _sendCredentials(
    AppLocalizations l10n,
    OperatorPilgrimSummary item,
  ) async {
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

    if (confirmed != true || !mounted) {
      return;
    }

    final credentials =
        await ref.read(pilgrimPasswordResetProvider.notifier).reset(profileId);

    if (!mounted) {
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
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.operatorWhatsappOpenFailed)),
      );
    }
  }

  String _genderLabel(AppLocalizations l10n, String? gender) {
    return OperatorPilgrimTableDefinitions.genderLabel(l10n, gender);
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
    final visibleColumns = _visibleColumns(context, l10n, hiddenColumnIds);

    Widget listBody;
    if (groupsAsync.hasError && !groupsAsync.hasValue) {
      listBody = StaffEmptyState(
        message: l10n.adminGroupsLoadError,
        actionLabel: l10n.retry,
        onAction: () => ref.invalidate(pilgrimGroupFilterOptionsProvider),
      );
    } else if (groupsAsync.isLoading && !groupsAsync.hasValue) {
      listBody = AppPlatform.isWeb
          ? StaffAsyncTableBody<OperatorPilgrimSummary>(
              tableKey: const ValueKey('operator-pilgrims-table'),
              pageAsync: pageAsync,
              query: _query,
              onQueryChanged: _onQueryChanged,
              columns: visibleColumns,
              searchHint: l10n.operatorPilgrimSearchHint,
              toolbarActions: _toolbarActions(l10n, isAdmin, hiddenColumnIds),
              isLoading: true,
              emptyMessage: l10n.operatorPilgrimListEmpty,
              emptyIcon: Icons.people_outline,
            )
          : const Center(child: CircularProgressIndicator());
    } else {
      final groups = groupsAsync.value ?? const <PilgrimGroupOption>[];
      listBody = AppPlatform.isWeb
          ? StaffAsyncTableBody<OperatorPilgrimSummary>(
              tableKey: const ValueKey('operator-pilgrims-table'),
              pageAsync: pageAsync,
              query: _query,
              onQueryChanged: _onQueryChanged,
              columns: visibleColumns,
              searchHint: l10n.operatorPilgrimSearchHint,
              filters: _filtersFor(l10n, groups),
              toolbarActions: _toolbarActions(l10n, isAdmin, hiddenColumnIds),
              onRetry: () =>
                  ref.invalidate(operatorPilgrimRegistryPageProvider(_query)),
              onRowTap: _openPilgrim,
              trailingBuilder: (context, item) => StaffTableRowActions(
                children: [
                  if (_canSendCredentials(item))
                    StaffTableRowActions.iconButton(
                      icon: Icons.chat_outlined,
                      tooltip: l10n.operatorSendCredentialsWhatsapp,
                      onPressed: () => unawaited(_sendCredentials(l10n, item)),
                    ),
                  StaffTableRowActions.iconButton(
                    icon: Icons.edit_outlined,
                    onPressed: () => _openPilgrim(item),
                  ),
                ],
              ),
              selectable: isAdmin,
              rowKey: (item) => item.pilgrimId,
              bulkActions: isAdmin ? _bulkActions(l10n, groups) : const [],
              emptyMessage: l10n.operatorPilgrimListEmpty,
              emptyIcon: Icons.people_outline,
            )
          : pageAsync.when(
              skipLoadingOnReload: true,
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => _errorState(l10n, error),
              data: (page) => _mobileList(l10n, isAdmin, page.items),
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

  Widget _errorState(AppLocalizations l10n, Object error) {
    return StaffErrorView.fromError(
      l10n,
      error: error,
      onRetry: () {
        ref.invalidate(operatorPilgrimRegistryPageProvider(_query));
      },
    );
  }

  Widget _mobileList(
    AppLocalizations l10n,
    bool isAdmin,
    List<OperatorPilgrimSummary> items,
  ) {
    if (items.isEmpty) {
      return StaffEmptyState(
        message: l10n.operatorPilgrimListEmpty,
        icon: Icons.people_outline,
        actionLabel: l10n.adminPilgrimAdd,
        onAction: _openIntake,
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(sw(16)),
      itemCount: items.length,
      separatorBuilder: (_, _) => SizedBox(height: sh(10)),
      itemBuilder: (context, index) {
        final item = items[index];
        return OperatorPilgrimMobileCard(
          item: item,
          subtitle: _subtitle(l10n, item),
          onTap: () => _openPilgrim(item),
        );
      },
    );
  }

  String _subtitle(AppLocalizations l10n, OperatorPilgrimSummary item) {
    final parts = <String>[];
    if (item.gender != null) {
      parts.add(_genderLabel(l10n, item.gender));
    }
    if (item.groupName != null) {
      parts.add(item.groupName!);
    }
    if (item.passportNumber != null) {
      parts.add('${l10n.operatorPassport}: ${item.passportNumber}');
    }
    if (item.travelDate != null) {
      parts.add(
        '${l10n.pilgrimTravelDate}: '
        '${MaterialLocalizations.of(context).formatMediumDate(item.travelDate!)}',
      );
    }
    return parts.isEmpty ? l10n.operatorPilgrimNoLogisticsYet : parts.join(' · ');
  }
}
