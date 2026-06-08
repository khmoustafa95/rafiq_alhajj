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
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminCompetitionsListScreen extends ConsumerStatefulWidget {
  const AdminCompetitionsListScreen({super.key});

  @override
  ConsumerState<AdminCompetitionsListScreen> createState() =>
      _AdminCompetitionsListScreenState();
}

class _AdminCompetitionsListScreenState
    extends ConsumerState<AdminCompetitionsListScreen> {
  StaffTableQuery _query = const StaffTableQuery(
    sortColumnId: 'title',
  );

  void _openNew() {
    if (AppPlatform.isWeb) {
      context.go(AppRoutes.adminCompetitionNew);
    } else {
      unawaited(context.push(AppRoutes.adminCompetitionNew));
    }
  }

  void _openEdit(String id) {
    final path = AppRoutes.adminCompetitionEditPath(id);
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
    }
  }

  Future<void> _confirmDelete(Competition competition) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminCompetitionDeleteTitle),
        content: Text(l10n.adminCompetitionDeleteMessage(competition.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.dialogCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.adminCompetitionDeleteConfirm),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) {
      return;
    }

    final ok = await ref
        .read(adminCompetitionListProvider.notifier)
        .deleteItem(competition.id);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? l10n.adminCompetitionDeleteSuccess
              : l10n.adminCompetitionDeleteError,
        ),
      ),
    );
  }

  PaginatedResult<Competition> _pageFrom(List<Competition> items) {
    return StaffTableProcessor.paginate(
      source: items,
      query: _query,
      searchValue: (item) =>
          '${item.title} ${item.description ?? ''}'.trim(),
      filterValues: {
        'status': (item) => item.isActive ? 'active' : 'inactive',
      },
      sortValues: {
        'title': (item) => item.title.toLowerCase(),
        'starts_at': (item) => item.startsAt,
        'ends_at': (item) => item.endsAt,
        'status': (item) => item.isActive ? 0 : 1,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final listAsync = ref.watch(adminCompetitionListProvider);

    final body = listAsync.when(
      skipLoadingOnReload: true,
      loading: () => AppPlatform.isWeb
          ? StaffDataTable<Competition>(
              columns: _columns(l10n),
              rows: const [],
              totalCount: 0,
              query: _query,
              onQueryChanged: (query) => setState(() => _query = query),
              searchHint: l10n.staffTableSearchCompetitions,
              filters: _filters(l10n),
              isLoading: true,
              emptyMessage: l10n.adminCompetitionsEmpty,
              emptyIcon: Icons.emoji_events_outlined,
            )
          : const Center(child: CircularProgressIndicator()),
      error: (_, _) => StaffEmptyState(
        message: l10n.adminCompetitionsLoadError,
        actionLabel: l10n.retry,
        onAction: () {
          unawaited(ref.read(adminCompetitionListProvider.notifier).refresh());
        },
      ),
      data: (items) {
        final page = _pageFrom(items);

        if (AppPlatform.isWeb) {
          return StaffDataTable<Competition>(
            columns: _columns(l10n),
            rows: page.items,
            totalCount: page.totalCount,
            query: _query,
            onQueryChanged: (query) => setState(() => _query = query),
            searchHint: l10n.staffTableSearchCompetitions,
            filters: _filters(l10n),
            isLoading: listAsync.isLoading,
            onRowTap: (competition) => _openEdit(competition.id),
            trailingBuilder: (context, competition) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  onPressed: () => _openEdit(competition.id),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 18),
                  onPressed: () => unawaited(_confirmDelete(competition)),
                ),
              ],
            ),
            emptyMessage: l10n.adminCompetitionsEmpty,
            emptyIcon: Icons.emoji_events_outlined,
          );
        }

        if (page.items.isEmpty) {
          return StaffEmptyState(
            message: l10n.adminCompetitionsEmpty,
            icon: Icons.emoji_events_outlined,
            actionLabel: l10n.adminCompetitionAdd,
            onAction: _openNew,
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(sw(16)),
          itemCount: page.items.length,
          itemBuilder: (context, index) {
            final competition = page.items[index];
            return ListTile(
              title: Text(competition.title),
              subtitle: Text(
                competition.isActive
                    ? l10n.adminCompetitionActiveLabel
                    : l10n.adminCompetitionInactive,
              ),
              onTap: () => _openEdit(competition.id),
            );
          },
        );
      },
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.adminCompetitionsTitle,
        scrollable: false,
        actions: [
          FilledButton.icon(
            onPressed: _openNew,
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.adminCompetitionAdd),
          ),
        ],
        body: body,
      ),
      mobile: Scaffold(
        appBar: RafiqAppBar(
          title: Text(l10n.adminCompetitionsTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go(AppRoutes.adminDashboard),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _openNew,
          icon: const Icon(Icons.add),
          label: Text(l10n.adminCompetitionAdd),
        ),
        body: body,
      ),
    );
  }

  List<StaffTableFilter> _filters(AppLocalizations l10n) {
    return [
      StaffTableFilter(
        id: 'status',
        label: l10n.staffTableFilterStatus,
        allLabel: l10n.staffTableFilterAll,
        options: [
          StaffTableFilterOption(
            value: 'active',
            label: l10n.adminCompetitionActiveLabel,
          ),
          StaffTableFilterOption(
            value: 'inactive',
            label: l10n.adminCompetitionInactive,
          ),
        ],
      ),
    ];
  }

  List<StaffTableColumn<Competition>> _columns(AppLocalizations l10n) {
    return [
      StaffTableColumn(
        id: 'title',
        label: l10n.adminContentTitleLabel,
        flex: 4,
        sortable: true,
        cellBuilder: (context, competition) => Text(
          competition.title,
          style: Theme.of(context).textTheme.titleSmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      StaffTableColumn(
        id: 'starts_at',
        label: l10n.adminCompetitionStartsAt,
        flex: 2,
        sortable: true,
        cellBuilder: (context, competition) => Text(
          MaterialLocalizations.of(context)
              .formatMediumDate(competition.startsAt),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      StaffTableColumn(
        id: 'ends_at',
        label: l10n.adminCompetitionEndsAt,
        flex: 2,
        sortable: true,
        cellBuilder: (context, competition) => Text(
          MaterialLocalizations.of(context).formatMediumDate(competition.endsAt),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      StaffTableColumn(
        id: 'status',
        label: l10n.staffTableFilterStatus,
        flex: 2,
        sortable: true,
        cellBuilder: (context, competition) => Container(
          padding: EdgeInsets.symmetric(horizontal: sw(8), vertical: sh(4)),
          decoration: BoxDecoration(
            color: competition.isActive
                ? AppColors.success.withValues(alpha: 0.12)
                : AppColors.chipInactive,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            competition.isActive
                ? l10n.adminCompetitionActiveLabel
                : l10n.adminCompetitionInactive,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: competition.isActive
                      ? AppColors.success
                      : AppColors.chipInactiveText,
                ),
          ),
        ),
      ),
    ];
  }
}
