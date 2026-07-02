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
import 'package:rafiq_alhajj/core/widgets/staff_table_definition_cache.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/providers/admin_content_topics_providers.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/utils/content_meta_l10n.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_publication_status.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminContentTopicsListScreen extends ConsumerStatefulWidget {
  const AdminContentTopicsListScreen({this.embedded = false, super.key});

  final bool embedded;

  @override
  ConsumerState<AdminContentTopicsListScreen> createState() =>
      _AdminContentTopicsListScreenState();
}

class _AdminContentTopicsListScreenState
    extends ConsumerState<AdminContentTopicsListScreen> {
  late StaffTableQuery _query = const StaffTableQuery(sortColumnId: 'title_ar');

  late final StaffTableDefinitionCache<ContentTopic> _tableDefs =
      StaffTableDefinitionCache<ContentTopic>(
    buildColumns: _buildColumns,
    buildFilters: _buildFilters,
  );

  void _openNew(BuildContext context) {
    const path = AppRoutes.adminContentTopicNew;
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
    }
  }

  void _openEdit(BuildContext context, String id) {
    final path = AppRoutes.adminContentTopicEditPath(id);
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    ContentTopic topic,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminContentTopicDeleteTitle),
        content: Text(l10n.adminContentTopicDeleteMessage(topic.titleAr)),
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

    if (confirmed != true || !context.mounted) {
      return;
    }

    final ok = await ref
        .read(adminContentTopicDeleteProvider.notifier)
        .deleteTopic(topic.id);

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? l10n.adminContentTopicDeleteSuccess
              : l10n.adminContentTopicDeleteError,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pageAsync = ref.watch(adminContentTopicsPageProvider(_query));

    final table = StaffAsyncTableBody<ContentTopic>(
      tableKey: const ValueKey('admin-content-topics-table'),
      pageAsync: pageAsync,
      query: _query,
      onQueryChanged: (query) => setState(() => _query = query),
      columns: _tableDefs.columns(context),
      searchHint: l10n.staffTableSearchContent,
      filters: _tableDefs.filters(context),
      toolbarActions: [
        StaffToolbarButton(
          icon: Icons.add_rounded,
          label: l10n.adminContentTopicAdd,
          onPressed: () => _openNew(context),
          primary: true,
        ),
      ],
      onRetry: () => ref.invalidate(adminContentTopicsPageProvider(_query)),
      onRowTap: (topic) => _openEdit(context, topic.id),
      trailingBuilder: (context, topic) => StaffTableRowActions(
        children: [
          StaffTableRowActions.iconButton(
            icon: Icons.edit_outlined,
            onPressed: () => _openEdit(context, topic.id),
          ),
          StaffTableRowActions.iconButton(
            icon: Icons.delete_outline,
            onPressed: () => unawaited(_confirmDelete(context, topic)),
          ),
        ],
      ),
      emptyMessage: l10n.adminContentTopicEmpty,
      emptyIcon: Icons.menu_book_outlined,
    );

    if (AppPlatform.isWeb) {
      if (widget.embedded) {
        return table;
      }
      return StaffWebPage(
        title: l10n.adminContentTopicsListTitle,
        scrollable: false,
        actions: [
          FilledButton.icon(
            onPressed: () => _openNew(context),
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.adminContentTopicAdd),
          ),
        ],
        body: table,
      );
    }

    return Scaffold(
      appBar: widget.embedded
          ? null
          : RafiqAppBar(
              title: Text(l10n.adminContentTopicsListTitle),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.go(AppRoutes.adminContent),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openNew(context),
        icon: const Icon(Icons.add),
        label: Text(l10n.adminContentTopicAdd),
      ),
      body: pageAsync.when(
        skipLoadingOnReload: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.adminContentTopicLoadError)),
        data: (page) {
          if (page.items.isEmpty) {
            return Center(child: Text(l10n.adminContentTopicEmpty));
          }
          return ListView.builder(
            padding: EdgeInsets.all(sw(16)),
            itemCount: page.items.length,
            itemBuilder: (context, index) {
              final topic = page.items[index];
              return Card(
                child: ListTile(
                  title: Text(topic.titleAr),
                  subtitle: Text(
                    '${contentVisibilityLabel(l10n, topic.visibility)} · '
                    '${topic.media.length} ${l10n.adminContentTopicMediaItems}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: AppColors.error,
                    ),
                    onPressed: () => unawaited(_confirmDelete(context, topic)),
                  ),
                  onTap: () => _openEdit(context, topic.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

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
    StaffTableFilter(
      id: 'publication_status',
      label: l10n.adminContentPublicationStatusLabel,
      allLabel: l10n.staffTableFilterAll,
      options: ContentPublicationStatus.values
          .map(
            (status) => StaffTableFilterOption(
              value: status.name,
              label: status == ContentPublicationStatus.draft
                  ? l10n.adminContentPublicationDraft
                  : l10n.adminContentPublicationPublished,
            ),
          )
          .toList(),
    ),
  ];
}

List<StaffTableColumn<ContentTopic>> _buildColumns(AppLocalizations l10n) {
  return [
    StaffTableColumn(
      id: 'title_ar',
      label: l10n.adminContentTitleArLabel,
      flex: 4,
      sortable: true,
      cellBuilder: (context, topic) => Text(
        topic.titleAr,
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
      cellBuilder: (context, topic) =>
          StaffCellText(contentVisibilityLabel(l10n, topic.visibility)),
    ),
    StaffTableColumn(
      id: 'publication_status',
      label: l10n.adminContentPublicationStatusLabel,
      flex: 2,
      sortable: true,
      cellBuilder: (context, topic) => StaffCellText(
        topic.publicationStatus == ContentPublicationStatus.draft
            ? l10n.adminContentPublicationDraft
            : l10n.adminContentPublicationPublished,
      ),
    ),
    StaffTableColumn(
      id: 'sort_order',
      label: l10n.adminHajjJourneySortOrder,
      sortable: true,
      cellBuilder: (context, topic) => StaffCellText('${topic.sortOrder}'),
    ),
    StaffTableColumn(
      id: 'created_at',
      label: l10n.staffTableColumnCreated,
      flex: 2,
      sortable: true,
      cellBuilder: (context, topic) => StaffCellText(
        MaterialLocalizations.of(context).formatMediumDate(topic.createdAt),
      ),
    ),
  ];
}
