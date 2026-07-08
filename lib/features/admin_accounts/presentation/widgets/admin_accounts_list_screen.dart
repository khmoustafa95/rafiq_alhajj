import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_async_table_body.dart';
import 'package:rafiq_alhajj/core/widgets/staff_data_table.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_table_definition_cache.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/admin_accounts/domain/models/admin_account.dart';
import 'package:rafiq_alhajj/features/admin_accounts/presentation/providers/admin_accounts_providers.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminAccountsListScreen extends ConsumerStatefulWidget {
  const AdminAccountsListScreen({super.key});

  @override
  ConsumerState<AdminAccountsListScreen> createState() =>
      _AdminAccountsListScreenState();
}

class _AdminAccountsListScreenState
    extends ConsumerState<AdminAccountsListScreen> {
  StaffTableQuery _query = const StaffTableQuery(
    sortColumnId: 'full_name',
  );

  late final StaffTableDefinitionCache<AdminAccount> _tableDefs =
      StaffTableDefinitionCache<AdminAccount>(
    buildColumns: _buildColumns,
    buildFilters: (_) => const [],
  );

  void _onQueryChanged(StaffTableQuery query) {
    setState(() => _query = query);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final canManageAdmins = ref.watch(authCanManageAdminsProvider);
    final pageAsync = ref.watch(adminAccountListPageProvider(_query));
    final columns = _tableDefs.columns(context);
    final filters = _tableDefs.filters(context);

    final body = AppPlatform.isWeb
        ? StaffAsyncTableBody<AdminAccount>(
            tableKey: const ValueKey('admin-accounts-table'),
            pageAsync: pageAsync,
            query: _query,
            onQueryChanged: _onQueryChanged,
            columns: columns,
            searchHint: l10n.staffTableSearchAdmins,
            filters: filters,
            onRetry: () =>
                ref.invalidate(adminAccountListPageProvider(_query)),
            emptyMessage: l10n.adminAccountsEmpty,
            emptyIcon: Icons.admin_panel_settings_outlined,
          )
        : pageAsync.when(
            skipLoadingOnReload: true,
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => StaffErrorView.fromError(
              l10n,
              error: error,
              onRetry: () =>
                  ref.invalidate(adminAccountListPageProvider(_query)),
            ),
            data: (page) {
              if (page.items.isEmpty) {
                return StaffEmptyState(
                  message: l10n.adminAccountsEmpty,
                  icon: Icons.admin_panel_settings_outlined,
                );
              }

              return ListView.separated(
                padding: EdgeInsets.all(sw(16)),
                itemCount: page.items.length,
                separatorBuilder: (_, _) => SizedBox(height: sh(10)),
                itemBuilder: (context, index) {
                  final admin = page.items[index];
                  return _MobileAdminTile(admin: admin, l10n: l10n);
                },
              );
            },
          );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.adminAccountsTitle,
        subtitle: canManageAdmins
            ? l10n.adminAccountsSubtitleSuper
            : l10n.adminAccountsSubtitle,
        scrollable: false,
        body: body,
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(l10n.adminAccountsTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go(AppRoutes.adminDashboard),
          ),
        ),
        body: body,
      ),
    );
  }

  List<StaffTableColumn<AdminAccount>> _buildColumns(AppLocalizations l10n) {
    return [
      StaffTableColumn(
        id: 'full_name',
        label: l10n.adminOperatorFullName,
        flex: 3,
        sortable: true,
        cellBuilder: (context, admin) => Row(
          children: [
            CircleAvatar(
              radius: sr(16),
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              child: Icon(
                Icons.admin_panel_settings_outlined,
                size: ss(16),
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: sw(10)),
            Expanded(
              child: StaffCellText(admin.fullName, strong: true),
            ),
          ],
        ),
      ),
      StaffTableColumn(
        id: 'email',
        label: l10n.adminOperatorEmail,
        flex: 3,
        sortable: true,
        cellBuilder: (context, admin) => StaffCellText(admin.email),
      ),
      StaffTableColumn(
        id: 'can_manage_admins',
        label: l10n.adminAccountsRoleColumn,
        flex: 2,
        sortable: true,
        cellBuilder: (context, admin) => _AdminRoleChip(
          superAdmin: admin.canManageAdmins,
          superLabel: l10n.adminAccountsSuperAdmin,
          adminLabel: l10n.adminAccountsAdmin,
        ),
      ),
      StaffTableColumn(
        id: 'is_active',
        label: l10n.staffTableFilterStatus,
        flex: 2,
        sortable: true,
        cellBuilder: (context, admin) => _StatusChip(
          active: admin.isActive,
          activeLabel: l10n.adminOperatorActiveLabel,
          inactiveLabel: l10n.adminOperatorInactive,
        ),
      ),
    ];
  }
}

class _AdminRoleChip extends StatelessWidget {
  const _AdminRoleChip({
    required this.superAdmin,
    required this.superLabel,
    required this.adminLabel,
  });

  final bool superAdmin;
  final String superLabel;
  final String adminLabel;

  @override
  Widget build(BuildContext context) {
    final color = superAdmin ? AppColors.primary : AppColors.textSecondary;
    return Chip(
      label: Text(superAdmin ? superLabel : adminLabel),
      labelStyle: TextStyle(color: color, fontSize: ss(12)),
      side: BorderSide(color: color.withValues(alpha: 0.35)),
      backgroundColor: color.withValues(alpha: 0.08),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
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
    final color = active ? AppColors.success : AppColors.textSecondary;
    return Chip(
      label: Text(active ? activeLabel : inactiveLabel),
      labelStyle: TextStyle(color: color, fontSize: ss(12)),
      side: BorderSide(color: color.withValues(alpha: 0.35)),
      backgroundColor: color.withValues(alpha: 0.08),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}

class _MobileAdminTile extends StatelessWidget {
  const _MobileAdminTile({
    required this.admin,
    required this.l10n,
  });

  final AdminAccount admin;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.12),
          child: const Icon(Icons.admin_panel_settings_outlined),
        ),
        title: Text(admin.fullName),
        subtitle: Text(
          '${admin.email}\n${admin.canManageAdmins ? l10n.adminAccountsSuperAdmin : l10n.adminAccountsAdmin}',
        ),
        isThreeLine: true,
      ),
    );
  }
}
