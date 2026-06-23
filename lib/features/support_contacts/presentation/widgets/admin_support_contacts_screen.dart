import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_error_view.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact.dart';
import 'package:rafiq_alhajj/features/support_contacts/presentation/providers/support_contacts_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminSupportContactsScreen extends ConsumerWidget {
  const AdminSupportContactsScreen({super.key});

  void _openNew(BuildContext context) {
    if (AppPlatform.isWeb) {
      context.go(AppRoutes.adminSupportContactNew);
    } else {
      unawaited(context.push(AppRoutes.adminSupportContactNew));
    }
  }

  void _openEdit(BuildContext context, String id) {
    final path = AppRoutes.adminSupportContactEditPath(id);
    if (AppPlatform.isWeb) {
      context.go(path);
    } else {
      unawaited(context.push(path));
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    SupportContact contact,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminSupportContactDeleteTitle),
        content: Text(l10n.adminSupportContactDeleteMessage(contact.labelAr)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.dialogCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.adminSupportContactDeleteConfirm),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final ok =
        await ref.read(supportContactDeleteProvider.notifier).remove(contact.id);

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? l10n.adminSupportContactDeleteSuccess
              : l10n.adminSupportContactDeleteError,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final contactsAsync = ref.watch(adminSupportContactsProvider);

    final body = contactsAsync.when(
      skipLoadingOnReload: true,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => StaffErrorView.fromError(
        l10n,
        error: error,
        onRetry: () => ref.invalidate(adminSupportContactsProvider),
      ),
      data: (contacts) {
        if (contacts.isEmpty) {
          return StaffEmptyState(
            message: l10n.adminSupportContactsEmpty,
            icon: Icons.contact_phone_outlined,
            actionLabel: l10n.adminSupportContactAdd,
            onAction: () => _openNew(context),
          );
        }
        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: contacts.length,
          separatorBuilder: (_, _) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return _AdminContactCard(
              contact: contact,
              onEdit: () => _openEdit(context, contact.id),
              onDelete: () => unawaited(_confirmDelete(context, ref, contact)),
            );
          },
        );
      },
    );

    if (AppPlatform.isWeb) {
      return StaffWebPage(
        title: l10n.adminSupportContactsTitle,
        subtitle: l10n.adminSupportContactsSubtitle,
        scrollable: false,
        actions: [
          FilledButton.icon(
            onPressed: () => _openNew(context),
            icon: const Icon(Icons.add_call),
            label: Text(l10n.adminSupportContactAdd),
          ),
        ],
        body: body,
      );
    }

    return Scaffold(
      appBar: RafiqAppBar(title: Text(l10n.adminSupportContactsTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openNew(context),
        icon: const Icon(Icons.add_call),
        label: Text(l10n.adminSupportContactAdd),
      ),
      body: body,
    );
  }
}

class _AdminContactCard extends StatelessWidget {
  const _AdminContactCard({
    required this.contact,
    required this.onEdit,
    required this.onDelete,
  });

  final SupportContact contact;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scopeLabel = contact.scope == SupportContactScope.group
        ? (contact.groupName ?? l10n.adminSupportContactScopeGroup)
        : l10n.adminSupportContactScopeGlobal;

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
        child: Container(
          decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.labelAr,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    SizedBox(height: 6.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 6.h,
                      children: [
                        _Pill(
                          icon: contact.scope == SupportContactScope.group
                              ? Icons.groups_outlined
                              : Icons.public,
                          label: scopeLabel,
                          color: AppColors.tertiary,
                        ),
                        if (contact.hasPhone)
                          _Pill(
                            icon: Icons.call_rounded,
                            label: contact.phoneNumber!,
                            color: AppColors.primary,
                          ),
                        if (contact.hasWhatsapp)
                          _Pill(
                            icon: Icons.chat_rounded,
                            label: contact.whatsappNumber!,
                            color: AppColors.success,
                          ),
                        _Pill(
                          icon: contact.isActive
                              ? Icons.check_circle_outline
                              : Icons.pause_circle_outline,
                          label: contact.isActive
                              ? l10n.adminSupportContactActiveBadge
                              : l10n.adminSupportContactInactiveBadge,
                          color: contact.isActive
                              ? AppColors.success
                              : AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined),
                tooltip: l10n.adminContentSave,
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline),
                tooltip: l10n.adminSupportContactDeleteConfirm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.label, required this.color});

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDecorations.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: color),
          SizedBox(width: 4.w),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
