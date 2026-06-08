import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_data_table.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_definition_cache.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/controllers/sign_out_controller.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/presentation/providers/operator_registry_providers.dart';
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

  late final StaffTableDefinitionCache<OperatorPilgrimSummary> _columnCache =
      StaffTableDefinitionCache<OperatorPilgrimSummary>(
    buildColumns: _buildColumns,
  );

  void _openPilgrim(OperatorPilgrimSummary item) {
    final path = AppRoutes.operatorPilgrimDetailPath(item.profileId);
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

  List<Widget> _toolbarActions(AppLocalizations l10n, bool isAdmin) {
    return [
      FilledButton.icon(
        onPressed: _openIntake,
        icon: const Icon(Icons.person_add_outlined),
        label: Text(isAdmin ? l10n.adminPilgrimAdd : l10n.operatorIntakeTitle),
      ),
    ];
  }

  List<StaffTableFilter> _filters(
    AppLocalizations l10n,
    List<PilgrimGroupOption> groups,
  ) {
    return [
      StaffTableFilter(
        id: 'gender',
        label: l10n.staffTableFilterGender,
        allLabel: l10n.staffTableFilterAll,
        options: [
          StaffTableFilterOption(
            value: 'male',
            label: l10n.pilgrimGenderMale,
          ),
          StaffTableFilterOption(
            value: 'female',
            label: l10n.pilgrimGenderFemale,
          ),
        ],
      ),
      StaffTableFilter(
        id: 'group_id',
        label: l10n.staffTableFilterGroup,
        allLabel: l10n.staffTableFilterAll,
        options: groups
            .map(
              (group) => StaffTableFilterOption(
                value: group.id,
                label: group.name,
              ),
            )
            .toList(),
      ),
    ];
  }

  List<StaffTableBulkAction<OperatorPilgrimSummary>> _bulkActions(
    AppLocalizations l10n,
    List<PilgrimGroupOption> groups,
  ) {
    return [
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
            items.map((item) => item.profileId).toList(),
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
      items.map((item) => item.profileId).toList(),
      groupId: selectedGroupId,
    );
  }

  Future<void> _bulkAssignGroup(
    AppLocalizations l10n,
    List<String> profileIds, {
    required String? groupId,
  }) async {
    final ok = await ref.read(pilgrimBulkAssignGroupProvider.notifier).assign(
          profileIds: profileIds,
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

  String _genderLabel(AppLocalizations l10n, String? gender) {
    return switch (gender) {
      'male' => l10n.pilgrimGenderMale,
      'female' => l10n.pilgrimGenderFemale,
      _ => '—',
    };
  }

  StaffDataTable<OperatorPilgrimSummary> _buildTable({
    required AppLocalizations l10n,
    required bool isAdmin,
    required List<PilgrimGroupOption> groups,
    required List<OperatorPilgrimSummary> rows,
    required int totalCount,
    required bool isLoading,
  }) {
    return StaffDataTable<OperatorPilgrimSummary>(
      columns: _columnCache.columns(context),
      rows: rows,
      totalCount: totalCount,
      query: _query,
      onQueryChanged: (query) => setState(() => _query = query),
      searchHint: l10n.operatorPilgrimSearchHint,
      filters: _filters(l10n, groups),
      toolbarActions: _toolbarActions(l10n, isAdmin),
      isLoading: isLoading,
      onRowTap: _openPilgrim,
      trailingBuilder: (context, item) => StaffTableRowActions(
        children: [
          StaffTableRowActions.iconButton(
            icon: Icons.edit_outlined,
            onPressed: () => _openPilgrim(item),
          ),
        ],
      ),
      selectable: isAdmin,
      rowKey: (item) => item.profileId,
      bulkActions: isAdmin ? _bulkActions(l10n, groups) : const [],
      emptyMessage: l10n.operatorPilgrimListEmpty,
      emptyIcon: Icons.people_outline,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isAdmin = ref.watch(authAccessModeProvider) == AppAccessMode.admin;
    final pageAsync = ref.watch(operatorPilgrimRegistryPageProvider(_query));
    final groupsAsync = ref.watch(pilgrimGroupFilterOptionsProvider);

    final listBody = groupsAsync.when(
      loading: () => AppPlatform.isWeb
          ? const Center(child: CircularProgressIndicator())
          : pageAsync.when(
              skipLoadingOnReload: true,
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => _errorState(l10n),
              data: (page) => _mobileList(l10n, isAdmin, page.items),
            ),
      error: (_, _) => StaffEmptyState(
        message: l10n.adminGroupsLoadError,
        actionLabel: l10n.retry,
        onAction: () => ref.invalidate(pilgrimGroupFilterOptionsProvider),
      ),
      data: (groups) => pageAsync.when(
        skipLoadingOnReload: true,
        loading: () => AppPlatform.isWeb
            ? _buildTable(
                l10n: l10n,
                isAdmin: isAdmin,
                groups: groups,
                rows: const [],
                totalCount: 0,
                isLoading: true,
              )
            : const Center(child: CircularProgressIndicator()),
        error: (_, _) => _errorState(l10n),
        data: (page) {
          if (AppPlatform.isWeb) {
            return _buildTable(
              l10n: l10n,
              isAdmin: isAdmin,
              groups: groups,
              rows: page.items,
              totalCount: page.totalCount,
              isLoading: pageAsync.isLoading,
            );
          }
          return _mobileList(l10n, isAdmin, page.items);
        },
      ),
    );

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
        body: listBody,
      ),
    );
  }

  Widget _errorState(AppLocalizations l10n) {
    return StaffEmptyState(
      message: l10n.operatorPilgrimListLoadError,
      icon: Icons.error_outline,
      actionLabel: l10n.retry,
      onAction: () {
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
        return _PilgrimCard(
          item: item,
          l10n: l10n,
          subtitle: _subtitle(l10n, item),
          onTap: () => _openPilgrim(item),
        );
      },
    );
  }

  List<StaffTableColumn<OperatorPilgrimSummary>> _buildColumns(
    AppLocalizations l10n,
  ) {
    return [
      StaffTableColumn(
        id: 'full_name',
        label: l10n.operatorFullName,
        flex: 3,
        sortable: true,
        cellBuilder: (context, item) => Row(
          children: [
            CircleAvatar(
              radius: sr(16),
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              child: Text(
                item.fullName.isNotEmpty ? item.fullName[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(width: sw(10)),
            Expanded(
              child: Text(
                item.fullName,
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      StaffTableColumn(
        id: 'gender',
        label: l10n.staffTableFilterGender,
        cellBuilder: (context, item) => Text(
          _genderLabel(l10n, item.gender),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      StaffTableColumn(
        id: 'group',
        label: l10n.staffTableFilterGroup,
        flex: 2,
        cellBuilder: (context, item) => Text(
          item.groupName ?? '—',
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      StaffTableColumn(
        id: 'passport',
        label: l10n.operatorPassport,
        flex: 2,
        cellBuilder: (context, item) => Text(
          item.passportNumber ?? '—',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      StaffTableColumn(
        id: 'travel_date',
        label: l10n.pilgrimTravelDate,
        flex: 2,
        cellBuilder: (context, item) => Text(
          item.travelDate == null
              ? l10n.operatorPilgrimTravelDateUnset
              : MaterialLocalizations.of(context)
                  .formatMediumDate(item.travelDate!),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    ];
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

class _PilgrimCard extends StatelessWidget {
  const _PilgrimCard({
    required this.item,
    required this.l10n,
    required this.subtitle,
    required this.onTap,
  });

  final OperatorPilgrimSummary item;
  final AppLocalizations l10n;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: DecoratedBox(
          decoration: AppDecorations.card(),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: sw(16),
              vertical: sh(8),
            ),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              child: Text(
                item.fullName.isNotEmpty ? item.fullName[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            title: Text(
              item.fullName,
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
      ),
    );
  }
}
