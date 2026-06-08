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

  void _openNew(BuildContext context) {
    if (AppPlatform.isWeb) {
      context.go(AppRoutes.adminContentNew);
    } else {
      unawaited(context.push(AppRoutes.adminContentNew));
    }
  }

  void _openEdit(BuildContext context, String id) {
    final path = AppRoutes.adminContentEditPath(id);
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final itemsAsync = ref.watch(adminContentListProvider);

    final content = itemsAsync.when(
      skipLoadingOnReload: true,
      loading: () => const Center(child: CircularProgressIndicator()),
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
        if (items.isEmpty) {
          return StaffEmptyState(
            message: l10n.adminContentEmpty,
            icon: Icons.article_outlined,
            actionLabel: l10n.adminContentAdd,
            onAction: () => _openNew(context),
          );
        }

        return RefreshIndicator(
          onRefresh: () =>
              ref.read(adminContentListProvider.notifier).refresh(),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              StaffResponsiveGrid(
                minItemWidth: 280,
                maxColumns: 4,
                spacing: sw(16),
                children: [
                  ...items.map(
                    (item) => _AdminContentCard(
                      item: item,
                      l10n: l10n,
                      onEdit: () => _openEdit(context, item.id),
                      onDelete: () =>
                          unawaited(_confirmDelete(context, ref, item)),
                    ),
                  ),
                  _AddContentCard(onTap: () => _openNew(context)),
                ],
              ),
              SizedBox(height: sh(24)),
            ],
          ),
        );
      },
    );

    if (AppPlatform.isWeb) {
      return StaffWebPage(
        title: l10n.adminContentListTitle,
        scrollable: false,
        actions: [
          FilledButton.icon(
            onPressed: () => _openNew(context),
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
        onPressed: () => _openNew(context),
        icon: const Icon(Icons.add),
        label: Text(l10n.adminContentAdd),
      ),
      body: content,
    );
  }
}

class _AdminContentCard extends StatelessWidget {
  const _AdminContentCard({
    required this.item,
    required this.l10n,
    required this.onEdit,
    required this.onDelete,
  });

  final ContentItem item;
  final AppLocalizations l10n;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: DecoratedBox(
          decoration: AppDecorations.card(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: sh(112),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppDecorations.radiusMd),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.85),
                        AppColors.primaryDark,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.article_rounded,
                          size: ss(36),
                          color: AppColors.onPrimary.withValues(alpha: 0.9),
                        ),
                      ),
                      PositionedDirectional(
                        top: sh(8),
                        end: sw(8),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: sw(8),
                            vertical: sh(4),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            contentTypeLabel(l10n, item.type),
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryDark,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(sw(14)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.description != null) ...[
                      SizedBox(height: sh(6)),
                      Text(
                        item.description!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    SizedBox(height: sh(12)),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: ss(8),
                          color: AppColors.success,
                        ),
                        SizedBox(width: sw(6)),
                        Expanded(
                          child: Text(
                            contentVisibilityLabel(l10n, item.visibility),
                            style: Theme.of(context).textTheme.labelSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          onPressed: onEdit,
                          visualDensity: VisualDensity.compact,
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 18),
                          onPressed: onDelete,
                          visualDensity: VisualDensity.compact,
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddContentCard extends StatelessWidget {
  const _AddContentCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
            border: Border.all(
              color: AppColors.border,
              width: 1.5,
            ),
          ),
          child: SizedBox(
            height: sh(220),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline_rounded,
                  size: ss(36),
                  color: AppColors.textSecondary,
                ),
                SizedBox(height: sh(8)),
                Text(
                  l10n.adminContentAdd,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
