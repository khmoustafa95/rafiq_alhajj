import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_leaderboard_panel.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_learning_path.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_page_constraint.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_progress_header.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class CompetitionDetailScreen extends ConsumerWidget {
  const CompetitionDetailScreen({required this.competitionId, super.key});

  final String competitionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final detailAsync = ref.watch(competitionDetailProvider(competitionId));
    final quizProgressAsync =
        ref.watch(competitionQuizProgressProvider(competitionId));
    final profileId = ref.watch(authProfileIdProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.competitionsLoadError)),
        data: (data) {
          if (data == null) {
            return Center(child: Text(l10n.competitionNotFound));
          }

          final comp = data.competition;
          final myEntry = data.myEntry;

          return quizProgressAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => Center(child: Text(l10n.competitionQuizLoadError)),
            data: (progress) {
              return CompetitionPageConstraint(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: CompetitionProgressHeader(
                        title: comp.title,
                        description: comp.description,
                        answeredCount: progress.answeredCount,
                        totalQuestions: progress.totalQuestions,
                        score: myEntry?.score,
                        onBack: Navigator.canPop(context)
                            ? () => context.pop()
                            : null,
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          _CompetitionActionsCard(
                            competitionId: competitionId,
                            isOpen: comp.isOpen,
                            myEntry: myEntry,
                            progress: progress,
                            l10n: l10n,
                          ),
                          SizedBox(height: 20.h),
                          CompetitionLearningPath(
                            questions: progress.questions,
                            answeredQuestionIds: progress.answeredQuestionIds,
                            onLessonTap: (_) => _openQuiz(context),
                            onLockedTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.competitionLessonLocked),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20.h),
                          CompetitionLeaderboardPanel(
                            entries: data.entries,
                            highlightProfileId: profileId,
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _openQuiz(BuildContext context) {
    unawaited(context.push(AppRoutes.competitionQuizPath(competitionId)));
  }
}

class _CompetitionActionsCard extends ConsumerWidget {
  const _CompetitionActionsCard({
    required this.competitionId,
    required this.isOpen,
    required this.myEntry,
    required this.progress,
    required this.l10n,
  });

  final String competitionId;
  final bool isOpen;
  final CompetitionEntry? myEntry;
  final CompetitionQuizProgress progress;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPilgrim =
        ref.watch(authAccessModeProvider) == AppAccessMode.pilgrim;

    if (!isOpen) {
      return _InfoCard(
        icon: Icons.schedule_rounded,
        message: l10n.competitionClosed,
      );
    }

    if (!isPilgrim) {
      return _InfoCard(
        icon: Icons.login_rounded,
        message: l10n.competitionSignInRequired,
      );
    }

    if (myEntry == null) {
      return DecoratedBox(
        decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.competitionJoinPrompt,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 12.h),
              FilledButton.icon(
                onPressed: () => _join(context, ref),
                icon: const Icon(Icons.flag_rounded),
                label: Text(l10n.competitionJoin),
              ),
            ],
          ),
        ),
      );
    }

    final hasQuestions = progress.totalQuestions > 0;
    final isComplete = progress.isComplete;

    return DecoratedBox(
      decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!hasQuestions)
              Text(l10n.competitionQuizNoQuestions)
            else
              FilledButton.icon(
                onPressed: () => unawaited(
                  context.push(AppRoutes.competitionQuizPath(competitionId)),
                ),
                icon: Icon(
                  isComplete
                      ? Icons.replay_rounded
                      : progress.answeredCount == 0
                          ? Icons.play_arrow_rounded
                          : Icons.bolt_rounded,
                ),
                label: Text(
                  isComplete
                      ? l10n.competitionQuizReview
                      : progress.answeredCount == 0
                          ? l10n.competitionQuizStart
                          : l10n.competitionQuizContinue,
                ),
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 48.h),
                  backgroundColor: AppColors.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _join(BuildContext context, WidgetRef ref) async {
    final ok = await ref
        .read(competitionDetailProvider(competitionId).notifier)
        .join();

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? l10n.competitionJoinSuccess : l10n.competitionJoinError,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.message,
  });

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: AppDecorations.card(
        color: AppColors.surfaceMuted,
        radius: AppDecorations.radiusLg,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary),
            SizedBox(width: 12.w),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}
