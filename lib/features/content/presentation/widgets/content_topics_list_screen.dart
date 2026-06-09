import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_topics_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_topic_card.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class ContentTopicsListScreen extends ConsumerWidget {
  const ContentTopicsListScreen({super.key});

  void _openTopic(BuildContext context, String id) {
    unawaited(context.push(AppRoutes.contentTopicDetailPath(id)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final accessMode =
        ref.watch(authAccessModeProvider) == AppAccessMode.pilgrim
            ? AppAccessMode.pilgrim
            : AppAccessMode.guest;
    final topicsAsync = ref.watch(contentTopicsListProvider(accessMode));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: RafiqAppBar(title: Text(l10n.contentTopicsSection)),
      body: topicsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.contentLoadError,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                FilledButton(
                  onPressed: () =>
                      ref.invalidate(contentTopicsListProvider(accessMode)),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (topics) {
          if (topics.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Text(
                  l10n.contentTopicsEmpty,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(contentTopicsListProvider(accessMode));
              await ref.read(contentTopicsListProvider(accessMode).future);
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 600;

                if (isWide) {
                  return GridView.builder(
                    padding: EdgeInsets.all(16.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth >= 900 ? 3 : 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
                      final topic = topics[index];
                      return ContentTopicCard(
                        topic: topic,
                        layout: ContentTopicCardLayout.featured,
                        onTap: () => _openTopic(context, topic.id),
                      );
                    },
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.all(16.w),
                  itemCount: topics.length,
                  separatorBuilder: (_, _) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final topic = topics[index];
                    return ContentTopicCard(
                      topic: topic,
                      layout: ContentTopicCardLayout.featured,
                      onTap: () => _openTopic(context, topic.id),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
