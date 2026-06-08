import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_responsive_grid.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminCompetitionsListScreen extends ConsumerWidget {
  const AdminCompetitionsListScreen({super.key});

  void _openNew(BuildContext context) {
    if (AppPlatform.isWeb) {
      context.go(AppRoutes.adminCompetitionNew);
    } else {
      unawaited(context.push(AppRoutes.adminCompetitionNew));
    }
  }

  void _openEdit(BuildContext context, String id) {
    final path = AppRoutes.adminCompetitionEditPath(id);
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final listAsync = ref.watch(adminCompetitionListProvider);

    final body = listAsync.when(
      skipLoadingOnReload: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => StaffEmptyState(
        message: l10n.adminCompetitionsLoadError,
        actionLabel: l10n.retry,
        onAction: () {
          unawaited(ref.read(adminCompetitionListProvider.notifier).refresh());
        },
      ),
      data: (items) {
        if (items.isEmpty) {
          return StaffEmptyState(
            message: l10n.adminCompetitionsEmpty,
            icon: Icons.emoji_events_outlined,
            actionLabel: l10n.adminCompetitionAdd,
            onAction: () => _openNew(context),
          );
        }

        return RefreshIndicator(
          onRefresh: () =>
              ref.read(adminCompetitionListProvider.notifier).refresh(),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              StaffResponsiveGrid(
                minItemWidth: 300,
                spacing: sw(16),
                children: items
                    .map(
                      (competition) => _CompetitionCard(
                        competition: competition,
                        onEdit: () => _openEdit(context, competition.id),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: sh(24)),
            ],
          ),
        );
      },
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.adminCompetitionsTitle,
        actions: [
          FilledButton.icon(
            onPressed: () => _openNew(context),
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.adminCompetitionAdd),
          ),
        ],
        scrollable: false,
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
          onPressed: () => _openNew(context),
          icon: const Icon(Icons.add),
          label: Text(l10n.adminCompetitionAdd),
        ),
        body: body,
      ),
    );
  }
}

class _CompetitionCard extends ConsumerWidget {
  const _CompetitionCard({
    required this.competition,
    required this.onEdit,
  });

  final Competition competition;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: DecoratedBox(
          decoration: AppDecorations.card(),
          child: Padding(
            padding: EdgeInsets.all(sw(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(sw(8)),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.emoji_events_outlined,
                        color: AppColors.primary,
                        size: ss(22),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: sw(8),
                        vertical: sh(4),
                      ),
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh(12)),
                Text(
                  competition.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: sh(16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      onPressed: onEdit,
                      visualDensity: VisualDensity.compact,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20),
                      onPressed: () => _confirmDelete(context, ref, l10n),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
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

    if (confirmed != true || !context.mounted) {
      return;
    }

    final ok = await ref
        .read(adminCompetitionListProvider.notifier)
        .deleteItem(competition.id);

    if (!context.mounted) {
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
}
