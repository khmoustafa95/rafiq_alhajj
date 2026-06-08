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
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_account.dart';
import 'package:rafiq_alhajj/features/admin_operators/presentation/providers/admin_operators_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminOperatorsListScreen extends ConsumerWidget {
  const AdminOperatorsListScreen({super.key});

  void _openNew(BuildContext context) {
    if (AppPlatform.isWeb) {
      context.go(AppRoutes.adminOperatorNew);
    } else {
      unawaited(context.push(AppRoutes.adminOperatorNew));
    }
  }

  void _openEdit(BuildContext context, String id) {
    final path = AppRoutes.adminOperatorEditPath(id);
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final operatorsAsync = ref.watch(adminOperatorListProvider);

    final content = operatorsAsync.when(
      skipLoadingOnReload: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.adminOperatorLoadError),
            SizedBox(height: sh(12)),
            FilledButton(
              onPressed: () {
                unawaited(
                  ref.read(adminOperatorListProvider.notifier).refresh(),
                );
              },
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
      data: (operators) {
        if (operators.isEmpty) {
          return StaffEmptyState(
            message: l10n.adminOperatorEmpty,
            icon: Icons.badge_outlined,
            actionLabel: l10n.adminOperatorAdd,
            onAction: () => _openNew(context),
          );
        }

        return RefreshIndicator(
          onRefresh: () =>
              ref.read(adminOperatorListProvider.notifier).refresh(),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              StaffResponsiveGrid(
                minItemWidth: 300,
                spacing: sw(16),
                children: [
                  ...operators.map(
                    (operator) => _OperatorCard(
                      operator: operator,
                      l10n: l10n,
                      onTap: () => _openEdit(context, operator.id),
                    ),
                  ),
                  _AddOperatorCard(
                    label: l10n.adminOperatorAdd,
                    onTap: () => _openNew(context),
                  ),
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
        title: l10n.adminOperatorsTitle,
        subtitle: l10n.adminOperatorsSubtitle,
        scrollable: false,
        actions: [
          FilledButton.icon(
            onPressed: () => _openNew(context),
            icon: const Icon(Icons.person_add_alt_1_rounded),
            label: Text(l10n.adminOperatorAdd),
          ),
        ],
        body: content,
      );
    }

    return Scaffold(
      appBar: RafiqAppBar(
        title: Text(l10n.adminOperatorsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(AppRoutes.adminDashboard),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openNew(context),
        icon: const Icon(Icons.person_add_alt_1),
        label: Text(l10n.adminOperatorAdd),
      ),
      body: content,
    );
  }
}

class _OperatorCard extends StatelessWidget {
  const _OperatorCard({
    required this.operator,
    required this.l10n,
    required this.onTap,
  });

  final OperatorAccount operator;
  final AppLocalizations l10n;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: DecoratedBox(
          decoration: AppDecorations.card(),
          child: Padding(
            padding: EdgeInsets.all(sw(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: sr(22),
                      backgroundColor:
                          AppColors.primary.withValues(alpha: 0.12),
                      child: Icon(
                        Icons.badge_outlined,
                        color: AppColors.primary,
                        size: ss(22),
                      ),
                    ),
                    SizedBox(width: sw(12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            operator.fullName,
                            style: theme.textTheme.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: sh(2)),
                          Text(
                            operator.email,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    _StatusChip(
                      active: operator.isActive,
                      activeLabel: l10n.adminOperatorActiveLabel,
                      inactiveLabel: l10n.adminOperatorInactive,
                    ),
                  ],
                ),
                SizedBox(height: sh(12)),
                Wrap(
                  spacing: sw(6),
                  runSpacing: sh(6),
                  children: [
                    if (operator.permissions.canRegisterPilgrims)
                      _PermChip(label: l10n.adminOperatorPermRegister),
                    if (operator.permissions.canManagePilgrimRegistry)
                      _PermChip(label: l10n.adminOperatorPermRegistry),
                    if (operator.permissions.canUseFieldTools)
                      _PermChip(label: l10n.adminOperatorPermField),
                    if (operator.permissions.canUploadDocuments)
                      _PermChip(label: l10n.adminOperatorPermUpload),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.active,
    required this.activeLabel,
    required this.inactiveLabel,
  });

  final bool active;
  final String activeLabel;
  final String inactiveLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sw(8), vertical: sh(4)),
      decoration: BoxDecoration(
        color: active
            ? AppColors.success.withValues(alpha: 0.12)
            : AppColors.error.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppDecorations.radiusSm),
      ),
      child: Text(
        active ? activeLabel : inactiveLabel,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: active ? AppColors.success : AppColors.error,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _PermChip extends StatelessWidget {
  const _PermChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sw(8), vertical: sh(4)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDecorations.radiusSm),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

class _AddOperatorCard extends StatelessWidget {
  const _AddOperatorCard({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.35),
              width: 1.5,
            ),
          ),
          child: SizedBox(
            height: sh(140),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline_rounded,
                  size: ss(32),
                  color: AppColors.primary,
                ),
                SizedBox(height: sh(8)),
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
