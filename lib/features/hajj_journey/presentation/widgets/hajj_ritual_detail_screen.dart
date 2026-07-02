import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_page_constraint.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/providers/hajj_journey_providers.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/widgets/hajj_journey_offline_actions.dart';
import 'package:rafiq_alhajj/features/hajj_journey/presentation/widgets/hajj_ritual_media_viewer.dart';
import 'package:rafiq_alhajj/features/pilgrim/presentation/providers/pilgrim_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class HajjRitualDetailScreen extends ConsumerStatefulWidget {
  const HajjRitualDetailScreen({required this.ritualKey, super.key});

  final String ritualKey;

  @override
  ConsumerState<HajjRitualDetailScreen> createState() =>
      _HajjRitualDetailScreenState();
}

class _HajjRitualDetailScreenState extends ConsumerState<HajjRitualDetailScreen> {
  bool _isCompleting = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final stepAsync = ref.watch(hajjJourneyStepByKeyProvider(widget.ritualKey));
    final journeyAsync = ref.watch(hajjJourneyStateProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: stepAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.hajjJourneyLoadError)),
        data: (step) {
          if (step == null) {
            return Center(child: Text(l10n.hajjJourneyStepNotFound));
          }

          final journey = journeyAsync.value;
          final stepStatus = journey?.steps
              .where((s) => s.step.ritualKey == widget.ritualKey)
              .firstOrNull;
          final isCompleted = stepStatus?.isCompleted ?? false;
          final stepIndex = journey?.steps.indexWhere(
                (s) => s.step.ritualKey == widget.ritualKey,
              ) ??
              -1;
          final isLocked = journey != null &&
              stepIndex > 0 &&
              !journey.isUnlocked(stepIndex);

          final title = isArabic ? step.titleAr : step.titleEn;
          final description =
              isArabic ? step.descriptionAr : step.descriptionEn;

          return CompetitionPageConstraint(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 140.h,
                  pinned: true,
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textOnDark,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textOnDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary,
                            AppColors.primaryDark,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 32.h),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      DecoratedBox(
                        decoration: AppDecorations.card(
                          radius: AppDecorations.radiusLg,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.hajjJourneyAboutRitual,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                description,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      if (!AppPlatform.isWeb) ...[
                        HajjJourneyOfflineActions(step: step),
                        SizedBox(height: 16.h),
                      ],
                      HajjRitualMediaViewer(media: step.media),
                      SizedBox(height: 24.h),
                      if (isLocked)
                        DecoratedBox(
                          decoration: AppDecorations.card(
                            color: AppColors.surfaceMuted,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: Row(
                              children: [
                                const Icon(Icons.lock_outline),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(l10n.hajjJourneyStepLocked),
                                ),
                              ],
                            ),
                          ),
                        )
                      else if (isCompleted)
                        FilledButton.tonalIcon(
                          onPressed: () => context.pop(),
                          icon: const Icon(Icons.check_circle_outline),
                          label: Text(l10n.hajjJourneyAlreadyCompleted),
                        )
                      else
                        FilledButton.icon(
                          onPressed: _isCompleting ? null : () => _complete(context),
                          icon: _isCompleting
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.check_rounded),
                          label: Text(l10n.hajjJourneyMarkComplete),
                          style: FilledButton.styleFrom(
                            minimumSize: Size(double.infinity, 52.h),
                            backgroundColor: AppColors.secondary,
                            foregroundColor: AppColors.onSecondary,
                          ),
                        ),
                    ]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _complete(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    setState(() => _isCompleting = true);

    try {
      await ref
          .read(pilgrimDashboardStateProvider.notifier)
          .toggleRitual(widget.ritualKey, true);

      if (!context.mounted) {
        return;
      }

      final journey = await ref.read(hajjJourneyStateProvider.future);
      if (!context.mounted) {
        return;
      }

      final currentIndex = journey.steps.indexWhere(
        (s) => s.step.ritualKey == widget.ritualKey,
      );
      final nextStep = currentIndex >= 0 && currentIndex + 1 < journey.steps.length
          ? journey.steps[currentIndex + 1]
          : null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.hajjJourneyCompletedSnack)),
      );

      if (nextStep != null && context.mounted) {
        final goNext = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l10n.hajjJourneyNextStepTitle),
            content: Text(l10n.hajjJourneyNextStepBody),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n.hajjJourneyStayHere),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l10n.hajjJourneyGoNext),
              ),
            ],
          ),
        );

        if (goNext == true && context.mounted) {
          context.pushReplacement(
            AppRoutes.hajjRitualDetailPath(nextStep.step.ritualKey),
          );
          return;
        }
      }

      if (context.mounted) {
        context.pop();
      }
    } finally {
      if (mounted) {
        setState(() => _isCompleting = false);
      }
    }
  }
}
