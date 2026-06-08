import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminCompetitionsListScreen extends ConsumerWidget {
  const AdminCompetitionsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final listAsync = ref.watch(adminCompetitionListProvider);

    final body = listAsync.when(
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
            onAction: () =>
                unawaited(context.push(AppRoutes.adminCompetitionNew)),
          );
        }

        return RefreshIndicator(
          onRefresh: () =>
              ref.read(adminCompetitionListProvider.notifier).refresh(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 900
                  ? 3
                  : constraints.maxWidth > 560
                      ? 2
                      : 1;

              return GridView.builder(
                padding: EdgeInsets.only(bottom: 24.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: crossAxisCount == 1 ? 2.8 : 1.4,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) =>
                    _CompetitionCard(competition: items[index]),
              );
            },
          ),
        );
      },
    );

    return StaffAdaptivePage(
      web: StaffWebPage(
        title: l10n.adminCompetitionsTitle,
        actions: [
          FilledButton.icon(
            onPressed: () =>
                unawaited(context.push(AppRoutes.adminCompetitionNew)),
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
          onPressed: () =>
              unawaited(context.push(AppRoutes.adminCompetitionNew)),
          icon: const Icon(Icons.add),
          label: Text(l10n.adminCompetitionAdd),
        ),
        body: body,
      ),
    );
  }
}

class _CompetitionCard extends ConsumerWidget {
  const _CompetitionCard({required this.competition});

  final Competition competition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: InkWell(
        onTap: () => unawaited(
          context.push(AppRoutes.adminCompetitionEditPath(competition.id)),
        ),
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: DecoratedBox(
          decoration: AppDecorations.card(),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.emoji_events_outlined,
                        color: AppColors.primary,
                        size: 22.sp,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  competition.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      onPressed: () => unawaited(
                        context.push(
                          AppRoutes.adminCompetitionEditPath(competition.id),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20),
                      onPressed: () => _confirmDelete(context, ref, l10n),
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
          ok ? l10n.adminCompetitionDeleteSuccess : l10n.adminCompetitionDeleteError,
        ),
      ),
    );
  }
}
