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
import 'package:rafiq_alhajj/features/admin_content/presentation/widgets/admin_content_topics_list_screen.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Content management hub: three surfaces in tabs — Announcements, News
/// (`content_library` feed items) and the Educational Library (`content_topics`).
class AdminContentListScreen extends StatelessWidget {
  const AdminContentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final tabBar = TabBar(
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      tabs: [
        Tab(text: l10n.adminContentTabAnnouncements),
        Tab(text: l10n.adminContentTabNews),
        Tab(text: l10n.adminContentTabLibrary),
      ],
    );

    const views = TabBarView(
      children: [
        _FeedContentTab(typeScope: ContentType.announcement),
        _FeedContentTab(typeScope: ContentType.news),
        AdminContentTopicsListScreen(embedded: true),
      ],
    );

    if (AppPlatform.isWeb) {
      return DefaultTabController(
        length: 3,
        child: StaffWebPage(
          title: l10n.adminContentListTitle,
          scrollable: false,
          top: Align(alignment: Alignment.centerLeft, child: tabBar),
          body: views,
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: RafiqAppBar(
          title: Text(l10n.adminContentListTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go(AppRoutes.adminDashboard),
          ),
          bottom: tabBar,
        ),
        body: views,
      ),
    );
  }
}

/// A single feed surface (Announcements or News) backed by `content_library`,
/// scoped to [typeScope]. Keeps the shared staff table machinery but bakes the
/// type filter in and wires its "new" action to the right editor.
class _FeedContentTab extends ConsumerStatefulWidget {
  const _FeedContentTab({required this.typeScope});

  final ContentType typeScope;

  @override
  ConsumerState<_FeedContentTab> createState() => _FeedContentTabState();
}

class _FeedContentTabState extends ConsumerState<_FeedContentTab>
    with AutomaticKeepAliveClientMixin {
  late StaffTableQuery _query = StaffTableQuery(
    sortColumnId: 'title',
    filters: {'type': widget.typeScope.name},
  );

  late final StaffTableDefinitionCache<ContentItem> _tableDefs =
      StaffTableDefinitionCache<ContentItem>(
    buildColumns: _buildColumns,
    buildFilters: _buildFilters,
  );

  @override
  bool get wantKeepAlive => true;

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
    final path = AppRoutes.adminContentNewTypedPath(widget.typeScope.name);
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
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

  void _onQueryChanged(StaffTableQuery query) {
    // Keep the type scope pinned even if other filters change.
    setState(() {
      _query = query.copyWith(
        filters: {...query.filters, 'type': widget.typeScope.name},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = AppLocalizations.of(context);
    final pageAsync = ref.watch(adminContentListPageProvider(_query));

    if (AppPlatform.isWeb) {
      return StaffAsyncTableBody<ContentItem>(
        tableKey: ValueKey('admin-content-table-${widget.typeScope.name}'),
        pageAsync: pageAsync,
        query: _query,
        onQueryChanged: _onQueryChanged,
        columns: _tableDefs.columns(context),
        searchHint: l10n.staffTableSearchContent,
        filters: _tableDefs.filters(context),
        toolbarActions: [
          StaffToolbarButton(
            icon: Icons.add_rounded,
            label: l10n.adminContentAdd,
            onPressed: _openNew,
            primary: true,
          ),
        ],
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
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openNew,
        icon: const Icon(Icons.add),
        label: Text(l10n.adminContentAdd),
      ),
      body: pageAsync.when(
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
                subtitle: Text(contentVisibilityLabel(l10n, item.visibility)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppColors.error),
                  onPressed: () => unawaited(_confirmDelete(item)),
                ),
                onTap: () => _openEdit(item.id),
              );
            },
          );
        },
      ),
    );
  }
}

/// The type filter is intentionally omitted: each tab already scopes its type.
List<StaffTableFilter> _buildFilters(AppLocalizations l10n) {
  return [
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
      id: 'visibility',
      label: l10n.adminContentVisibilityLabel,
      flex: 2,
      sortable: true,
      cellBuilder: (context, item) =>
          StaffCellText(contentVisibilityLabel(l10n, item.visibility)),
    ),
    StaffTableColumn(
      id: 'created_at',
      label: l10n.staffTableColumnCreated,
      flex: 2,
      sortable: true,
      cellBuilder: (context, item) => StaffCellText(
        MaterialLocalizations.of(context).formatMediumDate(item.createdAt),
      ),
    ),
  ];
}
