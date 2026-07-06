import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_page_constraint.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_progress_header.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/providers/hajj_journey_providers.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/widgets/hajj_journey_learning_path.dart';
import 'package:rafiq_alhajj/features/pilgrim/presentation/providers/pilgrim_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class HajjJourneyPathScreen extends ConsumerWidget {
  const HajjJourneyPathScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final journeyAsync = ref.watch(hajjJourneyStateProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: journeyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) {
          if (error is PilgrimAccessDeniedException) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.pilgrimSignInRequired),
                    SizedBox(height: 16.h),
                    FilledButton(
                      onPressed: () => context.go(AppRoutes.login),
                      child: Text(l10n.homeSignInAsPilgrim),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(child: Text(l10n.hajjJourneyLoadError));
        },
        data: (journey) {
          return CompetitionPageConstraint(
            child: RefreshIndicator(
              onRefresh: () =>
                  ref.read(pilgrimDashboardStateProvider.notifier).refresh(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: CompetitionProgressHeader(
                      title: l10n.pilgrimDashboardTitle,
                      description: l10n.hajjJourneyHeroSubtitle,
                      answeredCount: journey.completedCount,
                      totalQuestions: journey.totalCount,
                      onBack: Navigator.canPop(context)
                          ? () => context.pop()
                          : null,
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        if (journey.hasPendingSync)
                          DecoratedBox(
                            decoration: AppDecorations.card(
                              color: AppColors.secondary.withValues(alpha: 0.08),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Text(
                                l10n.pilgrimSyncPending,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                        if (journey.hasPendingSync) SizedBox(height: 16.h),
                        if (journey.currentStep != null)
                          _CurrentStepCard(
                            step: journey.currentStep!,
                            onTap: () => _openRitual(
                              context,
                              journey.currentStep!.step.ritualKey,
                            ),
                          ),
                        if (journey.currentStep != null) SizedBox(height: 20.h),
                        HajjJourneyLearningPath(
                          steps: journey.steps,
                          onStepTap: (step) => _openRitual(
                            context,
                            step.step.ritualKey,
                          ),
                          onLockedTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.hajjJourneyStepLocked),
                              ),
                            );
                          },
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _openRitual(BuildContext context, String ritualKey) {
    unawaited(context.push(AppRoutes.hajjRitualDetailPath(ritualKey)));
  }
}

class _CurrentStepCard extends StatelessWidget {
  const _CurrentStepCard({
    required this.step,
    required this.onTap,
  });

  final HajjJourneyStepWithStatus step;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final title =
        isArabic ? step.step.titleAr : step.step.titleEn;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.secondary.withValues(alpha: 0.15),
                AppColors.primary.withValues(alpha: 0.08),
              ],
            ),
            borderRadius: BorderRadius.circular(AppDecorations.radiusLg),
            border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
          ),
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: AppColors.onSecondary,
                  size: 28.sp,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.hajjJourneyContinue,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
