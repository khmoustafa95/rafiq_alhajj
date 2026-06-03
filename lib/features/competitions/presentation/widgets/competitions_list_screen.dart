import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class CompetitionsListScreen extends ConsumerWidget {
  const CompetitionsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final competitionsAsync = ref.watch(activeCompetitionsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.competitionsTitle)),
      body: competitionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.competitionsLoadError)),
        data: (items) {
          if (items.isEmpty) {
            return Center(child: Text(l10n.competitionsEmpty));
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(activeCompetitionsProvider.future),
            child: ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: items.length,
              separatorBuilder: (_, _) => SizedBox(height: 8.h),
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text(
                      item.description ?? l10n.competitionsNoDescription,
                    ),
                    trailing: Icon(
                      item.isOpen ? Icons.play_circle_outline : Icons.schedule,
                    ),
                    onTap: () => unawaited(
                      context.push(AppRoutes.competitionDetailPath(item.id)),
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
