import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/competitions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_page_constraint.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_quiz_feedback_banner.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_quiz_option_card.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_quiz_ordering_list.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_quiz_top_bar.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class CompetitionQuizScreen extends ConsumerStatefulWidget {
  const CompetitionQuizScreen({required this.competitionId, super.key});

  final String competitionId;

  @override
  ConsumerState<CompetitionQuizScreen> createState() =>
      _CompetitionQuizScreenState();
}

class _CompetitionQuizScreenState extends ConsumerState<CompetitionQuizScreen> {
  CompetitionQuestion? _activeQuestion;
  CompetitionAnswerResult? _lastResult;
  String? _selectedOptionId;
  List<String> _orderingOptionIds = [];
  String? _preparedOrderingQuestionId;
  bool _isSubmitting = false;

  static const _optionLetters = ['A', 'B', 'C', 'D', 'E', 'F'];

  String _optionLabel(AppLocalizations l10n, String raw) {
    return switch (raw) {
      'true' => l10n.competitionAnswerTrue,
      'false' => l10n.competitionAnswerFalse,
      _ => raw,
    };
  }

  void _syncActiveQuestion(CompetitionQuizProgress progress) {
    if (_activeQuestion != null &&
        !progress.answeredQuestionIds.contains(_activeQuestion!.id)) {
      return;
    }

    if (_lastResult != null && _activeQuestion != null) {
      return;
    }

    _activeQuestion = progress.nextQuestion;
    _prepareOrderingQuestion(_activeQuestion);
  }

  void _prepareOrderingQuestion(CompetitionQuestion? question) {
    if (question == null || !question.questionType.isOrdering) {
      _preparedOrderingQuestionId = null;
      _orderingOptionIds = [];
      return;
    }

    if (_preparedOrderingQuestionId == question.id) {
      return;
    }

    _preparedOrderingQuestionId = question.id;
    final ids = question.options.map((option) => option.id).toList();
    if (_lastResult == null) {
      ids.shuffle(Random(question.id.hashCode));
    }
    _orderingOptionIds = ids;
  }

  void _reorderOrdering(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    setState(() {
      final id = _orderingOptionIds.removeAt(oldIndex);
      _orderingOptionIds.insert(newIndex, id);
    });
  }

  int _questionIndex(CompetitionQuizProgress progress, CompetitionQuestion question) {
    return progress.questions.indexWhere((q) => q.id == question.id);
  }

  Future<void> _submitAnswer() async {
    final question = _activeQuestion;
    if (question == null || _isSubmitting) {
      return;
    }

    if (question.questionType.isOrdering) {
      if (_orderingOptionIds.length != question.options.length) {
        return;
      }
    } else if (_selectedOptionId == null) {
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final repo = ref.read(competitionQuestionsRepositoryProvider);
      final CompetitionAnswerResult result;

      if (question.questionType.isOrdering) {
        result = await repo.submitOrderingAnswer(
          questionId: question.id,
          orderedOptionIds: _orderingOptionIds,
        );
      } else {
        result = await repo.submitAnswer(
          questionId: question.id,
          optionId: _selectedOptionId!,
        );
      }

      if (!mounted) {
        return;
      }

      setState(() {
        _isSubmitting = false;
        _lastResult = result;
        if (question.questionType.isOrdering &&
            result.correctOptionIds.isNotEmpty) {
          _orderingOptionIds = List<String>.from(result.correctOptionIds);
        }
      });

      ref.invalidate(competitionQuizProgressProvider(widget.competitionId));
      ref.invalidate(competitionDetailProvider(widget.competitionId));
    } on CompetitionsException {
      if (!mounted) {
        return;
      }
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).competitionQuizSubmitError)),
      );
    }
  }

  Future<void> _continueToNext() async {
    setState(() {
      _lastResult = null;
      _selectedOptionId = null;
      _preparedOrderingQuestionId = null;
      _orderingOptionIds = [];
    });

    final progress = await ref.refresh(
      competitionQuizProgressProvider(widget.competitionId).future,
    );

    if (!mounted) {
      return;
    }

    setState(() => _activeQuestion = progress.nextQuestion);
  }

  bool _canSubmit(CompetitionQuestion? question) {
    if (_isSubmitting || question == null || _lastResult != null) {
      return false;
    }
    if (question.questionType.isOrdering) {
      return _orderingOptionIds.length == question.options.length;
    }
    return _selectedOptionId != null;
  }

  CompetitionQuizOptionState _optionState({
    required String optionId,
    required bool isFeedback,
  }) {
    if (!isFeedback) {
      return _selectedOptionId == optionId
          ? CompetitionQuizOptionState.selected
          : CompetitionQuizOptionState.idle;
    }

    final result = _lastResult;
    if (result == null) {
      return CompetitionQuizOptionState.idle;
    }

    if (result.correctOptionId == optionId) {
      return CompetitionQuizOptionState.revealCorrect;
    }
    if (_selectedOptionId == optionId && !result.isCorrect) {
      return CompetitionQuizOptionState.incorrect;
    }

    return CompetitionQuizOptionState.idle;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final progressAsync =
        ref.watch(competitionQuizProgressProvider(widget.competitionId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: progressAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => Center(child: Text(l10n.competitionQuizLoadError)),
          data: (progress) {
            _syncActiveQuestion(progress);

            if (progress.totalQuestions == 0) {
              return Center(child: Text(l10n.competitionQuizNoQuestions));
            }

            if (progress.isComplete &&
                _activeQuestion == null &&
                _lastResult == null) {
              return _QuizCompleteView(
                l10n: l10n,
                answeredCount: progress.answeredCount,
                onDone: () => context.pop(),
              );
            }

            final question = _activeQuestion;
            if (question == null && _lastResult == null) {
              return _QuizCompleteView(
                l10n: l10n,
                answeredCount: progress.answeredCount,
                onDone: () => context.pop(),
              );
            }

            final questionIndex = question != null
                ? _questionIndex(progress, question)
                : progress.answeredCount;

            return CompetitionPageConstraint(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CompetitionQuizTopBar(
                    currentIndex: questionIndex.clamp(0, progress.totalQuestions - 1),
                    total: progress.totalQuestions,
                    onClose: () => context.pop(),
                  ),
                  Expanded(
                    child: question == null
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    question.questionType.isOrdering
                                        ? l10n.competitionQuizOrderingBadge(
                                            questionIndex + 1,
                                            progress.totalQuestions,
                                          )
                                        : l10n.competitionQuizQuestionBadge(
                                            questionIndex + 1,
                                            progress.totalQuestions,
                                          ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          color: AppColors.onSecondary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                DecoratedBox(
                                  decoration: AppDecorations.card(
                                    radius: AppDecorations.radiusLg,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(20.w),
                                    child: Text(
                                      question.prompt,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            height: 1.35,
                                          ),
                                    ),
                                  ),
                                ),
                                if (question.questionType.isOrdering) ...[
                                  SizedBox(height: 8.h),
                                  Text(
                                    l10n.competitionOrderingHint,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                  ),
                                ],
                                SizedBox(height: 12.h),
                                Expanded(
                                  child: question.questionType.isOrdering
                                      ? CompetitionQuizOrderingList(
                                          optionsById: {
                                            for (final option
                                                in question.options)
                                              option.id: option,
                                          },
                                          orderedOptionIds: _orderingOptionIds,
                                          onReorder: _reorderOrdering,
                                          isFeedback: _lastResult != null,
                                          feedbackCorrectIds:
                                              _lastResult?.correctOptionIds,
                                        )
                                      : ListView.separated(
                                          itemCount: question.options.length,
                                          separatorBuilder: (_, _) =>
                                              SizedBox(height: 10.h),
                                          itemBuilder: (context, index) {
                                            final option =
                                                question.options[index];
                                            final isFeedback =
                                                _lastResult != null;

                                            return CompetitionQuizOptionCard(
                                              letter: _optionLetters[index %
                                                  _optionLetters.length],
                                              label: _optionLabel(
                                                l10n,
                                                option.label,
                                              ),
                                              state: _optionState(
                                                optionId: option.id,
                                                isFeedback: isFeedback,
                                              ),
                                              onTap: isFeedback || _isSubmitting
                                                  ? null
                                                  : () => setState(
                                                        () => _selectedOptionId =
                                                            option.id,
                                                      ),
                                            );
                                          },
                                        ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  if (_lastResult != null)
                    CompetitionQuizFeedbackBanner(
                      isCorrect: _lastResult!.isCorrect,
                      title: _lastResult!.isCorrect
                          ? l10n.competitionQuizCorrect(
                              _lastResult!.pointsAwarded,
                            )
                          : l10n.competitionQuizIncorrect,
                      explanation: _lastResult!.explanation,
                      actionLabel: l10n.competitionQuizContinue,
                      onAction: () => unawaited(_continueToNext()),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                      child: FilledButton(
                        onPressed: _canSubmit(question) ? _submitAnswer : null,
                        style: FilledButton.styleFrom(
                          minimumSize: Size(double.infinity, 52.h),
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDecorations.radiusMd,
                            ),
                          ),
                        ),
                        child: _isSubmitting
                            ? SizedBox(
                                width: 22.w,
                                height: 22.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.onPrimary,
                                ),
                              )
                            : Text(
                                l10n.competitionQuizSubmit,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _QuizCompleteView extends StatelessWidget {
  const _QuizCompleteView({
    required this.l10n,
    required this.answeredCount,
    required this.onDone,
  });

  final AppLocalizations l10n;
  final int answeredCount;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return CompetitionPageConstraint(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: 0.3),
                    AppColors.secondary,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                Icons.emoji_events_rounded,
                size: 56.sp,
                color: AppColors.onSecondary,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              l10n.competitionQuizComplete,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              l10n.competitionQuizCompleteSummary(answeredCount),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28.h),
            FilledButton(
              onPressed: onDone,
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 52.h),
              ),
              child: Text(l10n.competitionQuizDone),
            ),
          ],
        ),
      ),
    );
  }
}
