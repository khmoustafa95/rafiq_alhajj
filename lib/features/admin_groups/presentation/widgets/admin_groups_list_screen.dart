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
import 'package:rafiq_alhajj/features/admin_groups/domain/models/hajj_group.dart';
import 'package:rafiq_alhajj/features/admin_groups/presentation/providers/admin_groups_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminGroupsListScreen extends ConsumerStatefulWidget {
  const AdminGroupsListScreen({super.key});

  @override
  ConsumerState<AdminGroupsListScreen> createState() =>
      _AdminGroupsListScreenState();
}

class _AdminGroupsListScreenState extends ConsumerState<AdminGroupsListScreen> {
  StaffTableQuery _query = const StaffTableQuery(sortColumnId: 'name');

  late final StaffTableDefinitionCache<HajjGroup> _tableDefs =
      StaffTableDefinitionCache<HajjGroup>(
    buildColumns: _buildColumns,
  );

  void _openNew() {
    if (AppPlatform.isWeb) {
      context.go(AppRoutes.adminGroupNew);
    } else {
      unawaited(context.push(AppRoutes.adminGroupNew));
    }
  }

  void _openEdit(String id) {
    final path = AppRoutes.adminGroupEditPath(id);
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
    }
  }

  Future<void> _confirmDelete(HajjGroup group) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminGroupDeleteTitle),
        content: Text(l10n.adminGroupDeleteMessage(group.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.dialogCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.adminGroupDeleteConfirm),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) {
      return;
    }

    final ok = await ref.read(adminGroupDeleteProvider.notifier).remove(group.id);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? l10n.adminGroupDeleteSuccess : l10n.adminGroupDeleteError,
        ),
      ),
    );
  }

  List<Widget> _toolbarActions(AppLocalizations l10n) {
    return [
      FilledButton.icon(
        onPressed: _openNew,
        icon: const Icon(Icons.group_add_rounded),
        label: Text(l10n.adminGroupAdd),
      ),
    ];
  }

  void _onQueryChanged(StaffTableQuery query) {
    setState(() => _query = query);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pageAsync = ref.watch(adminGroupListPageProvider(_query));
    final toolbarActions = _toolbarActions(l10n);
    final columns = _tableDefs.columns(context);

    final body = AppPlatform.isWeb
        ? StaffAsyncTableBody<HajjGroup>(
            tableKey: const ValueKey('admin-groups-table'),
            pageAsync: pageAsync,
            query: _query,
            onQueryChanged: _onQueryChanged,
            columns: columns,
            searchHint: l10n.staffTableSearchGroups,
            toolbarActions: toolbarActions,
            onRetry: () => ref.invalidate(adminGroupListPageProvider(_query)),
            onRowTap: (group) => _openEdit(group.id),
            trailingBuilder: (context, group) => StaffTableRowActions(
              children: [
                StaffTableRowActions.iconButton(
                  icon: Icons.edit_outlined,
                  onPressed: () => _openEdit(group.id),
                ),
                StaffTableRowActions.iconButton(
                  icon: Icons.delete_outline,
                  onPressed: () => unawaited(_confirmDelete(group)),
                ),
              ],
            ),
            emptyMessage: l10n.adminGroupsEmpty,
            emptyIcon: Icons.groups_outlined,
          )
        : pageAsync.when(
            skipLoadingOnReload: true,
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => StaffErrorView.fromError(
              l10n,
              error: error,
              onRetry: () => ref.invalidate(adminGroupListPageProvider(_query)),
            ),
            data: (page) {
              if (page.items.isEmpty) {
                return StaffEmptyState(
                  message: l10n.adminGroupsEmpty,
                  icon: Icons.groups_outlined,
                  actionLabel: l10n.adminGroupAdd,
                  onAction: _openNew,
                );
              }

              return ListView.separated(
                padding: EdgeInsets.all(sw(16)),
                itemCount: page.items.length,
                separatorBuilder: (_, _) => SizedBox(height: sh(10)),
                itemBuilder: (context, index) {
                  final group = page.items[index];
                  return ListTile(
                    leading: _GroupLogo(logoUrl: group.logoUrl, size: sr(22)),
                    title: Text(group.name),
                    subtitle: Text(group.presidentName ?? '—'),
                    onTap: () => _openEdit(group.id),
                  );
                },
              );
            },
          );

    if (AppPlatform.isWeb) {
      return StaffWebPage(
        title: l10n.adminGroupsTitle,
        subtitle: l10n.adminGroupsSubtitle,
        scrollable: false,
        body: body,
      );
    }

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.adminGroupsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.adminDashboard),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openNew,
        icon: const Icon(Icons.group_add),
        label: Text(l10n.adminGroupAdd),
      ),
      body: body,
    );
  }

  List<StaffTableColumn<HajjGroup>> _buildColumns(AppLocalizations l10n) {
    return [
      StaffTableColumn(
        id: 'name',
        label: l10n.adminGroupName,
        flex: 3,
        sortable: true,
        cellBuilder: (context, group) => Row(
          children: [
            _GroupLogo(logoUrl: group.logoUrl, size: sr(18)),
            SizedBox(width: sw(10)),
            Expanded(
              child: Text(
                group.name,
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      StaffTableColumn(
        id: 'president_name',
        label: l10n.adminGroupPresidentName,
        flex: 2,
        sortable: true,
        cellBuilder: (context, group) => Text(
          group.presidentName ?? '—',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      StaffTableColumn(
        id: 'president_phone',
        label: l10n.adminGroupPresidentPhone,
        flex: 2,
        cellBuilder: (context, group) => Text(
          group.presidentPhone ?? '—',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      StaffTableColumn(
        id: 'members',
        label: l10n.adminGroupMembersCount,
        cellBuilder: (context, group) => Text(
          '${group.members.length}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    ];
  }
}

class _GroupLogo extends StatelessWidget {
  const _GroupLogo({
    required this.logoUrl,
    required this.size,
  });

  final String? logoUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (logoUrl != null && logoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppDecorations.radiusSm),
        child: Image.network(
          logoUrl!,
          width: size * 2,
          height: size * 2,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _placeholder(size),
        ),
      );
    }
    return _placeholder(size);
  }

  Widget _placeholder(double radius) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary.withValues(alpha: 0.12),
      child: Icon(Icons.groups_outlined, size: radius, color: AppColors.primary),
    );
  }
}
