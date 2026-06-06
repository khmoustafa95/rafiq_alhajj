import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/providers/admin_content_providers.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/utils/content_meta_l10n.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminContentListScreen extends ConsumerWidget {
  const AdminContentListScreen({super.key});

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    ContentItem item,
  ) async {
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

    if (confirmed != true || !context.mounted) {
      return;
    }

    final ok = await ref
        .read(adminContentListProvider.notifier)
        .deleteItem(item.id);

    if (!context.mounted) {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final itemsAsync = ref.watch(adminContentListProvider);

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.adminContentListTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.adminDashboard),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => unawaited(context.push(AppRoutes.adminContentNew)),
        icon: const Icon(Icons.add),
        label: Text(l10n.adminContentAdd),
      ),
      body: itemsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.adminContentLoadError),
              SizedBox(height: 12.h),
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
          if (items.isEmpty) {
            return Center(child: Text(l10n.adminContentEmpty));
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(adminContentListProvider.notifier).refresh(),
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 88.h),
              itemCount: items.length,
              separatorBuilder: (_, _) => SizedBox(height: 8.h),
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text(
                      '${contentTypeLabel(l10n, item.type)} · '
                      '${contentVisibilityLabel(l10n, item.visibility)}',
                    ),
                    isThreeLine: item.description != null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          tooltip: l10n.adminContentEdit,
                          onPressed: () => unawaited(
                            context.push(
                              AppRoutes.adminContentEditPath(item.id),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: l10n.adminContentDeleteConfirm,
                          onPressed: () =>
                              unawaited(_confirmDelete(context, ref, item)),
                        ),
                      ],
                    ),
                    onTap: () => unawaited(
                      context.push(AppRoutes.adminContentEditPath(item.id)),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
