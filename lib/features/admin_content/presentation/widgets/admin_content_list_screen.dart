import 'dart:async';

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
import 'package:rafiq_alhajj/features/admin_content/presentation/providers/admin_content_providers.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/utils/content_meta_l10n.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminContentListScreen extends ConsumerStatefulWidget {
  const AdminContentListScreen({super.key});

  @override
  ConsumerState<AdminContentListScreen> createState() =>
      _AdminContentListScreenState();
}

class _AdminContentListScreenState extends ConsumerState<AdminContentListScreen> {
  StaffTableQuery _query = const StaffTableQuery(
    sortColumnId: 'title',
  );

  late final StaffTableDefinitionCache<ContentItem> _tableDefs =
      StaffTableDefinitionCache<ContentItem>(
    buildColumns: _buildColumns,
    buildFilters: _buildFilters,
  );

  Future<void> _confirmDelete(ContentItem item) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminContentDeleteTitle),
        content: Text(l10n.adminContentDeleteMessage(item.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.dialogCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.adminContentDeleteConfirm),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) {
      return;
    }

    final ok = await ref
        .read(adminContentDeleteProvider.notifier)
        .deleteItem(item.id);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? l10n.adminContentDeleteSuccess : l10n.adminContentDeleteError,
        ),
      ),
    );
  }

  void _openNew() {
    if (AppPlatform.isWeb) {
      context.go(AppRoutes.adminContentNew);
    } else {
      unawaited(context.push(AppRoutes.adminContentNew));
    }
  }

  void _openEdit(String id) {
    final path = AppRoutes.adminContentEditPath(id);
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
    }
  }

  List<Widget> _toolbarActions(AppLocalizations l10n) {
    return [
      FilledButton.icon(
        onPressed: _openNew,
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.adminContentAdd),
      ),
    ];
  }

  void _onQueryChanged(StaffTableQuery query) {
    setState(() => _query = query);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pageAsync = ref.watch(adminContentListPageProvider(_query));
    final toolbarActions = _toolbarActions(l10n);
    final columns = _tableDefs.columns(context);
    final filters = _tableDefs.filters(context);

    final content = AppPlatform.isWeb
        ? StaffAsyncTableBody<ContentItem>(
            tableKey: const ValueKey('admin-content-table'),
            pageAsync: pageAsync,
            query: _query,
            onQueryChanged: _onQueryChanged,
            columns: columns,
            searchHint: l10n.staffTableSearchContent,
            filters: filters,
            toolbarActions: toolbarActions,
            isLoading: pageAsync.isLoading,
            onRetry: () => ref.invalidate(adminContentListPageProvider(_query)),
            onRowTap: (item) => _openEdit(item.id),
            trailingBuilder: (context, item) => StaffTableRowActions(
              children: [
                StaffTableRowActions.iconButton(
                  icon: Icons.edit_outlined,
                  onPressed: () => _openEdit(item.id),
                ),
                StaffTableRowActions.iconButton(
                  icon: Icons.delete_outline,
                  onPressed: () => unawaited(_confirmDelete(item)),
                ),
              ],
            ),
            emptyMessage: l10n.adminContentEmpty,
            emptyIcon: Icons.article_outlined,
          )
        : pageAsync.when(
            skipLoadingOnReload: true,
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => StaffErrorView.fromError(
              l10n,
              error: error,
              onRetry: () => ref.invalidate(adminContentListPageProvider(_query)),
            ),
            data: (page) {
              if (page.items.isEmpty) {
                return StaffEmptyState(
                  message: l10n.adminContentEmpty,
                  icon: Icons.article_outlined,
                  actionLabel: l10n.adminContentAdd,
                  onAction: _openNew,
                );
              }

              return ListView.builder(
                padding: EdgeInsets.all(sw(16)),
                itemCount: page.items.length,
                itemBuilder: (context, index) {
                  final item = page.items[index];
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text(contentTypeLabel(l10n, item.type)),
                    onTap: () => _openEdit(item.id),
                  );
                },
              );
            },
          );

    if (AppPlatform.isWeb) {
      return StaffWebPage(
        title: l10n.adminContentListTitle,
        scrollable: false,
        body: content,
      );
    }

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.adminContentListTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.adminDashboard),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openNew,
        icon: const Icon(Icons.add),
        label: Text(l10n.adminContentAdd),
      ),
      body: content,
    );
  }
}

List<StaffTableFilter> _buildFilters(AppLocalizations l10n) {
  return [
    StaffTableFilter(
      id: 'type',
      label: l10n.adminContentTypeLabel,
      allLabel: l10n.staffTableFilterAll,
      options: ContentType.values
          .map(
            (type) => StaffTableFilterOption(
              value: type.name,
              label: contentTypeLabel(l10n, type),
            ),
          )
          .toList(),
    ),
    StaffTableFilter(
      id: 'visibility',
      label: l10n.adminContentVisibilityLabel,
      allLabel: l10n.staffTableFilterAll,
      options: ContentVisibility.values
          .map(
            (visibility) => StaffTableFilterOption(
              value: visibility.name,
              label: contentVisibilityLabel(l10n, visibility),
            ),
          )
          .toList(),
    ),
  ];
}

List<StaffTableColumn<ContentItem>> _buildColumns(AppLocalizations l10n) {
  return [
    StaffTableColumn(
      id: 'title',
      label: l10n.adminContentTitleLabel,
      flex: 4,
      sortable: true,
      cellBuilder: (context, item) => Text(
        item.title,
        style: Theme.of(context).textTheme.titleSmall,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    StaffTableColumn(
      id: 'type',
      label: l10n.adminContentTypeLabel,
      flex: 2,
      sortable: true,
      cellBuilder: (context, item) => _Badge(
        label: contentTypeLabel(l10n, item.type),
        color: AppColors.secondary,
        textColor: AppColors.primaryDark,
      ),
    ),
    StaffTableColumn(
      id: 'visibility',
      label: l10n.adminContentVisibilityLabel,
      flex: 2,
      sortable: true,
      cellBuilder: (context, item) => Text(
        contentVisibilityLabel(l10n, item.visibility),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
    StaffTableColumn(
      id: 'created_at',
      label: l10n.staffTableColumnCreated,
      flex: 2,
      sortable: true,
      cellBuilder: (context, item) => Text(
        MaterialLocalizations.of(context).formatMediumDate(item.createdAt),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
  ];
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sw(8), vertical: sh(4)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
