import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/utils/staff_table_processor.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_data_table.dart';
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
        .read(adminContentListProvider.notifier)
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

  PaginatedResult<ContentItem> _pageFrom(List<ContentItem> items) {
    return StaffTableProcessor.paginate(
      source: items,
      query: _query,
      searchValue: (item) =>
          '${item.title} ${item.description ?? ''}'.trim(),
      filterValues: {
        'type': (item) => item.type.name,
        'visibility': (item) => item.visibility.name,
      },
      sortValues: {
        'title': (item) => item.title.toLowerCase(),
        'type': (item) => item.type.name,
        'visibility': (item) => item.visibility.name,
        'created_at': (item) => item.createdAt,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final itemsAsync = ref.watch(adminContentListProvider);

    final content = itemsAsync.when(
      skipLoadingOnReload: true,
      loading: () => AppPlatform.isWeb
          ? StaffDataTable<ContentItem>(
              columns: _columns(l10n),
              rows: const [],
              totalCount: 0,
              query: _query,
              onQueryChanged: (query) => setState(() => _query = query),
              searchHint: l10n.staffTableSearchContent,
              filters: _filters(l10n),
              isLoading: true,
              emptyMessage: l10n.adminContentEmpty,
            )
          : const Center(child: CircularProgressIndicator()),
      error: (_, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.adminContentLoadError),
            SizedBox(height: sh(12)),
            FilledButton(
              onPressed: () {
                unawaited(
                  ref.read(adminContentListProvider.notifier).refresh(),
                );
              },
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
      data: (items) {
        final page = _pageFrom(items);

        if (AppPlatform.isWeb) {
          return StaffDataTable<ContentItem>(
            columns: _columns(l10n),
            rows: page.items,
            totalCount: page.totalCount,
            query: _query,
            onQueryChanged: (query) => setState(() => _query = query),
            searchHint: l10n.staffTableSearchContent,
            filters: _filters(l10n),
            isLoading: itemsAsync.isLoading,
            onRowTap: (item) => _openEdit(item.id),
            trailingBuilder: (context, item) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  onPressed: () => _openEdit(item.id),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 18),
                  onPressed: () => unawaited(_confirmDelete(item)),
                ),
              ],
            ),
            emptyMessage: l10n.adminContentEmpty,
            emptyIcon: Icons.article_outlined,
          );
        }

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
        actions: [
          FilledButton.icon(
            onPressed: _openNew,
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.adminContentAdd),
          ),
        ],
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

  List<StaffTableFilter> _filters(AppLocalizations l10n) {
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

  List<StaffTableColumn<ContentItem>> _columns(AppLocalizations l10n) {
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
