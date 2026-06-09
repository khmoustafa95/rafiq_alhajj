import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/providers/admin_content_topics_providers.dart';
import 'package:rafiq_alhajj/features/admin_content/presentation/utils/content_meta_l10n.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminContentTopicsListScreen extends ConsumerWidget {
  const AdminContentTopicsListScreen({super.key});

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
    WidgetRef ref,
    ContentTopic topic,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminContentTopicDeleteTitle),
        content: Text(l10n.adminContentTopicDeleteMessage(topic.title)),
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
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final topicsAsync = ref.watch(adminContentTopicsListProvider);

    final body = topicsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => Center(child: Text(l10n.adminContentTopicLoadError)),
      data: (topics) {
        if (topics.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.adminContentTopicEmpty),
                SizedBox(height: 12.h),
                FilledButton.icon(
                  onPressed: () => _openNew(context),
                  icon: const Icon(Icons.add),
                  label: Text(l10n.adminContentTopicAdd),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: topics.length,
          separatorBuilder: (_, _) => SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            final topic = topics[index];
            return Card(
              child: ListTile(
                title: Text(topic.title),
                subtitle: Text(
                  '${contentVisibilityLabel(l10n, topic.visibility)} · '
                  '${topic.media.length} ${l10n.adminContentTopicMediaItems}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () => _openEdit(context, topic.id),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppColors.error,
                      ),
                      onPressed: () =>
                          unawaited(_confirmDelete(context, ref, topic)),
                    ),
                  ],
                ),
                onTap: () => _openEdit(context, topic.id),
              ),
            );
          },
        );
      },
    );

    if (AppPlatform.isWeb) {
      return StaffWebPage(
        title: l10n.adminContentTopicsListTitle,
        actions: [
          FilledButton.icon(
            onPressed: () => _openNew(context),
            icon: const Icon(Icons.add_rounded),
            label: Text(l10n.adminContentTopicAdd),
          ),
        ],
        body: body,
      );
    }

    return Scaffold(
      appBar: RafiqAppBar(
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
      body: body,
    );
  }
}
