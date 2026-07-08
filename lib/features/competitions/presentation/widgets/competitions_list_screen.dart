import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/widgets/rafiq_app_bar.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_list_card.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_list_hero.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_page_constraint.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class CompetitionsListScreen extends ConsumerWidget {
  const CompetitionsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final competitionsAsync = ref.watch(activeCompetitionsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: RafiqAppBar(title: Text(l10n.competitionsTitle)),
      body: competitionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => _CompetitionErrorState(
          message: l10n.competitionsLoadError,
          onRetry: () => ref.invalidate(activeCompetitionsProvider),
        ),
        data: (items) {
          if (items.isEmpty) {
            return _CompetitionErrorState(message: l10n.competitionsEmpty);
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(activeCompetitionsProvider.future),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 720;
                final crossAxisCount = isWide ? 2 : 1;

                return CompetitionPageConstraint(
                  maxWidth: isWide ? 960 : 720,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                        sliver: const SliverToBoxAdapter(
                          child: CompetitionListHero(),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                        sliver: SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 12.h,
                            crossAxisSpacing: 12.w,
                            childAspectRatio: isWide ? 2.4 : 1.55,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = items[index];
                              return CompetitionListCard(
                                competition: item,
                                onTap: () => unawaited(
                                  context.push(
                                    AppRoutes.competitionDetailPath(item.id),
                                  ),
                                ),
                              );
                            },
                            childCount: items.length,
                          ),
                        ),
                      ),
                    ],
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

class _CompetitionErrorState extends StatelessWidget {
  const _CompetitionErrorState({
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 56.sp,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 16.h),
              FilledButton(
                onPressed: onRetry,
                child: Text(AppLocalizations.of(context).retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
