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
import 'package:rafiq_alhajj/core/widgets/staff_async_table_body.dart';
import 'package:rafiq_alhajj/core/widgets/staff_data_table.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_definition_cache.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_account.dart';
import 'package:rafiq_alhajj/features/admin_operators/presentation/providers/admin_operators_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminOperatorsListScreen extends ConsumerStatefulWidget {
  const AdminOperatorsListScreen({super.key});

  @override
  ConsumerState<AdminOperatorsListScreen> createState() =>
      _AdminOperatorsListScreenState();
}

class _AdminOperatorsListScreenState
    extends ConsumerState<AdminOperatorsListScreen> {
  StaffTableQuery _query = const StaffTableQuery(
    sortColumnId: 'full_name',
  );

  late final StaffTableDefinitionCache<OperatorAccount> _tableDefs =
      StaffTableDefinitionCache<OperatorAccount>(
    buildColumns: _buildColumns,
    buildFilters: _buildFilters,
  );

  void _openNew(BuildContext context) {
    if (AppPlatform.isWeb) {
      context.go(AppRoutes.adminOperatorNew);
    } else {
      unawaited(context.push(AppRoutes.adminOperatorNew));
    }
  }

  void _openEdit(BuildContext context, String id) {
    final path = AppRoutes.adminOperatorEditPath(id);
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
    }
  }

  List<Widget> _toolbarActions(AppLocalizations l10n) {
    return [
      StaffToolbarButton(
        icon: Icons.person_add_alt_1_rounded,
        label: l10n.adminOperatorAdd,
        onPressed: () => _openNew(context),
        primary: true,
      ),
    ];
  }

  void _onQueryChanged(StaffTableQuery query) {
    setState(() => _query = query);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pageAsync = ref.watch(adminOperatorListPageProvider(_query));
    final toolbarActions = _toolbarActions(l10n);
    final columns = _tableDefs.columns(context);
    final filters = _tableDefs.filters(context);

    final body = AppPlatform.isWeb
        ? StaffAsyncTableBody<OperatorAccount>(
            tableKey: const ValueKey('admin-operators-table'),
            pageAsync: pageAsync,
            query: _query,
            onQueryChanged: _onQueryChanged,
            columns: columns,
            searchHint: l10n.staffTableSearchOperators,
            filters: filters,
            toolbarActions: toolbarActions,
            onRetry: () =>
                ref.invalidate(adminOperatorListPageProvider(_query)),
            onRowTap: (operator) => _openEdit(context, operator.id),
            trailingBuilder: (context, operator) => StaffTableRowActions(
              children: [
                StaffTableRowActions.iconButton(
                  icon: Icons.edit_outlined,
                  onPressed: () => _openEdit(context, operator.id),
                ),
              ],
            ),
            emptyMessage: l10n.adminOperatorEmpty,
            emptyIcon: Icons.badge_outlined,
          )
        : pageAsync.when(
            skipLoadingOnReload: true,
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => StaffErrorView.fromError(
              l10n,
              error: error,
              onRetry: () =>
                  ref.invalidate(adminOperatorListPageProvider(_query)),
            ),
            data: (page) {
              if (page.items.isEmpty) {
                return StaffEmptyState(
                  message: l10n.adminOperatorEmpty,
                  icon: Icons.badge_outlined,
                  actionLabel: l10n.adminOperatorAdd,
                  onAction: () => _openNew(context),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.all(sw(16)),
                itemCount: page.items.length,
                separatorBuilder: (_, _) => SizedBox(height: sh(10)),
                itemBuilder: (context, index) {
                  final operator = page.items[index];
                  return _MobileOperatorTile(
                    operator: operator,
                    l10n: l10n,
                    onTap: () => _openEdit(context, operator.id),
                  );
                },
              );
            },
          );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.adminOperatorsTitle,
        subtitle: l10n.adminOperatorsSubtitle,
        scrollable: false,
        body: body,
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(l10n.adminOperatorsTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go(AppRoutes.adminDashboard),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _openNew(context),
          icon: const Icon(Icons.person_add_alt_1),
          label: Text(l10n.adminOperatorAdd),
        ),
        body: body,
      ),
    );
  }

  List<StaffTableFilter> _buildFilters(AppLocalizations l10n) {
    return [
      StaffTableFilter(
        id: 'status',
        label: l10n.staffTableFilterStatus,
        allLabel: l10n.staffTableFilterAll,
        options: [
          StaffTableFilterOption(
            value: 'active',
            label: l10n.adminOperatorActiveLabel,
          ),
          StaffTableFilterOption(
            value: 'inactive',
            label: l10n.adminOperatorInactive,
          ),
        ],
      ),
    ];
  }

  List<StaffTableColumn<OperatorAccount>> _buildColumns(AppLocalizations l10n) {
    return [
      StaffTableColumn(
        id: 'full_name',
        label: l10n.adminOperatorFullName,
        flex: 3,
        sortable: true,
        cellBuilder: (context, operator) => Row(
          children: [
            CircleAvatar(
              radius: sr(16),
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              child: Icon(
                Icons.badge_outlined,
                size: ss(16),
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: sw(10)),
            Expanded(
              child: StaffCellText(operator.fullName, strong: true),
            ),
          ],
        ),
      ),
      StaffTableColumn(
        id: 'email',
        label: l10n.adminOperatorEmail,
        flex: 3,
        sortable: true,
        cellBuilder: (context, operator) => StaffCellText(operator.email),
      ),
      StaffTableColumn(
        id: 'is_active',
        label: l10n.staffTableFilterStatus,
        flex: 2,
        sortable: true,
        cellBuilder: (context, operator) => _StatusChip(
          active: operator.isActive,
          activeLabel: l10n.adminOperatorActiveLabel,
          inactiveLabel: l10n.adminOperatorInactive,
        ),
      ),
      StaffTableColumn(
        id: 'permissions',
        label: l10n.adminOperatorPermissionsSection,
        flex: 4,
        cellBuilder: (context, operator) => Wrap(
          spacing: sw(4),
          runSpacing: sh(4),
          children: [
            if (operator.permissions.canRegisterPilgrims)
              _PermChip(label: l10n.adminOperatorPermRegister),
            if (operator.permissions.canManagePilgrimRegistry)
              _PermChip(label: l10n.adminOperatorPermRegistry),
            if (operator.permissions.canUseFieldTools)
              _PermChip(label: l10n.adminOperatorPermField),
            if (operator.permissions.canUploadDocuments)
              _PermChip(label: l10n.adminOperatorPermUpload),
          ],
        ),
      ),
    ];
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.active,
    required this.activeLabel,
    required this.inactiveLabel,
  });

  final bool active;
  final String activeLabel;
  final String inactiveLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sw(8), vertical: sh(4)),
      decoration: BoxDecoration(
        color: active
            ? AppColors.success.withValues(alpha: 0.12)
            : AppColors.error.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppDecorations.radiusSm),
      ),
      child: Text(
        active ? activeLabel : inactiveLabel,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: active ? AppColors.success : AppColors.error,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _PermChip extends StatelessWidget {
  const _PermChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sw(6), vertical: sh(2)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDecorations.radiusSm),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}

class _MobileOperatorTile extends StatelessWidget {
  const _MobileOperatorTile({
    required this.operator,
    required this.l10n,
    required this.onTap,
  });

  final OperatorAccount operator;
  final AppLocalizations l10n;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        side: const BorderSide(color: AppColors.border),
      ),
      title: Text(operator.fullName),
      subtitle: Text(operator.email),
      trailing: _StatusChip(
        active: operator.isActive,
        activeLabel: l10n.adminOperatorActiveLabel,
        inactiveLabel: l10n.adminOperatorInactive,
      ),
    );
  }
}
