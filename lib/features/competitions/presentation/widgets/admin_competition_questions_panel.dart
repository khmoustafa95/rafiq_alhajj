import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_layout.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/admin_competition_question_editor_dialog.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class AdminCompetitionQuestionsPanel extends ConsumerWidget {
  const AdminCompetitionQuestionsPanel({
    required this.competitionId,
    super.key,
  });

  final String competitionId;

  Future<void> _openEditor(
    BuildContext context,
    WidgetRef ref, {
    CompetitionQuestion? question,
    int sortOrder = 0,
  }) async {
    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => AdminCompetitionQuestionEditorDialog(
        competitionId: competitionId,
        question: question,
        sortOrder: question?.sortOrder ?? sortOrder,
      ),
    );

    if (saved == true) {
      ref.invalidate(adminCompetitionQuestionsProvider(competitionId));
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    CompetitionQuestion question,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.adminCompetitionQuestionDeleteTitle),
        content: Text(l10n.adminCompetitionQuestionDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.dialogCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.adminCompetitionQuestionDeleteConfirm),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final ok = await ref
        .read(adminCompetitionQuestionDeleteProvider.notifier)
        .delete(competitionId: competitionId, questionId: question.id);

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? l10n.adminCompetitionQuestionDeleteSuccess
              : l10n.adminCompetitionQuestionDeleteError,
        ),
      ),
    );
  }

  String _typeLabel(AppLocalizations l10n, CompetitionQuestionType type) {
    return switch (type) {
      CompetitionQuestionType.multipleChoice =>
        l10n.adminCompetitionQuestionTypeMultipleChoice,
      CompetitionQuestionType.trueFalse =>
        l10n.adminCompetitionQuestionTypeTrueFalse,
      CompetitionQuestionType.ordering =>
        l10n.adminCompetitionQuestionTypeOrdering,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final questionsAsync =
        ref.watch(adminCompetitionQuestionsProvider(competitionId));

    return StaffFormSection(
      icon: Icons.quiz_outlined,
      title: l10n.adminCompetitionQuestionsTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: FilledButton.icon(
              onPressed: () {
                final count = questionsAsync.value?.length ?? 0;
                unawaited(_openEditor(context, ref, sortOrder: count));
              },
              icon: const Icon(Icons.add_rounded),
              label: Text(l10n.adminCompetitionQuestionAdd),
            ),
          ),
          SizedBox(height: 12.h),
          questionsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => Text(l10n.adminCompetitionQuestionsLoadError),
            data: (questions) {
              if (questions.isEmpty) {
                return Text(l10n.adminCompetitionQuestionsEmpty);
              }

              return Column(
                children: [
                  for (final question in questions)
                    Card(
                      margin: EdgeInsets.only(bottom: 8.h),
                      child: ListTile(
                        title: Text(question.prompt),
                        subtitle: Text(
                          '${_typeLabel(l10n, question.questionType)} · '
                          '${l10n.adminCompetitionQuestionPoints(question.points)}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => unawaited(
                                _openEditor(context, ref, question: question),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => unawaited(
                                _confirmDelete(context, ref, question),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
