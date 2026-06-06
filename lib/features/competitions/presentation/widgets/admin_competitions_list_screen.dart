import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminCompetitionsListScreen extends ConsumerWidget {
  const AdminCompetitionsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final listAsync = ref.watch(adminCompetitionListProvider);

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.adminCompetitionsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.adminDashboard),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => unawaited(context.push(AppRoutes.adminCompetitionNew)),
        icon: const Icon(Icons.add),
        label: Text(l10n.adminCompetitionAdd),
      ),
      body: listAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.adminCompetitionsLoadError)),
        data: (items) {
          if (items.isEmpty) {
            return Center(child: Text(l10n.adminCompetitionsEmpty));
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(adminCompetitionListProvider.notifier).refresh(),
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 88.h),
              itemCount: items.length,
              separatorBuilder: (_, _) => SizedBox(height: 8.h),
              itemBuilder: (context, index) =>
                  _CompetitionAdminTile(competition: items[index]),
            ),
          );
        },
      ),
    );
  }
}

class _CompetitionAdminTile extends ConsumerWidget {
  const _CompetitionAdminTile({required this.competition});

  final Competition competition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: ListTile(
        title: Text(competition.title),
        subtitle: Text(
          competition.isActive
              ? l10n.adminCompetitionActiveLabel
              : l10n.adminCompetitionInactive,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => unawaited(
                context.push(
                  AppRoutes.adminCompetitionEditPath(competition.id),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _confirmDelete(context, ref, l10n),
            ),
          ],
        ),
        onTap: () => unawaited(
          context.push(AppRoutes.adminCompetitionEditPath(competition.id)),
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
