import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CompetitionQuestionOptionField {
  CompetitionQuestionOptionField({
    required this.control,
    required this.isCorrect,
  });

  final FormControl<String> control;
  bool isCorrect;
}

/// Dynamic answer options section for the admin competition question editor.
class AdminCompetitionQuestionOptionsEditor extends StatelessWidget {
  const AdminCompetitionQuestionOptionsEditor({
    required this.questionType,
    required this.optionFields,
    required this.isSaving,
    required this.onReorder,
    required this.onAddOrderingStep,
    required this.onRemoveOrderingStep,
    required this.onSetCorrectIndex,
    super.key,
  });

  final CompetitionQuestionType questionType;
  final List<CompetitionQuestionOptionField> optionFields;
  final bool isSaving;
  final void Function(int oldIndex, int newIndex) onReorder;
  final VoidCallback onAddOrderingStep;
  final ValueChanged<int> onRemoveOrderingStep;
  final ValueChanged<int> onSetCorrectIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          questionType == CompetitionQuestionType.ordering
              ? l10n.adminCompetitionQuestionOrderingStepsLabel
              : l10n.adminCompetitionQuestionOptionsLabel,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        if (questionType == CompetitionQuestionType.ordering) ...[
          SizedBox(height: 4.h),
          Text(
            l10n.adminCompetitionQuestionOrderingStepsHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
        SizedBox(height: 8.h),
        if (questionType == CompetitionQuestionType.ordering)
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            onReorder: isSaving ? (_, _) {} : onReorder,
            buildDefaultDragHandles: !isSaving,
            itemCount: optionFields.length,
            itemBuilder: (context, index) {
              final field = optionFields[index];
              return Padding(
                key: ValueKey('ordering-step-$index'),
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ReactiveTextField<String>(
                        formControl: field.control,
                        decoration: InputDecoration(
                          labelText: l10n.adminCompetitionQuestionStepLabel(
                            index + 1,
                          ),
                        ),
                        validationMessages: {
                          'optionRequired': (_) =>
                              l10n.adminCompetitionQuestionOptionRequired,
                        },
                      ),
                    ),
                    if (optionFields.length > 3)
                      IconButton(
                        onPressed:
                            isSaving ? null : () => onRemoveOrderingStep(index),
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                  ],
                ),
              );
            },
          )
        else if (questionType == CompetitionQuestionType.trueFalse)
          RadioGroup<int>(
            groupValue: optionFields.indexWhere((o) => o.isCorrect),
            onChanged: (value) {
              if (isSaving || value == null) {
                return;
              }
              onSetCorrectIndex(value);
            },
            child: Column(
              children: [
                RadioListTile<int>(
                  value: 0,
                  enabled: !isSaving,
                  title: Text(l10n.competitionAnswerTrue),
                ),
                RadioListTile<int>(
                  value: 1,
                  enabled: !isSaving,
                  title: Text(l10n.competitionAnswerFalse),
                ),
              ],
            ),
          )
        else
          RadioGroup<int>(
            groupValue: optionFields.indexWhere((o) => o.isCorrect),
            onChanged: (value) {
              if (isSaving || value == null) {
                return;
              }
              onSetCorrectIndex(value);
            },
            child: Column(
              children: [
                for (var index = 0; index < optionFields.length; index++)
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      children: [
                        Radio<int>(
                          value: index,
                          enabled: !isSaving,
                        ),
                        Expanded(
                          child: ReactiveTextField<String>(
                            formControl: optionFields[index].control,
                            decoration: InputDecoration(
                              labelText:
                                  l10n.adminCompetitionQuestionOptionLabel(
                                index + 1,
                              ),
                            ),
                            validationMessages: {
                              'optionRequired': (_) =>
                                  l10n.adminCompetitionQuestionOptionRequired,
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        if (questionType == CompetitionQuestionType.ordering &&
            optionFields.length < 8)
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton.icon(
              onPressed: isSaving ? null : onAddOrderingStep,
              icon: const Icon(Icons.add_rounded),
              label: Text(l10n.adminCompetitionQuestionAddStep),
            ),
          ),
      ],
    );
  }
}
